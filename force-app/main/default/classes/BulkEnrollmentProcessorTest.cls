@isTest
private class BulkEnrollmentProcessorTest {
    
    @TestSetup
    static void setupTestData() {
        
        // Get valid picklist value for Term
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        String validTerm = ple[0].getValue();
        
        Academic_Program__c program = new Academic_Program__c(
            Name = 'Computer Science',
            Program_Code__c = 'CS',
            Degree_Type__c = 'Bachelor',
            Department__c = 'Engineering'
        );
        insert program;
        
        Course__c prereqCourse = new Course__c(
            Name = 'Intro to Programming',
            Course_Code__c = 'CS-101',
            Credits__c = 3,
            Description__c = 'Prerequisite course'
        );
        insert prereqCourse;
        
        Course__c advancedCourse = new Course__c(
            Name = 'Advanced Programming',
            Course_Code__c = 'CS-201',
            Credits__c = 3,
            Description__c = 'Advanced course'
        );
        insert advancedCourse;
        
        Course_Offering__c prereqOffering = new Course_Offering__c(
            Course__c = prereqCourse.Id,
            Term__c = validTerm,
            Section__c = 'A',
            Max_Enrollment__c = 50,
            Instructor__c = 'Dr. Smith',
            Start_Date__c = Date.today().addDays(-90),
            End_Date__c = Date.today().addDays(-30)
        );
        insert prereqOffering;
        
        Course_Offering__c advancedOffering = new Course_Offering__c(
            Course__c = advancedCourse.Id,
            Term__c = validTerm,
            Section__c = 'A',
            Max_Enrollment__c = 50,
            Instructor__c = 'Dr. Johnson',
            Start_Date__c = Date.today().addDays(30),
            End_Date__c = Date.today().addDays(120)
        );
        insert advancedOffering;
        
        List<Student__c> students = new List<Student__c>();
        for (Integer i = 1; i <= 30; i++) {
            students.add(new Student__c(
                First_Name__c = 'Test',
                Last_Name__c = 'Student' + i,
                Email__c = 'test.student' + i + '@university.edu',
                Student_ID__c = 'STU-' + String.valueOf(i).leftPad(4, '0'),
                Status__c = 'Active',
                Academic_Program__c = program.Id,
                Enrollment_Date__c = Date.today().addDays(-90)
            ));
        }
        insert students;
        
        List<Enrollment__c> completedEnrollments = new List<Enrollment__c>();
        for (Integer i = 0; i < 30; i++) {
            String grade;
            if (i < 20) {
                grade = 'A';
            } else if (i < 25) {
                grade = 'B';
            } else if (i < 28) {
                grade = 'C';
            } else {
                grade = 'D';
            }
            
            completedEnrollments.add(new Enrollment__c(
                Student__c = students[i].Id,
                Course_Offering__c = prereqOffering.Id,
                Status__c = 'Completed',
                Grade__c = grade,
                Enrollment_Date__c = Date.today().addDays(-90)
            ));
        }
        insert completedEnrollments;
    }
    
    @isTest
    static void testEnrollFromPrerequisite() {
        
        Course__c prereqCourse = [SELECT Id FROM Course__c WHERE Course_Code__c = 'CS-101'];
        Course_Offering__c advancedOffering = [SELECT Id FROM Course_Offering__c WHERE Course__r.Course_Code__c = 'CS-201'];
        
        Integer studentsBefore = [SELECT COUNT() FROM Enrollment__c WHERE Course_Offering__c = :advancedOffering.Id];
        System.assertEquals(0, studentsBefore, 'Should start with 0');
        
        Test.startTest();
        BulkEnrollmentProcessor.enrollFromPrerequisite(advancedOffering.Id, prereqCourse.Id, 'C');
        Test.stopTest();
        
        Integer studentsAfter = [SELECT COUNT() FROM Enrollment__c WHERE Course_Offering__c = :advancedOffering.Id];
        System.assert(studentsAfter > 0, 'Should enroll students with C or higher');
    }
    
    @isTest
    static void testDuplicatePrevention() {
        
        Course__c prereqCourse = [SELECT Id FROM Course__c WHERE Course_Code__c = 'CS-101'];
        Course_Offering__c advancedOffering = [SELECT Id FROM Course_Offering__c WHERE Course__r.Course_Code__c = 'CS-201'];
        
        Test.startTest();
        BulkEnrollmentProcessor.enrollFromPrerequisite(advancedOffering.Id, prereqCourse.Id, 'C');
        Integer countAfterFirst = [SELECT COUNT() FROM Enrollment__c WHERE Course_Offering__c = :advancedOffering.Id];
        
        BulkEnrollmentProcessor.enrollFromPrerequisite(advancedOffering.Id, prereqCourse.Id, 'C');
        Integer countAfterSecond = [SELECT COUNT() FROM Enrollment__c WHERE Course_Offering__c = :advancedOffering.Id];
        Test.stopTest();
        
        System.assertEquals(countAfterFirst, countAfterSecond, 'Should not create duplicates');
    }
    
    @isTest
    static void testBulkEnroll() {
        
        List<Student__c> students = [SELECT Id FROM Student__c LIMIT 10];
        List<Course_Offering__c> offerings = [SELECT Id FROM Course_Offering__c];
        
        Set<Id> studentIds = new Set<Id>();
        Set<Id> courseIds = new Set<Id>();
        
        for (Student__c s : students) studentIds.add(s.Id);
        for (Course_Offering__c c : offerings) courseIds.add(c.Id);
        
        Test.startTest();
        BulkEnrollmentProcessor.bulkEnroll(studentIds, courseIds);
        Test.stopTest();
        
        Integer newEnrollments = [SELECT COUNT() FROM Enrollment__c WHERE Student__c IN :studentIds AND Course_Offering__c IN :courseIds];
        System.assert(newEnrollments > 0, 'Should create enrollments');
    }
    
    @isTest
    static void testEnrollmentStats() {
        
        // Get the same valid term used in setup
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        String validTerm = ple[0].getValue();
        
        // Get students and advanced offering from setup
        List<Student__c> students = [SELECT Id FROM Student__c LIMIT 5];
        Course_Offering__c offering = [SELECT Id FROM Course_Offering__c WHERE Course__r.Course_Code__c = 'CS-201' LIMIT 1];
        
        Set<Id> sIds = new Set<Id>();
        for(Student__c s : students) sIds.add(s.Id);
        
        Test.startTest();
        
        // Create enrollments so there's data to aggregate
        BulkEnrollmentProcessor.bulkEnroll(sIds, new Set<Id>{offering.Id});
        
        // Now call the stats method
        Map<String, Integer> stats = BulkEnrollmentProcessor.getEnrollmentStatsByTerm(validTerm);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, stats, 'Stats should not be null');
        System.assert(stats.size() > 0, 'Should have at least one course in stats after enrollment');
    }
}