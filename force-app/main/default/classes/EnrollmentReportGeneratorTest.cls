@isTest
private class EnrollmentReportGeneratorTest {
    
    @TestSetup
    static void setupTestData() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Academic_Program__c program = new Academic_Program__c(
            Name = 'Test Program',
            Program_Code__c = 'TEST',
            Degree_Type__c = 'Bachelor',
            Department__c = 'Testing'
        );
        insert program;
        
        Course__c course = new Course__c(
            Name = 'Test Course',
            Course_Code__c = 'TEST-101',
            Credits__c = 3
        );
        insert course;
        
        Course_Offering__c offering = new Course_Offering__c(
            Course__c = course.Id,
            Term__c = validTerm,
            Section__c = 'A',
            Max_Enrollment__c = 20,
            Instructor__c = 'Test Prof',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(90)
        );
        insert offering;
        
        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 5; i++) {
            students.add(new Student__c(
                First_Name__c = 'Test',
                Last_Name__c = 'Student' + i,
                Email__c = 'test' + i + '@test.com',
                Student_ID__c = 'T' + i,
                Status__c = 'Active',
                Academic_Program__c = program.Id,
                Enrollment_Date__c = Date.today()
            ));
        }
        insert students;
        
        List<Enrollment__c> enrollments = new List<Enrollment__c>();
        for (Student__c s : students) {
            enrollments.add(new Enrollment__c(
                Student__c = s.Id,
                Course_Offering__c = offering.Id,
                Status__c = 'Enrolled',
                Enrollment_Date__c = Date.today()
            ));
        }
        insert enrollments;
    }
    
    @isTest
    static void testQueueableExecution() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        
        Id jobId = EnrollmentReportGenerator.generateReport(validTerm);
        
        Test.stopTest();
        
        System.assertNotEquals(null, jobId, 'Job ID should not be null');
    }
    
    @isTest
    static void testQueueableWithCSVFormat() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        
        Id jobId = EnrollmentReportGenerator.generateReport(validTerm, 'CSV');
        
        Test.stopTest();
        
        System.assertNotEquals(null, jobId, 'Job ID should not be null');
    }
    
    @isTest
    static void testQueueableWithTextFormat() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        
        Id jobId = EnrollmentReportGenerator.generateReport(validTerm, 'TEXT');
        
        Test.stopTest();
        
        System.assertNotEquals(null, jobId, 'Job ID should not be null');
    }
}