public class AdvancedSOQLQueries {
    
    /**
     * Aggregate Query - Get enrollment counts by course
     */
    public static Map<String, Integer> getEnrollmentCountsByCourse(String term) {
        
        Map<String, Integer> courseCounts = new Map<String, Integer>();
        
        AggregateResult[] results = [
            SELECT Course_Offering__r.Course__r.Name courseName,
                   COUNT(Id) enrollmentCount
            FROM Enrollment__c
            WHERE Course_Offering__r.Term__c = :term
            GROUP BY Course_Offering__r.Course__r.Name
            HAVING COUNT(Id) > 0
            ORDER BY COUNT(Id) DESC
        ];
        
        for (AggregateResult ar : results) {
            String name = (String)ar.get('courseName');
            Integer count = (Integer)ar.get('enrollmentCount');
            courseCounts.put(name, count);
        }
        
        return courseCounts;
    }
    
    /**
     * Aggregate Query - Get average GPA by program
     */
    public static Map<String, Decimal> getAverageGPAByProgram() {
        
        Map<String, Decimal> programGPAs = new Map<String, Decimal>();
        
        AggregateResult[] results = [
            SELECT Academic_Program__r.Name programName,
                   AVG(GPA__c) avgGPA
            FROM Student__c
            WHERE GPA__c != null
            AND Status__c = 'Active'
            GROUP BY Academic_Program__r.Name
        ];
        
        for (AggregateResult ar : results) {
            String program = (String)ar.get('programName');
            Decimal avgGPA = (Decimal)ar.get('avgGPA');
            programGPAs.put(program, avgGPA.setScale(2));
        }
        
        return programGPAs;
    }
    
    /**
     * Subquery - Get students with their enrollments
     */
    public static List<Student__c> getStudentsWithEnrollments(String term) {
        
        return [
            SELECT Id, 
                   First_Name__c, 
                   Last_Name__c,
                   Email__c,
                   (SELECT Id, 
                           Status__c, 
                           Grade__c,
                           Course_Offering__r.Course__r.Name,
                           Course_Offering__r.Term__c
                    FROM Enrollments__r
                    WHERE Course_Offering__r.Term__c = :term
                    ORDER BY Course_Offering__r.Course__r.Name)
            FROM Student__c
            WHERE Status__c = 'Active'
            AND Id IN (SELECT Student__c 
                      FROM Enrollment__c 
                      WHERE Course_Offering__r.Term__c = :term)
            ORDER BY Last_Name__c
            LIMIT 100
        ];
    }
    
    /**
     * Parent Query - Get courses with their offerings
     */
    public static List<Course__c> getCoursesWithOfferings(String term) {
        
        return [
            SELECT Id,
                   Name,
                   Course_Code__c,
                   Credits__c,
                   (SELECT Id,
                           Term__c,
                           Section__c,
                           Instructor__c,
                           Max_Enrollment__c,
                           Current_Enrollment__c
                    FROM Course_Offerings__r
                    WHERE Term__c = :term
                    ORDER BY Section__c)
            FROM Course__c
            WHERE Id IN (SELECT Course__c 
                        FROM Course_Offering__c 
                        WHERE Term__c = :term)
            ORDER BY Name
        ];
    }
    
    /**
     * Dynamic SOQL - Build query based on filters
     */
    public static List<Enrollment__c> searchEnrollments(
        String status,
        String term,
        String courseCode,
        Integer limitCount
    ) {
        
        String query = 'SELECT Id, Student__r.First_Name__c, Student__r.Last_Name__c, ' +
                      'Course_Offering__r.Course__r.Name, Status__c, Grade__c ' +
                      'FROM Enrollment__c WHERE Id != null';
        
        if (status != null && status != '') {
            query += ' AND Status__c = :status';
        }
        
        if (term != null && term != '') {
            query += ' AND Course_Offering__r.Term__c = :term';
        }
        
        if (courseCode != null && courseCode != '') {
            query += ' AND Course_Offering__r.Course__r.Course_Code__c = :courseCode';
        }
        
        query += ' ORDER BY Student__r.Last_Name__c';
        
        if (limitCount != null && limitCount > 0) {
            query += ' LIMIT :limitCount';
        } else {
            query += ' LIMIT 100';
        }
        
        return Database.query(query);
    }
    
    /**
     * Aggregate with HAVING clause - Find popular courses
     */
    public static List<String> getPopularCourses(Integer minEnrollments) {
        
        List<String> popularCourses = new List<String>();
        
        AggregateResult[] results = [
            SELECT Course_Offering__r.Course__r.Name courseName,
                   COUNT(Id) enrollmentCount
            FROM Enrollment__c
            WHERE Status__c IN ('Enrolled', 'In Progress')
            GROUP BY Course_Offering__r.Course__r.Name
            HAVING COUNT(Id) >= :minEnrollments
            ORDER BY COUNT(Id) DESC
        ];
        
        for (AggregateResult ar : results) {
            popularCourses.add((String)ar.get('courseName'));
        }
        
        return popularCourses;
    }
    
    /**
     * Multiple aggregates in one query
     */
    public static Map<String, Map<String, Object>> getTermStatistics(String term) {
        
        Map<String, Map<String, Object>> stats = new Map<String, Map<String, Object>>();
        
        AggregateResult[] results = [
            SELECT Course_Offering__r.Course__r.Name courseName,
                   COUNT(Id) totalEnrollments,
                   COUNT_DISTINCT(Student__c) uniqueStudents,
                   AVG(Course_Offering__r.Course__r.Credits__c) avgCredits
            FROM Enrollment__c
            WHERE Course_Offering__r.Term__c = :term
            GROUP BY Course_Offering__r.Course__r.Name
        ];
        
        for (AggregateResult ar : results) {
            String course = (String)ar.get('courseName');
            Map<String, Object> courseStats = new Map<String, Object>();
            courseStats.put('totalEnrollments', ar.get('totalEnrollments'));
            courseStats.put('uniqueStudents', ar.get('uniqueStudents'));
            courseStats.put('avgCredits', ar.get('avgCredits'));
            stats.put(course, courseStats);
        }
        
        return stats;
    }
}