# Week 5: Advanced Flows & Screen Flows

**Duration:** January 20-23, 2026  
**Status:** ✅ Completed  
**Time Invested:** 6 hours

---

## 🎯 Week 5 Overview

**Theme:** Advanced Flow Builder - Interactive Flows  
**Goal:** Build interactive Screen Flow and modern Record-Triggered Flow

**What I Built:**
- ✅ Screen Flow: Course Search & Enrollment Wizard (15+ elements)
- ✅ Record-Triggered Flow: Automatic enrollment notifications (3 elements)
- ✅ Interactive user interface with data tables
- ✅ Modern automation replacing Process Builder

---

## 🖥️ Screen Flow: Course Search and Enrollment

### **Purpose:**
Allow students to search for available courses by term and view course details through an interactive wizard.

### **User Journey:**
1. Student selects term from picklist
2. Flow queries matching courses with SOQL
3. Results displayed in interactive data table
4. Student selects desired course
5. Confirmation message displayed

### **Flow Elements:**

**Screens (4):**
1. Welcome Screen - Search inputs
2. Course Results Screen - Data table with 8 columns
3. No Courses Found Screen - Friendly error message
4. Success Screen - Selection confirmation

**Logic Elements (4):**
1. Assignment - Store search input
2. Get Records - Find courses by term (SOQL filter)
3. Decision - Check if courses found
4. Additional logic for course selection

**Variables (3):**
1. varSearchText (Text) - Stores search input
2. varSelectedCourse (Record) - Stores selected course
3. varCourseList (Record Collection) - Stores search results

### **Key Features:**
- Real-time SOQL querying
- Term-based course filtering
- Interactive data table selection
- Dynamic record display
- User-friendly error handling
- Merge field display in confirmation

### **Technical Implementation:**
```
Flow Type: Screen Flow
Total Elements: 15+
SOQL Queries: 1
Screens: 4
Variables: 3
Complexity: Medium-High
```

### **Business Value:**
- Self-service course browsing
- Real-time course availability
- Improved student experience
- Scalable for enterprise use

---

## ⚡ Record-Triggered Flow: Enrollment Auto Notification

### **Purpose:**
Automatically update student records and send email notifications when enrollments are created.

### **Trigger Configuration:**
- **Object:** Enrollment__c
- **Trigger:** After record is created
- **Condition:** Status equals "Enrolled"
- **Optimization:** Actions and Related Records

### **Flow Elements:**

**Update Records:**
- Updates related Student record
- Sets Last_Enrollment_Date__c to current date
- Uses filtered record lookup

**Send Email:**
- Recipient: Student email
- Subject: Enrollment Confirmation with course name
- Body: Complete course details and enrollment info
- Sender: Current user

### **Key Features:**
- Automatic execution (no user action needed)
- Cross-object field updates
- Dynamic email content with merge fields
- Trigger-based automation

### **Technical Implementation:**
```
Flow Type: Record-Triggered Flow
Trigger: After Create
Elements: 3
Objects Updated: Student__c
Emails Sent: 1 per enrollment
Complexity: Low-Medium
```

### **Business Value:**
- Zero manual intervention
- Instant student notifications
- Accurate enrollment tracking
- Professional communication
- Complete audit trail

---

## 🎓 Technical Skills Learned

### **Screen Flow Skills:**
- ✅ Screen components (text input, picklist, data table)
- ✅ Get Records with filters
- ✅ Decision branching logic
- ✅ Collection variables
- ✅ Record variables
- ✅ Data table configuration
- ✅ User input validation
- ✅ Dynamic record display
- ✅ Merge fields in displays

### **Record-Triggered Flow Skills:**
- ✅ Trigger configuration (object, timing, conditions)
- ✅ $Record variable usage
- ✅ Related record references
- ✅ Update Records element
- ✅ Send Email action
- ✅ Flow optimization settings

### **Flow Builder Mastery:**
- ✅ Flow canvas navigation
- ✅ Element connections
- ✅ Variable management
- ✅ Formula expressions
- ✅ Resource references
- ✅ Flow activation/deactivation
- ✅ Flow testing and debugging

---

## 🐛 Debugging Journey

**Challenges Encountered and Resolved:**

### **Issue 1: Variable Not Storing Input**
- **Problem:** Search text not being passed to query
- **Solution:** Added Assignment element to store screen input in variable

### **Issue 2: Field Reference Errors**
- **Problem:** Attempting to filter on ID field vs text field
- **Solution:** Changed query logic to filter by Term only

### **Issue 3: Flow Unhandled Fault**
- **Problem:** Student lookup failing (email mismatch)
- **Solution:** Simplified flow to focus on search and display functionality

### **Issue 4: Screen Flow Complexity**
- **Learning:** Iterative debugging of multi-element flows
- **Solution:** Systematic testing of each element connection

**Key Takeaway:** Complex flows require methodical debugging and willingness to simplify when needed.

---

## 📊 Results & Metrics

**Code Quality:**
- Screen Flow Elements: 15+
- Record-Triggered Flow Elements: 3
- Variables Created: 3
- SOQL Queries: 1
- Total Flows: 2
- All Flows Active: ✅

**Business Impact:**
- Self-service course browsing capability
- Automatic student record updates
- Instant email notifications
- Zero manual processing
- Enhanced user experience

**Time Investment:**
- Screen Flow design: 3 hours
- Screen Flow debugging: 2 hours
- Record-Triggered Flow: 60 min
- Testing: 30 min
- **Total: 6 hours**

---

## 💡 Key Takeaways

1. **Screen Flows are Powerful:** Can build complex UIs without code
2. **Data Tables are Essential:** Perfect for displaying search results
3. **Variables are Critical:** Proper variable setup prevents issues
4. **Record-Triggered Flows > Process Builder:** Modern, faster, better debugging
5. **Simplicity Wins:** Sometimes removing complexity is the right solution
6. **Testing is Essential:** Always test with real data before activating
7. **Debugging is Learning:** Each error teaches something new

---

## 🆚 Comparison: Flow Types

**Screen Flow:**
- User-initiated
- Interactive UI
- Multiple screens
- User inputs and selections
- Perfect for wizards and guided processes

**Record-Triggered Flow:**
- Automatic execution
- No user interaction
- Runs in background
- Triggered by record changes
- Perfect for automation

**Both are better than:**
- Process Builder (deprecated soon)
- Workflow Rules (limited functionality)
- Apex (when no code needed)

---

## 🚀 Week 5 Achievements

**Flows Created:**
- ✅ Interactive Screen Flow (15+ elements)
- ✅ Record-Triggered Flow (3 elements)

**Capabilities Added:**
- ✅ Self-service course browsing
- ✅ Real-time course search by term
- ✅ Automatic email notifications
- ✅ Student record auto-updates

**Technical Mastery:**
- ✅ Flow Builder proficiency
- ✅ Screen component configuration
- ✅ SOQL in Flow
- ✅ Record display from flows
- ✅ Trigger-based automation

---

## 📸 Screenshots

**Location:** `documentation/screenshots/week-05/`

1. `week-05-screen-flow-complete.png` - Complete Screen Flow canvas
2. `week-05-screen-flow-welcome.png` - Welcome screen with inputs
3. `week-05-screen-flow-results.png` - Course results data table
4. `week-05-screen-flow-success.png` - Success confirmation
5. `week-05-record-triggered-flow.png` - Record-Triggered Flow canvas
6. `week-05-both-flows-active.png` - Both flows active in setup
7. `week-05-enrollment-created.png` - Enrollment record created
8. `week-05-email-received.png` - Email confirmation received

---

## 🏆 Achievement Unlocked

**Status:** Flow Builder Expert ✅

**Capabilities:**
- Design interactive user interfaces
- Build guided multi-step processes
- Create modern automation
- Replace legacy tools (Process Builder)
- Handle complex business logic without code

**Portfolio Value:**
- Production-ready flows
- User-facing interactive tools
- Modern Salesforce automation
- Professional UI design
- Complete solution delivery

---

## 🎯 Next Steps

**Potential Enhancements:**
- Add course name filtering with proper field references
- Create flow for course withdrawal
- Build advisor approval screen
- Add prerequisite validation
- Implement waitlist functionality

**Week 6 Preview:**
- Lightning Web Components (Intro)
- Create first LWC
- Display enrollment data
- Interactive UI with JavaScript

---

**Week 5 Complete!** 🎉

*Next: Week 6 - Lightning Web Components*
```

