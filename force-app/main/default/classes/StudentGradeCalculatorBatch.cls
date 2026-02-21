global class StudentGradeCalculatorBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Integer studentsProcessed = 0;
    global Integer studentsUpdated = 0;
    global String termToProcess;
    
    global StudentGradeCalculatorBatch() {
        this(null);
    }
    
    global StudentGradeCalculatorBatch(String term) {
        this.termToProcess = term;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('Starting GPA calculation batch');
        return Database.getQueryLocator(
            'SELECT Id, First_Name__c, Last_Name__c, GPA__c ' +
            'FROM Student__c ' +
            'WHERE Status__c = \'Active\' ' +
            'ORDER BY Last_Name__c'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Student__c> scope) {
        
        Set<Id> studentIds = new Set<Id>();
        for (Student__c student : scope) {
            studentIds.add(student.Id);
        }
        
        String enrollmentQuery = 
            'SELECT Student__c, Grade__c, Course_Offering__r.Course__r.Credits__c ' +
            'FROM Enrollment__c ' +
            'WHERE Student__c IN :studentIds ' +
            'AND Status__c = \'Completed\' ' +
            'AND Grade__c != null';
        
        if (termToProcess != null) {
            enrollmentQuery += ' AND Course_Offering__r.Term__c = :termToProcess';
        }
        
        List<Enrollment__c> enrollments = Database.query(enrollmentQuery);
        
        Map<Id, List<Enrollment__c>> studentEnrollmentMap = new Map<Id, List<Enrollment__c>>();
        for (Enrollment__c enrollment : enrollments) {
            if (!studentEnrollmentMap.containsKey(enrollment.Student__c)) {
                studentEnrollmentMap.put(enrollment.Student__c, new List<Enrollment__c>());
            }
            studentEnrollmentMap.get(enrollment.Student__c).add(enrollment);
        }
        
        List<Student__c> studentsToUpdate = new List<Student__c>();
        
        for (Student__c student : scope) {
            studentsProcessed++;
            
            if (!studentEnrollmentMap.containsKey(student.Id)) {
                continue;
            }
            
            List<Enrollment__c> studentEnrollments = studentEnrollmentMap.get(student.Id);
            Decimal totalPoints = 0;
            Decimal totalCredits = 0;
            
            for (Enrollment__c enrollment : studentEnrollments) {
                Decimal gradePoints = getGradePoints(enrollment.Grade__c);
                Decimal credits = enrollment.Course_Offering__r?.Course__r?.Credits__c;
                
                if (credits == null) credits = 3;
                
                totalPoints += (gradePoints * credits);
                totalCredits += credits;
            }
            
            if (totalCredits > 0) {
                Decimal gpa = totalPoints / totalCredits;
                gpa = gpa.setScale(2);
                student.GPA__c = gpa;
                studentsToUpdate.add(student);
                studentsUpdated++;
            }
        }
        
        if (!studentsToUpdate.isEmpty()) {
            update studentsToUpdate;
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch completed. Processed: ' + studentsProcessed + ', Updated: ' + studentsUpdated);
        
        AsyncApexJob job = [
            SELECT Id, Status, NumberOfErrors
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()
        ];
        
        System.debug('Job Status: ' + job.Status + ', Errors: ' + job.NumberOfErrors);
    }
    
    private Decimal getGradePoints(String grade) {
        if (grade == null) return 0;
        
        switch on grade.toUpperCase() {
            when 'A' { return 4.0; }
            when 'A-' { return 3.7; }
            when 'B+' { return 3.3; }
            when 'B' { return 3.0; }
            when 'B-' { return 2.7; }
            when 'C+' { return 2.3; }
            when 'C' { return 2.0; }
            when 'C-' { return 1.7; }
            when 'D+' { return 1.3; }
            when 'D' { return 1.0; }
            when else { return 0.0; }
        }
    }
}