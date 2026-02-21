public with sharing class CourseEnrollmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Course_Offering__c> getCourseOfferings() {
        try {
            List<Course_Offering__c> offerings = [
                SELECT Id,
                       Term__c,
                       Section__c,
                       Instructor__c,
                       Meeting_Days__c,
                       Meeting_Time__c,
                       Location__c,
                       Max_Enrollment__c,
                       Current_Enrollment__c,
                       Start_Date__c,
                       End_Date__c,
                       Course__c,
                       Course__r.Name,
                       Course__r.Course_Code__c,
                       Course__r.Credits__c,
                       Course__r.Description__c
                FROM Course_Offering__c
                WHERE Id != null
                ORDER BY Term__c, Course__r.Name
                LIMIT 100
            ];
            
            return offerings;
            
        } catch (Exception e) {
            System.debug('Error in getCourseOfferings: ' + e.getMessage());
            throw new AuraHandledException('Error retrieving course offerings: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static String createEnrollment(Id courseOfferingId) {
        try {
            String userEmail = UserInfo.getUserEmail();
            
            List<Student__c> students = [
                SELECT Id, Email__c
                FROM Student__c
                WHERE Email__c = :userEmail
                LIMIT 1
            ];
            
            if (students.isEmpty()) {
                throw new AuraHandledException('No student record found for your email. Please contact your administrator.');
            }
            
            Student__c student = students[0];
            
            Course_Offering__c offering = [
                SELECT Id, 
                       Max_Enrollment__c,
                       Current_Enrollment__c,
                       Course__r.Name
                FROM Course_Offering__c
                WHERE Id = :courseOfferingId
                LIMIT 1
            ];
            
            List<Enrollment__c> existingEnrollments = [
                SELECT Id
                FROM Enrollment__c
                WHERE Student__c = :student.Id
                AND Course_Offering__c = :courseOfferingId
                AND Status__c NOT IN ('Dropped', 'Withdrawn')
                LIMIT 1
            ];
            
            if (!existingEnrollments.isEmpty()) {
                throw new AuraHandledException('You are already enrolled in this course.');
            }
            
            Decimal currentCount = offering.Current_Enrollment__c != null ? offering.Current_Enrollment__c : 0;
            Decimal maxCount = offering.Max_Enrollment__c != null ? offering.Max_Enrollment__c : 0;
            
            if (currentCount >= maxCount) {
                throw new AuraHandledException('This course is full. No seats available.');
            }
            
            Enrollment__c newEnrollment = new Enrollment__c(
                Student__c = student.Id,
                Course_Offering__c = courseOfferingId,
                Status__c = 'Enrolled',
                Enrollment_Date__c = Date.today()
            );
            
            insert newEnrollment;
            
            return 'Successfully enrolled in ' + offering.Course__r.Name + '!';
            
        } catch (AuraHandledException e) {
            throw e;
        } catch (Exception e) {
            System.debug('Error in createEnrollment: ' + e.getMessage());
            throw new AuraHandledException('Error creating enrollment: ' + e.getMessage());
        }
    }
}