# Week 3 - Day 3: Process Builder Automation

**Date:** January 10, 2026  
**Time Spent:** 2.5 hours  
**Status:** ✅ Complete

---

## 🎯 Goals Achieved

- ✅ Learned Process Builder interface and workflow
- ✅ Created 3 multi-action Process Builder flows
- ✅ Implemented email automation with HTML templates
- ✅ Built cross-object field updates
- ✅ Created formula-based criteria for dynamic conditions
- ✅ Tested all processes with real data
- ✅ Understood when to use Process Builder vs Workflow Rules

---

## 📊 Process Builder Flows Created

### 1. Enrollment Confirmation Process

**Object:** Enrollment__c  
**Trigger:** Only when a record is created  
**Criteria:** Status equals "Enrolled"  

**Actions (3 total):**

1. **Send Enrollment Confirmation Email**
   - Type: Email Alert
   - Template: Enrollment Confirmation (Text)
   - Recipient: Student (via Email field)
   - Purpose: Immediate confirmation to student

2. **Set Enrollment Date to Today**
   - Type: Update Records
   - Record: Enrollment (triggering record)
   - Field: Enrollment Date = TODAY()
   - Purpose: Auto-timestamp enrollment

3. **Update Student Last Enrollment Date**
   - Type: Update Records
   - Record: Student (related record)
   - Field: Last Enrollment Date = TODAY()
   - Purpose: Track student activity across objects

**Test Result:** ✅ All 3 actions executed successfully  
**Business Value:** Eliminates manual email sending and date entry, ensures students receive instant confirmation

---

### 2. Course Capacity Alert Process

**Object:** CourseOffering__c  
**Trigger:** When a record is created or edited  
**Criteria (Formula):** 
```
[CourseOffering__c].Current_Enrollment__c >= ([CourseOffering__c].Max_Enrollment__c * 0.8)
```

**What the formula means:**
- Evaluates to TRUE when current enrollment ≥ 80% of max enrollment
- Example: 28 students ≥ (35 max × 0.8) = TRUE
- Dynamic calculation adjusts for any max enrollment value

**Execute Only When:** Criteria changes from false to true (prevents spam)

**Actions (1 total):**

1. **Alert Department about Capacity**
   - Type: Email Alert
   - Template: Course Capacity Alert (Text)
   - Recipient: Department Head (User)
   - Purpose: Proactive capacity management

**Test Result:** ✅ Alert sent when enrollment reached 28 (80% of 35)  
**Business Value:** Prevents courses from being overbooked, enables proactive planning for additional sections

---

### 3. Graduate Status Automation

**Object:** Student__c  
**Trigger:** When a record is created or edited  
**Criteria (Conditions):**
- Total Credits Completed >= 120
- Status not equal to "Graduated"

**Execute Only When:** Criteria changes from false to true

**Actions (2 total):**

1. **Update Status to Graduated**
   - Type: Update Records
   - Record: Student (triggering record)
   - Field: Status = "Graduated"
   - Purpose: Automatic status progression

2. **Send Graduation Congratulations**
   - Type: Email Alert
   - Template: Graduation Congratulations (HTML)
   - Recipient: Student (via Email field or User)
   - Purpose: Celebrate student achievement

**Test Result:** ✅ Status updated and congratulations email sent when credits reached 120  
**Business Value:** Ensures no graduate is missed, creates memorable moment for students

---

## 📧 Email Templates Created

### 1. Enrollment Confirmation (Text)
**Type:** Plain Text  
**Subject:** Course Enrollment Confirmed  
**Merge Fields Used:**
- {!Enrollment__c.Student__r.First_Name__c} - Student first name
- {!Enrollment__c.Course_Offering__r.Course__r.Name} - Course name (3 levels deep!)
- {!Enrollment__c.Course_Offering__r.Section__c} - Section
- {!Enrollment__c.Course_Offering__r.Instructor__c} - Instructor
- {!Enrollment__c.Course_Offering__r.Term__c} - Term
- {!Enrollment__c.Course_Offering__r.Meeting_Days__c} - Schedule
- {!Enrollment__c.Course_Offering__r.Meeting_Time__c} - Time
- {!Enrollment__c.Course_Offering__r.Location__c} - Location

**Key Feature:** Uses relationship traversal to pull data from Course Offering and related Course

---

### 2. Course Capacity Alert (Text)
**Type:** Plain Text  
**Subject:** ALERT: Course Reaching Maximum Capacity  
**Merge Fields Used:**
- {!CourseOffering__c.Course__r.Name} - Course name
- {!CourseOffering__c.Course__r.Course_Code__c} - Course code
- {!CourseOffering__c.Section__c} - Section
- {!CourseOffering__c.Term__c} - Term
- {!CourseOffering__c.Instructor__c} - Instructor
- {!CourseOffering__c.Current_Enrollment__c} - Current count (rollup field!)
- {!CourseOffering__c.Max_Enrollment__c} - Maximum
- {!CourseOffering__c.Seats_Available__c} - Available (formula field!)
- {!CourseOffering__c.Link} - Direct link to record

**Key Feature:** Pulls data from rollup summaries and formula fields automatically

---

### 3. Graduation Congratulations (HTML)
**Type:** HTML with CSS styling  
**Subject:** 🎓 Congratulations Graduate!  
**Merge Fields Used:**
- {!Student__c.First_Name__c} - First name
- {!Student__c.Last_Name__c} - Last name
- {!Student__c.Student_ID__c} - Student ID
- {!Student__c.Academic_Program__r.Name} - Program name
- {!Student__c.Total_Credits_Completed__c} - Total credits
- {!Student__c.GPA__c} - Final GPA
- {!Student__c.Academic_Standing__c} - Standing (formula field!)

**Key Features:**
- Professional HTML formatting with CSS
- Color-coded sections (blue header, white content, dark footer)
- Responsive layout
- Styled boxes for emphasis
- Celebratory emojis

---

## 🆕 New Field Created

**Field:** Last_Enrollment_Date__c  
**Object:** Student__c  
**Type:** Date  
**Purpose:** Track when student last enrolled in a course  
**Used In:** Enrollment Confirmation Process (Action 3)  
**Business Value:** Enables tracking of student engagement over time

---

## 🔑 Key Learnings

### Process Builder Capabilities

1. **Multi-Action Execution**
   - One process can have multiple actions
   - All actions execute in order
   - More efficient than multiple workflow rules

2. **Cross-Object Updates**
   - Can update records related to trigger record
   - Example: Update Student when Enrollment changes
   - Use "Select a record related to..." option

3. **Formula-Based Criteria**
   - More powerful than simple conditions
   - Can do calculations (80% capacity example)
   - Must return TRUE/FALSE
   - Use Check Syntax button to validate

4. **Execute Only When Criteria Changes**
   - Prevents action spam on repeated edits
   - Only fires when condition goes from FALSE → TRUE
   - Critical for alert-type automation

---

### Process Builder vs Workflow Rules

| Feature | Workflow Rules | Process Builder |
|---------|---------------|-----------------|
| Multiple actions | ✅ Yes | ✅ Yes |
| Same-record field update | ✅ Yes | ✅ Yes |
| Cross-object field update | ❌ No | ✅ **YES!** |
| Create new records | ❌ No | ✅ **YES!** |
| Multiple criteria branches | ❌ No | ✅ **YES!** |
| Visual interface | ❌ Text-based | ✅ Visual canvas |
| Ease of debugging | ⚠️ Moderate | ✅ Better |

**When to use Process Builder:**
- Need cross-object updates
- Need to create records
- Want visual representation
- Need multiple IF-THEN branches
- Complex business logic

**When to use Workflow Rules:**
- Simple field updates
- Simple email alerts
- Time-based actions (easier in Workflow)
- Team is familiar with Workflows

---

### Formula Expressions

**System Functions Used:**
- `TODAY()` - Returns current date
- Used in field updates for auto-timestamping

**Formula Criteria Examples:**
```
[CourseOffering__c].Current_Enrollment__c >= ([CourseOffering__c].Max_Enrollment__c * 0.8)
```

**Key Points:**
- Reference fields: [ObjectName].FieldName
- Math operators: +, -, *, /
- Comparison: >=, <=, >, <, =, <>
- Parentheses for order of operations
- Must return boolean (TRUE/FALSE)

---

### Merge Fields in Email Templates

**Syntax Patterns:**

**Same object field:**
```
{!Student__c.First_Name__c}
```

**Related object field (one level):**
```
{!Student__c.Academic_Program__r.Name}
```

**Related object field (two levels):**
```
{!Enrollment__c.Course_Offering__r.Course__r.Name}
```

**Key Rules:**
- Always start with {! and end with }
- Use __r for relationships (not __c)
- Can traverse up to 3 relationship levels
- Case sensitive!

---

## 🚧 Challenges Overcome

### Challenge 1: Email Recipient Field Selector
**Issue:** Email Field dropdown not showing related object fields  
**Solution:** Used "User" recipient type to send to specific user for testing  
**Workaround:** Can use "Additional Emails" field to enter email addresses directly  
**Learning:** Multiple ways to accomplish same goal in Salesforce

---

### Challenge 2: Formula Syntax Errors
**Issue:** First attempt at capacity formula had syntax error  
**Solution:** Used "Check Syntax" button to identify issue  
**Fix:** Added proper parentheses for order of operations  
**Learning:** Always use Check Syntax before saving formulas

---

### Challenge 3: Process Firing Too Often
**Issue:** Capacity alert sent every time enrollment updated  
**Solution:** Selected "Yes" for "Execute only when specified changes are made"  
**Result:** Alert now only fires when crossing 80% threshold  
**Learning:** Important to prevent automation spam

---

### Challenge 4: Cross-Object Update Not Working
**Issue:** Tried to update Student.Last_Enrollment_Date but field didn't exist  
**Solution:** Created the field on Student object first  
**Lesson:** Always verify fields exist before building automation  
**Best Practice:** Create all required fields before starting process

---

## 📸 Screenshots Captured

**Folder:** `documentation/screenshots/week-03/day-03/`

**Screenshots taken:**
1. Process Builder main page (before creating processes)
2. Enrollment Confirmation Process - complete canvas view
3. Course Capacity Alert Process - showing formula criteria
4. Graduate Status Automation - showing two actions
5. Enrollment record with auto-filled date
6. Student record with Last Enrollment Date updated
7. Enrollment confirmation email in inbox
8. Course capacity alert email
9. Graduation congratulations HTML email
10. Student record showing "Graduated" status
11. Process Builder list showing all 3 active processes

---

## 🧪 Testing Results

### Test 1: Enrollment Confirmation Process

**Test Data:**
- Student: Test Student (created Day 1)
- Course Offering: CS101-001 Fall 2024
- Status: Enrolled
- Enrollment Date: Left blank

**Expected Results:**
1. ✅ Email sent to student
2. ✅ Enrollment Date = Today
3. ✅ Student.Last Enrollment Date = Today

**Actual Results:** ✅ All 3 actions executed successfully

**Time:** Email arrived within 2 minutes  
**Verification:** Checked enrollment record, student record, and email inbox

---

### Test 2: Course Capacity Alert Process

**Test Data:**
- Course: CS101 - Introduction to Computer Science
- Section: 001
- Max Enrollment: 35
- Initial Current Enrollment: 20
- Target: 28 (80% of 35)

**Test Process:**
- Created 8 additional enrollments
- Final Current Enrollment: 28

**Expected Result:** 
- ✅ Alert email sent to department head

**Actual Result:** ✅ Email received when 28th student enrolled

**Time:** Email arrived within 1 minute of 28th enrollment  
**Formula Validation:** 28 >= (35 * 0.8) = 28 >= 28 = TRUE ✓

---

### Test 3: Graduate Status Automation

**Test Data:**
- Student: Sarah Johnson
- Initial Credits: 118
- Initial Status: Active
- Target Credits: 120

**Test Process:**
- Edited student record
- Changed Total Credits Completed to 120
- Saved record

**Expected Results:**
1. ✅ Status updated to "Graduated"
2. ✅ Congratulations email sent

**Actual Results:** ✅ Both actions executed successfully

**Time:** Status changed immediately, email arrived within 1 minute  
**HTML Verification:** Email displayed with proper formatting and colors

---

## 📊 Cumulative Week 3 Progress

**Days Completed:** 3 of 7 (43%)

**Automation Created:**
- Workflow Rules: 5
- Process Builder Flows: 3
- **Total Automation Rules: 8**

**Email Templates:**
- Text Templates: 5
- HTML Templates: 2
- **Total Email Templates: 7**

**Automated Actions:**
- Email Alerts: 6
- Field Updates: 3
- Task Creation: 1
- **Total Actions: 10**

**Fields Created:**
- Registration_Deadline__c (Date)
- Last_Enrollment_Date__c (Date)

---

## 💡 Business Value Delivered

### Enrollment Confirmation Automation
**Time Saved:** 5 minutes per enrollment × 300 enrollments/semester = **25 hours/semester**  
**Error Reduction:** Eliminates forgotten confirmations  
**Student Satisfaction:** Instant feedback improves experience

### Course Capacity Monitoring
**Time Saved:** 10+ hours/semester checking enrollments manually  
**Benefit:** Proactive planning prevents overenrollment issues  
**Revenue Impact:** Enables timely addition of sections when needed

### Graduation Automation
**Time Saved:** 8 hours/semester reviewing transcripts for graduation eligibility  
**Student Impact:** Immediate recognition of achievement  
**Data Quality:** Ensures accurate status in real-time

**Total Time Saved:** 43+ hours per semester  
**Annual Savings:** 86+ hours (2 semesters)  
**Equivalent FTE:** 0.04 (approx 2 weeks of work automated!)

---

## 🎓 Skills Mastered

**Technical Skills:**
- Process Builder canvas navigation
- Multi-action process configuration
- Cross-object field updates
- Formula criteria creation
- HTML email template design
- CSS styling in emails
- Merge field syntax (up to 3 levels)
- Process activation and testing

**Salesforce Concepts:**
- Record-triggered automation
- Action execution order
- Related record updates
- Formula evaluation
- Email alert configuration
- Criteria-based execution
- Preventing automation loops

**Best Practices:**
- Create supporting fields before building processes
- Use "Execute only when criteria changes" to prevent spam
- Test with real data before activating
- Document all automation thoroughly
- Use descriptive names for processes and actions
- Leverage visual canvas for documentation

---

## 🔍 Process Builder Architecture

### Anatomy of a Process Builder Flow

```
TRIGGER (Object + When)
    ↓
CRITERIA (Conditions or Formula)
    ↓
ACTION GROUP (Multiple actions execute in order)
    ├─ Action 1 (Email Alert)
    ├─ Action 2 (Field Update)
    ├─ Action 3 (Field Update - Related Record)
    └─ Action 4 (Create Record) [not used today]
```

### Key Components

1. **Process Definition**
   - Name, API Name, Description
   - "Starts when a record changes"

2. **Object Node**
   - Which object triggers the process
   - Created vs Created/Edited

3. **Criteria Node**
   - Conditions or Formula
   - When to execute actions
   - Execute only on change: Yes/No

4. **Action Nodes**
   - Email Alerts
   - Field Updates (same or related records)
   - Create Records
   - Post to Chatter
   - Submit for Approval
   - Launch Flow

---

## 🔮 Future Enhancements

**Potential Improvements:**
1. Add approval process for course overrides (Day 4!)
2. Create waitlist when course reaches 100% capacity
3. Send reminder emails to students 1 week before term starts
4. Automatically assign academic advisors based on program
5. Create tasks for advisors when students graduate
6. Integration with external systems (transcript generation)

---

## 📝 Documentation Standards Established

**Process Naming Convention:**
- `[Business Purpose] Process`
- Examples: "Enrollment Confirmation Process", "Graduate Status Automation"

**Action Naming Convention:**
- `[Verb] [Object/Purpose]`
- Examples: "Send Enrollment Confirmation Email", "Update Status to Graduated"

**Email Template Naming:**
- `[Purpose/Type]`
- Examples: "Enrollment Confirmation", "Course Capacity Alert"

**Field Naming:**
- `[Descriptive Name]__c`
- Examples: "Last_Enrollment_Date__c", "Registration_Deadline__c"

---

## ⏭️ Next Steps - Day 4

**Planned Topics:**
- Approval Processes
- Multi-step approvals
- Dynamic approval routing
- Approval vs rejection actions
- Email notifications for approvals

**Processes to Build:**
- Course override approval workflow
- Grade change approval (2-step)
- Advisor assignment approval

**Estimated Time:** 2-3 hours

---

## 🎯 Personal Reflections

**What Went Well:**
- Process Builder visual interface makes automation easy to understand
- Cross-object updates are incredibly powerful
- HTML email templates look professional and engaging
- Testing with real data gave confidence in automation

**Challenges:**
- Email recipient field selector was tricky at first
- Formula syntax requires precision and practice
- Understanding when to use "created" vs "created or edited" took thought

**Key Takeaway:**
Process Builder is significantly more powerful than Workflow Rules. The ability to update related records and execute multiple actions in one process will be the foundation of complex automation in Salesforce.

**Confidence Level:**
- Before Day 3: Beginner with automation
- After Day 3: Comfortable building multi-action processes

**Ready for Day 4:** Yes! Excited to add approval processes to the automation toolkit.

---

## 📈 Learning Velocity

**Day 1:** 2 Workflow Rules (2 hours)  
**Day 2:** 3 Workflow Rules (2.5 hours)  
**Day 3:** 3 Process Builder Flows with 6 actions (2.5 hours)  

**Total Week 3 so far:** 8 automation rules, 7 hours

**Observation:** Getting faster as concepts solidify. Process Builder felt natural after understanding Workflow Rules.

---

## ✅ Day 3 Checklist

- ✅ Process Builder interface learned
- ✅ 3 processes created and activated
- ✅ 3 email templates created (1 HTML, 2 text)
- ✅ 1 new field added to Student object
- ✅ Cross-object field updates working
- ✅ Formula criteria implemented successfully
- ✅ All processes tested with real data
- ✅ Screenshots captured
- ✅ Documentation completed
- ✅ Ready for Day 4

---

**Status:** ✅ Week 3 Day 3 Complete - 100%  
**Quality:** ⭐⭐⭐⭐⭐ Excellent  
**Processes Working:** 3/3 (100%)  
**Confidence:** High  

---

*Day 3 Complete: January 10, 2026*  
*From Workflow Rules to Process Builder - Automation getting powerful!*  
*8 automation rules created in 3 days. System is intelligent!* 💪🚀