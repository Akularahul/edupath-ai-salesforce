public class EnrollmentReportGenerator implements Queueable {
    
    private String termToProcess;
    private String reportFormat;
    
    public EnrollmentReportGenerator(String term) {
        this(term, 'CSV');
    }
    
    public EnrollmentReportGenerator(String term, String format) {
        this.termToProcess = term;
        this.reportFormat = format;
    }
    
    public void execute(QueueableContext context) {
        
        System.debug('Starting enrollment report generation for term: ' + termToProcess);
        
        // Query enrollments for the term
        List<Enrollment__c> enrollments = [
            SELECT Id,
                   Student__r.First_Name__c,
                   Student__r.Last_Name__c,
                   Student__r.Email__c,
                   Student__r.Student_ID__c,
                   Course_Offering__r.Course__r.Name,
                   Course_Offering__r.Course__r.Course_Code__c,
                   Course_Offering__r.Term__c,
                   Course_Offering__r.Section__c,
                   Status__c,
                   Grade__c,
                   Enrollment_Date__c
            FROM Enrollment__c
            WHERE Course_Offering__r.Term__c = :termToProcess
            ORDER BY Student__r.Last_Name__c, Course_Offering__r.Course__r.Name
            LIMIT 1000
        ];
        
        if (enrollments.isEmpty()) {
            System.debug('No enrollments found for term: ' + termToProcess);
            return;
        }
        
        // Generate report content
        String reportContent = generateReportContent(enrollments);
        
        // Store report (simplified - just debug for now)
        System.debug('Report generated with ' + enrollments.size() + ' enrollments');
        System.debug('Report preview (first 500 chars): ' + reportContent.substring(0, Math.min(500, reportContent.length())));
        
        // In real implementation, you could:
        // - Create a Document record
        // - Send email with attachment
        // - Store in Salesforce Files
        // - Post to Chatter
    }
    
    private String generateReportContent(List<Enrollment__c> enrollments) {
        
        if (reportFormat == 'CSV') {
            return generateCSV(enrollments);
        } else {
            return generateText(enrollments);
        }
    }
    
    private String generateCSV(List<Enrollment__c> enrollments) {
        
        String csv = 'Student ID,First Name,Last Name,Email,Course Code,Course Name,Term,Section,Status,Grade,Enrollment Date\n';
        
        for (Enrollment__c e : enrollments) {
            csv += e.Student__r.Student_ID__c + ',';
            csv += e.Student__r.First_Name__c + ',';
            csv += e.Student__r.Last_Name__c + ',';
            csv += e.Student__r.Email__c + ',';
            csv += e.Course_Offering__r.Course__r.Course_Code__c + ',';
            csv += '"' + e.Course_Offering__r.Course__r.Name + '",';
            csv += e.Course_Offering__r.Term__c + ',';
            csv += e.Course_Offering__r.Section__c + ',';
            csv += e.Status__c + ',';
            csv += (e.Grade__c != null ? e.Grade__c : '') + ',';
            csv += String.valueOf(e.Enrollment_Date__c) + '\n';
        }
        
        return csv;
    }
    
    private String generateText(List<Enrollment__c> enrollments) {
        
        String report = 'ENROLLMENT REPORT - ' + termToProcess + '\n';
        report += 'Generated: ' + DateTime.now() + '\n';
        report += 'Total Enrollments: ' + enrollments.size() + '\n\n';
        
        for (Enrollment__c e : enrollments) {
            report += '─────────────────────────────────────────\n';
            report += 'Student: ' + e.Student__r.First_Name__c + ' ' + e.Student__r.Last_Name__c + '\n';
            report += 'Email: ' + e.Student__r.Email__c + '\n';
            report += 'Course: ' + e.Course_Offering__r.Course__r.Course_Code__c + ' - ' + e.Course_Offering__r.Course__r.Name + '\n';
            report += 'Section: ' + e.Course_Offering__r.Section__c + '\n';
            report += 'Status: ' + e.Status__c + '\n';
            if (e.Grade__c != null) {
                report += 'Grade: ' + e.Grade__c + '\n';
            }
            report += '\n';
        }
        
        return report;
    }
    
    // Helper method to enqueue the job
    public static Id generateReport(String term) {
        EnrollmentReportGenerator job = new EnrollmentReportGenerator(term);
        return System.enqueueJob(job);
    }
    
    public static Id generateReport(String term, String format) {
        EnrollmentReportGenerator job = new EnrollmentReportGenerator(term, format);
        return System.enqueueJob(job);
    }
}