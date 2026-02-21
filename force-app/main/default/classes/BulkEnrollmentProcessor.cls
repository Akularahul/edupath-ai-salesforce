/**
 * BulkEnrollmentProcessor
 * Demonstrates bulkification and collection usage
 * Handles mass enrollment scenarios efficiently
 */
public class BulkEnrollmentProcessor {
    
    /**
     * Enroll students from prerequisite course into new course
     * Bulkified to handle 200+ enrollments in one transaction
     * 
     * @param newCourseOfferingId - The new course to enroll students into
     * @param prerequisiteCourseId - The prerequisite course
     * @param minimumGrade - Minimum grade required (e.g. 'C')
     */
    public static void enrollFromPrerequisite(
        Id newCourseOfferingId, 
        Id prerequisiteCourseId,
        String minimumGrade
    ) {
        
        // ─────────────────────────────────────────────
        // STEP 1: Validate inputs
        // ─────────────────────────────────────────────
        if (newCourseOfferingId == null || prerequisiteCourseId == null) {
            throw new IllegalArgumentException('Course IDs cannot be null');
        }
        
        // ─────────────────────────────────────────────
        // STEP 2: Get new course details
        // ─────────────────────────────────────────────
        Course_Offering__c newCourseOffering = [
            SELECT Id, Max_Enrollment__c, Current_Enrollment__c
            FROM Course_Offering__c
            WHERE Id = :newCourseOfferingId
            LIMIT 1
        ];
        
        // ─────────────────────────────────────────────
        // STEP 3: Get all students who completed prerequisite
        // ONE SOQL query for ALL enrollments (bulkified!)
        // ─────────────────────────────────────────────
        List<Enrollment__c> completedEnrollments = [
            SELECT Id, 
                   Student__c,
                   Student__r.Email__c,
                   Grade__c,
                   Status__c
            FROM Enrollment__c
            WHERE Course_Offering__r.Course__c = :prerequisiteCourseId
            AND Status__c = 'Completed'
            AND Grade__c >= :minimumGrade
            LIMIT 200
        ];
        
        if (completedEnrollments.isEmpty()) {
            System.debug('No students found who completed prerequisite with grade ' + minimumGrade);
            return;
        }
        
        // ─────────────────────────────────────────────
        // STEP 4: Build Set of student IDs
        // Using Set for O(1) lookup performance
        // ─────────────────────────────────────────────
        Set<Id> qualifiedStudentIds = new Set<Id>();
        for (Enrollment__c enrollment : completedEnrollments) {
            qualifiedStudentIds.add(enrollment.Student__c);
        }
        
        // ─────────────────────────────────────────────
        // STEP 5: Check for existing enrollments
        // Prevent duplicates - ONE query for ALL students
        // ─────────────────────────────────────────────
        Set<Id> alreadyEnrolledStudentIds = new Set<Id>();
        
        List<Enrollment__c> existingEnrollments = [
            SELECT Student__c
            FROM Enrollment__c
            WHERE Course_Offering__c = :newCourseOfferingId
            AND Student__c IN :qualifiedStudentIds
        ];
        
        for (Enrollment__c existing : existingEnrollments) {
            alreadyEnrolledStudentIds.add(existing.Student__c);
        }
        
        // ─────────────────────────────────────────────
        // STEP 6: Build list of new enrollments
        // Only for students not already enrolled
        // ─────────────────────────────────────────────
        List<Enrollment__c> newEnrollments = new List<Enrollment__c>();
        
        for (Id studentId : qualifiedStudentIds) {
            // Skip if already enrolled
            if (alreadyEnrolledStudentIds.contains(studentId)) {
                continue;
            }
            
            // Create new enrollment
            Enrollment__c newEnrollment = new Enrollment__c(
                Student__c = studentId,
                Course_Offering__c = newCourseOfferingId,
                Status__c = 'Enrolled',
                Enrollment_Date__c = Date.today()
            );
            newEnrollments.add(newEnrollment);
        }
        
        // ─────────────────────────────────────────────
        // STEP 7: Check capacity
        // ─────────────────────────────────────────────
        Decimal currentEnrollment = newCourseOffering.Current_Enrollment__c != null 
            ? newCourseOffering.Current_Enrollment__c : 0;
        Decimal maxEnrollment = newCourseOffering.Max_Enrollment__c != null 
            ? newCourseOffering.Max_Enrollment__c : 0;
        Decimal availableSeats = maxEnrollment - currentEnrollment;
        
        if (newEnrollments.size() > availableSeats) {
            System.debug('Warning: Attempting to enroll ' + newEnrollments.size() + 
                        ' students but only ' + availableSeats + ' seats available');
            // Trim list to available seats
            newEnrollments = new List<Enrollment__c>();
            Integer count = 0;
            for (Id studentId : qualifiedStudentIds) {
                if (count >= availableSeats) break;
                if (!alreadyEnrolledStudentIds.contains(studentId)) {
                    newEnrollments.add(new Enrollment__c(
                        Student__c = studentId,
                        Course_Offering__c = newCourseOfferingId,
                        Status__c = 'Enrolled',
                        Enrollment_Date__c = Date.today()
                    ));
                    count++;
                }
            }
        }
        
        // ─────────────────────────────────────────────
        // STEP 8: Insert all enrollments
        // ONE DML statement for ALL records (bulkified!)
        // ─────────────────────────────────────────────
        if (!newEnrollments.isEmpty()) {
            try {
                insert newEnrollments;
                System.debug('Successfully enrolled ' + newEnrollments.size() + ' students');
            } catch (DmlException e) {
                System.debug('Error enrolling students: ' + e.getMessage());
                throw e;
            }
        } else {
            System.debug('No new students to enroll');
        }
    }
    
    /**
     * Enroll multiple students into multiple courses
     * Advanced bulkification - handles complex scenarios
     * 
     * @param studentIds - Set of student IDs to enroll
     * @param courseOfferingIds - Set of course offering IDs
     */
    public static void bulkEnroll(Set<Id> studentIds, Set<Id> courseOfferingIds) {
        
        // Validate inputs
        if (studentIds == null || studentIds.isEmpty() || 
            courseOfferingIds == null || courseOfferingIds.isEmpty()) {
            return;
        }
        
        // Get existing enrollments to prevent duplicates
        // ONE query for all combinations
        Set<String> existingEnrollmentKeys = new Set<String>();
        
        List<Enrollment__c> existing = [
            SELECT Student__c, Course_Offering__c
            FROM Enrollment__c
            WHERE Student__c IN :studentIds
            AND Course_Offering__c IN :courseOfferingIds
        ];
        
        for (Enrollment__c e : existing) {
            String key = String.valueOf(e.Student__c) + '-' + String.valueOf(e.Course_Offering__c);
            existingEnrollmentKeys.add(key);
        }
        
        // Build new enrollments
        List<Enrollment__c> newEnrollments = new List<Enrollment__c>();
        
        for (Id studentId : studentIds) {
            for (Id courseId : courseOfferingIds) {
                String key = String.valueOf(studentId) + '-' + String.valueOf(courseId);
                
                // Only create if doesn't exist
                if (!existingEnrollmentKeys.contains(key)) {
                    newEnrollments.add(new Enrollment__c(
                        Student__c = studentId,
                        Course_Offering__c = courseId,
                        Status__c = 'Enrolled',
                        Enrollment_Date__c = Date.today()
                    ));
                }
            }
        }
        
        // Insert all at once
        if (!newEnrollments.isEmpty()) {
            insert newEnrollments;
            System.debug('Bulk enrolled ' + newEnrollments.size() + ' student-course combinations');
        }
    }
    
    /**
     * Get enrollment statistics by term
     * Demonstrates aggregate SOQL
     * 
     * @param term - Term to analyze (e.g. 'Spring 2026')
     * @return Map of course name to enrollment count
     */
    public static Map<String, Integer> getEnrollmentStatsByTerm(String term) {
        
        Map<String, Integer> stats = new Map<String, Integer>();
        
        // Aggregate SOQL - COUNT enrollments by course
        AggregateResult[] results = [
            SELECT Course_Offering__r.Course__r.Name courseName,
                   COUNT(Id) enrollmentCount
            FROM Enrollment__c
            WHERE Course_Offering__r.Term__c = :term
            AND Status__c = 'Enrolled'
            GROUP BY Course_Offering__r.Course__r.Name
            ORDER BY COUNT(Id) DESC
        ];
        
        for (AggregateResult ar : results) {
            String courseName = (String)ar.get('courseName');
            Integer count = (Integer)ar.get('enrollmentCount');
            stats.put(courseName, count);
        }
        
        return stats;
    }
}