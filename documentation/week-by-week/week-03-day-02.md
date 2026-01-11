# Week 3 - Day 2: Advanced Workflows & Time-Based Actions

**Date:** [Today's date]  
**Time Spent:** 2.5 hours  
**Status:** ✅ Complete

## Goals Achieved

- ✅ Created HTML email template with styling
- ✅ Built at-risk student alert workflow
- ✅ Created time-based workflow with scheduled actions
- ✅ Implemented automatic task creation
- ✅ Added Registration Deadline field to Student object

## Workflows Created

### 3. At-Risk Student Notification

**Object:** Student__c  
**Evaluation:** created and edited  
**Criteria:** 
- GPA < 2.5
- Status = Active

**Action:** Send HTML email to advisor  
**Email Template:** At-Risk Student Alert (HTML with styling)  
**Test Result:** ✅ Received formatted email with student details

**Key Features:**
- Professional HTML formatting
- Red alert colors
- Student info in styled boxes
- Button link to student record
- Multiple merge fields including related objects

---

### 4. Registration Reminder - 7 Days Before

**Object:** Student__c  
**Evaluation:** created and edited  
**Criteria (Formula):** 
```
AND(
  NOT(ISBLANK(Registration_Deadline__c)),
  Status__c = "Active",
  Registration_Deadline__c > TODAY()
)
```

**Time Trigger:** 7 Days Before Registration Deadline  
**Action:** Send reminder email to student  
**Test Result:** ✅ Action scheduled in workflow queue

**Key Features:**
- Time-dependent action (not immediate)
- Formula-based criteria
- Scheduled email delivery
- Appears in Time-Based Workflow queue

---

### 5. Student Leave Task Assignment

**Object:** Student__c  
**Evaluation:** created and edited  
**Criteria:** Status equals On Leave

**Action:** Create Task  
**Details:**
- Assigned to advisor
- Due: 7 days after rule trigger
- Priority: High
- Status: Not Started
- Comments: Include student details and action items

**Test Result:** ✅ Task created automatically with all details

---

## New Field Created

**Field:** Registration_Deadline__c  
**Type:** Date  
**Purpose:** Track when student must register for next semester  
**Used In:** Time-based workflow trigger

---

## Email Templates Created

### At-Risk Student Alert (HTML)
- Professional styling with CSS
- Red alert header
- Formatted student information boxes
- Blue call-to-action button
- Responsive design
- Multiple merge fields:
  - {!Student__c.Name}
  - {!Student__c.GPA__c}
  - {!Student__c.Academic_Program__r.Name}
  - {!Student__c.Link}

### Registration Reminder (Text)
- Simple text format
- Clear call to action
- Deadline prominently displayed
- Contact information included

---

## Key Learnings

1. **HTML Email Templates:**
   - Can use CSS for styling
   - Must use inline styles or style tags
   - Preview functionality available
   - More professional than text emails

2. **Time-Based Workflows:**
   - Require separate "Add Time Trigger" button
   - Actions go under time trigger, not immediate actions
   - Appear in Time-Based Workflow queue
   - Can be X days before/after a date field
   - Can be removed from queue before execution

3. **Task Automation:**
   - Tasks can be assigned to specific users
   - Due dates can be relative to trigger date
   - Comments field supports merge fields
   - Creates task record visible in Task tab

4. **Formula Criteria:**
   - More flexible than standard criteria
   - Can check for blank fields
   - Can combine multiple conditions
   - Must return TRUE/FALSE
   - Use "Check Syntax" button

5. **Related Object Merge Fields:**
   - Syntax: {!Object__c.Relationship__r.Field__c}
   - Can traverse relationships
   - Example: {!Student__c.Academic_Program__r.Name}

---

## Challenges Overcome

**Challenge 1:** HTML email looked plain in preview  
**Solution:** Used inline styles and proper HTML structure

**Challenge 2:** Time-based action didn't appear  
**Solution:** Realized I clicked "Add Workflow Action" instead of "Add Time Trigger"

**Challenge 3:** Formula syntax error  
**Solution:** Used "Check Syntax" button, found missing comma

**Challenge 4:** Task wasn't assigned correctly  
**Solution:** Made sure to select "User" type, not "Queue"

---

## Testing Notes

1. **At-Risk Alert:**
   - Changed student GPA from 3.5 to 2.4
   - Email received within 2 minutes
   - HTML formatting displayed correctly
   - All merge fields populated properly

2. **Registration Reminder:**
   - Set deadline to 8 days from now
   - Verified action appears in Time-Based Workflow queue
   - Scheduled for 1 day from now (7 days before deadline)
   - Cannot fully test without waiting for scheduled date

3. **Task Creation:**
   - Changed student status to "On Leave"
   - Task created immediately
   - All task fields populated correctly
   - Task visible in My Tasks view
   - Due date correctly set to 7 days from today

---

## Time-Based Workflow Queue Management

**View Queue:** Setup → Time-Based Workflow  
**Can See:** All pending scheduled actions  
**Can Remove:** Actions not yet executed  
**Useful For:** Testing and debugging time-based workflows

---

## Cumulative Progress

**Workflows:** 5 total (2 from Day 1 + 3 from Day 2)  
**Email Templates:** 4 total  
**Field Updates:** 1  
**Email Alerts:** 3  
**Tasks:** 1  
**New Fields:** 1  

---

## Next Steps - Day 3

- Process Builder introduction
- Multi-action processes
- Cross-object field updates
- Record creation via automation
- Graduate status process

---

**Status:** Day 2 Complete ✅  
**Time Well Spent:** Learned advanced workflow features that save hours of manual work