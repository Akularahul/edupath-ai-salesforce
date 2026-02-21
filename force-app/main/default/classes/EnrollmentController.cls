public with sharing class EnrollmentController {
    
    /**
     * Get enrollments for the current user
     * Returns enrollment records with related course offering and course details
     */
    @AuraEnabled(cacheable=true)
    public static List<Enrollment__c> getEnrollments() {
        try {
            // Get current user's email
            String userEmail = UserInfo.getUserEmail();
            
            // Query enrollments with related data
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
                       Course_Offering__r.Course__r.Course_Code__c,
                       Student__c,
                       Student__r.Email__c
                FROM Enrollment__c
                WHERE Student__r.Email__c = :userEmail
                ORDER BY Enrollment_Date__c DESC
                LIMIT 100
            ];
            
            return enrollments;
            
        } catch (Exception e) {
            // Log error and throw AuraHandledException
            System.debug('Error in getEnrollments: ' + e.getMessage());
            throw new AuraHandledException('Error retrieving enrollments: ' + e.getMessage());
        }
    }
}