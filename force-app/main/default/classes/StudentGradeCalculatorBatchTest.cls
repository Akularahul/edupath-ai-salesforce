@isTest
private class StudentGradeCalculatorBatchTest {
    
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
            Start_Date__c = Date.today().addDays(-60),
            End_Date__c = Date.today().addDays(-10)
        );
        insert offering;
        
        List<Student__c> students = new List<Student__c>();
        for (Integer i = 0; i < 10; i++) {
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
        String[] grades = new String[]{'A', 'B', 'C', 'D'};
        for (Integer i = 0; i < 10; i++) {
            enrollments.add(new Enrollment__c(
                Student__c = students[i].Id,
                Course_Offering__c = offering.Id,
                Status__c = 'Completed',
                Grade__c = grades[Math.mod(i, 4)],
                Enrollment_Date__c = Date.today().addDays(-60)
            ));
        }
        insert enrollments;
    }
    
    @isTest
    static void testBatchExecution() {
        
        List<Student__c> studentsBefore = [SELECT GPA__c FROM Student__c];
        for (Student__c s : studentsBefore) {
            System.assertEquals(null, s.GPA__c, 'GPA should be null initially');
        }
        
        Test.startTest();
        StudentGradeCalculatorBatch batch = new StudentGradeCalculatorBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();
        
        List<Student__c> studentsAfter = [SELECT GPA__c FROM Student__c WHERE GPA__c != null];
        System.assert(studentsAfter.size() > 0, 'Should calculate GPA for students');
        
        for (Student__c s : studentsAfter) {
            System.assert(s.GPA__c >= 0 && s.GPA__c <= 4.0, 'GPA should be valid');
        }
    }
    
    @isTest
    static void testBatchWithTerm() {
        
        Schema.DescribeFieldResult fieldResult = Course_Offering__c.Term__c.getDescribe();
        String validTerm = fieldResult.getPicklistValues()[0].getValue();
        
        Test.startTest();
        StudentGradeCalculatorBatch batch = new StudentGradeCalculatorBatch(validTerm);
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Student__c> students = [SELECT GPA__c FROM Student__c WHERE GPA__c != null];
        System.assert(students.size() > 0, 'Should process students');
    }
}