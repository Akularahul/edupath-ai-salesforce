---

## 🎓 Day 4: Approval Processes

**Time:** 45 minutes  
**Status:** ✅ Complete

### Approval Process Created

**Name:** Course Override Approval  
**Object:** Enrollment__c  
**Status:** Active ✅  
**Entry Criteria:** Override Required = TRUE  

**Process Flow:**
1. Student requests course override (checks Override Required box)
2. Student fills in Override Reason
3. Record is submitted for approval
4. Assigned to: Course Instructor/Advisor
5. Approver receives email notification
6. Approver can Approve or Reject

**Approval Path:**
- Email notification sent via "Override Approval Request" template
- Record locks during approval (prevents editing)
- If Approved → Status changes to "Enrolled"
- If Rejected → Status changes to "Dropped"

**New Fields Created:**
- Override_Required__c (Checkbox) - Triggers approval process
- Override_Reason__c (Text Area) - Justification for override request

**Email Template:**
- Override Approval Request (Text template)
- Contains student info, course details, override reason
- Sent to approver when submission occurs

**Business Value:**
- Controlled enrollment in full courses
- Maintains oversight and accountability
- Audit trail of all override decisions
- Prevents unauthorized enrollments
- Ensures proper documentation of exceptions

**Technical Skills Demonstrated:**
- Approval process configuration with Jump Start Wizard
- Entry criteria setup (checkbox-based trigger)
- Email alert configuration for approvers
- Field updates on approval/rejection
- Record locking during approval
- Approval history tracking

---