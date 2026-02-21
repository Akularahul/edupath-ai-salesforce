public with sharing class EnrollmentSummaryController {
    
    /**
     * Get all enrollments for the current student
     * Used by Enrollment Summary component
     */
    @AuraEnabled(cacheable=true)
    public static List<Enrollment__c> getStudentEnrollments() {
        try {
            String userEmail = UserInfo.getUserEmail();
            
            List<Enrollment__c> enrollments = [
                SELECT Id,
                       Status__c,
                       Enrollment_Date__c,
                       Course_Offering__c,
                       Course_Offering__r.Term__c,
                       Course_Offering__r.Section__c,
                       Course_Offering__r.Instructor__c,
                       Course_Offering__r.Course__c,
                       Course_Offering__r.Course__r.Name,
                       Course_Offering__r.Course__r.Credits__c,
                       Course_Offering__r.Course__r.Course_Code__c,
                       Student__c,
                       Student__r.Email__c
                FROM Enrollment__c
                WHERE Student__r.Email__c = :userEmail
                ORDER BY Enrollment_Date__c DESC
                LIMIT 50
            ];
            
            return enrollments;
            
        } catch (Exception e) {
            System.debug('Error in getStudentEnrollments: ' + e.getMessage());
            throw new AuraHandledException('Error retrieving enrollments: ' + e.getMessage());
        }
    }
}