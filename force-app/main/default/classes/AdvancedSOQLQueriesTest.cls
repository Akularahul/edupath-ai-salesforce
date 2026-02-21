@isTest
private class AdvancedSOQLQueriesTest {
    
    @TestSetup
    static void setupTestData() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Academic_Program__c program = new Academic_Program__c(
            Name = 'Computer Science',
            Program_Code__c = 'CS',
            Degree_Type__c = 'Bachelor',
            Department__c = 'Engineering'
        );
        insert program;
        
        List<Course__c> courses = new List<Course__c>();
        for (Integer i = 1; i <= 3; i++) {
            courses.add(new Course__c(
                Name = 'Test Course ' + i,
                Course_Code__c = 'CS-10' + i,
                Credits__c = 3
            ));
        }
        insert courses;
        
        List<Course_Offering__c> offerings = new List<Course_Offering__c>();
        for (Course__c c : courses) {
            offerings.add(new Course_Offering__c(
                Course__c = c.Id,
                Term__c = validTerm,
                Section__c = 'A',
                Max_Enrollment__c = 20,
                Instructor__c = 'Test Prof',
                Start_Date__c = Date.today(),
                End_Date__c = Date.today().addDays(90)
            ));
        }
        insert offerings;
        
        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
            students.add(new Student__c(
                First_Name__c = 'Test',
                Last_Name__c = 'Student' + i,
                Email__c = 'test' + i + '@test.com',
                Student_ID__c = 'T' + i,
                Status__c = 'Active',
                Academic_Program__c = program.Id,
                Enrollment_Date__c = Date.today(),
                GPA__c = 3.0 + (Math.random() * 1.0)
            ));
        }
        insert students;
        
        List<Enrollment__c> enrollments = new List<Enrollment__c>();
        Integer offeringIndex = 0;
        for (Student__c s : students) {
            enrollments.add(new Enrollment__c(
                Student__c = s.Id,
                Course_Offering__c = offerings[offeringIndex].Id,
                Status__c = 'Enrolled',
                Enrollment_Date__c = Date.today()
            ));
            offeringIndex = Math.mod(offeringIndex + 1, offerings.size());
        }
        insert enrollments;
    }
    
    @isTest
    static void testEnrollmentCountsByCourse() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        Map<String, Integer> counts = AdvancedSOQLQueries.getEnrollmentCountsByCourse(validTerm);
        Test.stopTest();
        
        System.assertNotEquals(null, counts, 'Counts should not be null');
        System.assert(counts.size() > 0, 'Should have enrollment counts');
    }
    
    @isTest
    static void testAverageGPAByProgram() {
        
        Test.startTest();
        Map<String, Decimal> gpas = AdvancedSOQLQueries.getAverageGPAByProgram();
        Test.stopTest();
        
        System.assertNotEquals(null, gpas, 'GPAs should not be null');
        System.assert(gpas.size() > 0, 'Should have GPA data');
    }
    
    @isTest
    static void testStudentsWithEnrollments() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        List<Student__c> students = AdvancedSOQLQueries.getStudentsWithEnrollments(validTerm);
        Test.stopTest();
        
        System.assert(students.size() > 0, 'Should return students');
    }
    
    @isTest
    static void testCoursesWithOfferings() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        List<Course__c> courses = AdvancedSOQLQueries.getCoursesWithOfferings(validTerm);
        Test.stopTest();
        
        System.assert(courses.size() > 0, 'Should return courses');
    }
    
    @isTest
    static void testDynamicSOQL() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        List<Enrollment__c> enrollments = AdvancedSOQLQueries.searchEnrollments('Enrolled', validTerm, null, 50);
        Test.stopTest();
        
        System.assert(enrollments.size() > 0, 'Should find enrollments');
    }
    
    @isTest
    static void testPopularCourses() {
        
        Test.startTest();
        List<String> courses = AdvancedSOQLQueries.getPopularCourses(1);
        Test.stopTest();
        
        System.assert(courses.size() > 0, 'Should find popular courses');
    }
    
    @isTest
    static void testTermStatistics() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        Map<String, Map<String, Object>> stats = AdvancedSOQLQueries.getTermStatistics(validTerm);
        Test.stopTest();
        
        System.assertNotEquals(null, stats, 'Stats should not be null');
    }
}