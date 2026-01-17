# Week 4: Apex Development & Triggers

**Duration:** January 13-17, 2026  
**Status:** ✅ Completed  
**Time Invested:** 4 hours

---

## 🎯 Week 4 Overview

**Theme:** Introduction to Apex Programming and Trigger Development  
**Goal:** Write first Apex trigger with comprehensive test coverage

**What I Built:**
- ✅ Apex Trigger: EnrollmentTrigger (60 lines)
- ✅ Test Class: EnrollmentTriggerTest (70 lines)
- ✅ 96% code coverage (required: 75%)
- ✅ Production-ready, bulkified code

---

## 💻 Apex Trigger: EnrollmentTrigger

### **Purpose:**
Prevent students from enrolling in courses that are at maximum capacity.

### **Business Logic:**
- Triggers on Enrollment__c BEFORE INSERT
- Counts existing active enrollments in each course
- Compares count to Max_Enrollment__c
- Blocks enrollment if course is full
- Shows custom error message to user

### **Key Features:**
1. **Smart Counting:** Only counts active enrollments (Enrolled, In Progress, Pending Approval)
2. **Ignores Inactive:** Does not count Dropped, Withdrawn, or Completed enrollments
3. **Bulkified:** Handles multiple enrollments in a single transaction
4. **User-Friendly:** Clear error message with course capacity details

### **Technical Implementation:**
- Uses Set<Id> to collect Course Offering IDs
- Single SOQL query with aggregate function (COUNT)
- Map<Id, Integer> for efficient capacity lookup
- addError() method to prevent record insertion

### **Code Structure:**
```apex
trigger EnrollmentTrigger on Enrollment__c (before insert) {
    // 1. Define inactive statuses
    // 2. Collect Course Offering IDs
    // 3. Query enrollment counts (aggregate)
    // 4. Store counts in map
    // 5. Query Course Offerings for max capacity
    // 6. Validate each enrollment
    // 7. Add error if course full
}
```

**Lines of Code:** 60  
**Complexity:** Medium  
**Governor Limits:** 2 SOQL queries (well within limits)

---

## 🧪 Test Class: EnrollmentTriggerTest

### **Purpose:**
Verify trigger functionality and achieve code coverage for deployment.

### **Test Scenario:**
Tests the core business logic - enrolling in a full course should fail.

### **Test Setup:**
1. Creates test Course with required fields
2. Creates test Course Offering with Max_Enrollment = 1
3. Creates 2 test Students with all required fields
4. Uses Test.startTest() and Test.stopTest() for proper test isolation

### **Test Execution:**
1. First enrollment: Should succeed (course has space for 1)
2. Second enrollment: Should FAIL with error (course now full)
3. Catches DmlException and verifies error message
4. Asserts only 1 enrollment was created

### **Assertions:**
```apex
System.assert(errorOccurred, 'Should have thrown error');
System.assert(errorMessage.contains('maximum capacity'));
System.assertEquals(1, enrollments.size(), 'Only 1 should exist');
```

**Lines of Code:** 70  
**Code Coverage Achieved:** 96% (30/31 lines)  
**Test Results:** ✅ PASSED

---

## 🐛 Debugging Journey

**Challenges Encountered and Resolved:**

### **Issue 1: Rollup Field Timing**
- **Problem:** Current_Enrollment__c rollup updates AFTER trigger runs
- **Solution:** Count enrollments directly with SOQL aggregate query

### **Issue 2: Wrong Object API Name**
- **Problem:** Used `CourseOffering__c` instead of `Course_Offering__c`
- **Solution:** Corrected to use underscores in object name

### **Issue 3: Syntax Error with NOT IN**
- **Problem:** Used `NOT IN` in if statement (doesn't work in Apex)
- **Solution:** Created Set and used `!set.contains()` instead

### **Issue 4: Status Value Mismatch**
- **Problem:** Counting only "Enrolled" but also need "In Progress"
- **Solution:** Exclude inactive statuses instead (Dropped, Withdrawn, Completed)

### **Issue 5: Test Data - Missing Required Fields**
- **Problem:** Test failed with REQUIRED_FIELD_MISSING for Start_Date__c, End_Date__c
- **Solution:** Added Date.today() and Date.today().addDays(90)

### **Issue 6: Validation Rule**
- **Problem:** Student validation rule requires Enrollment_Date__c for Active students
- **Solution:** Added Enrollment_Date__c = Date.today() to test students

**Result:** All issues resolved, test passing at 96% coverage!

---

## 🎓 Technical Skills Learned

### **Apex Programming:**
- ✅ Trigger context variables (Trigger.new)
- ✅ Before vs After triggers
- ✅ Data types (Set, Map, List)
- ✅ For loops and collections
- ✅ Exception handling (try-catch)

### **SOQL:**
- ✅ Aggregate queries (COUNT, GROUP BY)
- ✅ WHERE IN clause with collections
- ✅ NOT IN for filtering
- ✅ Query optimization

### **Best Practices:**
- ✅ Bulkification (no queries in loops)
- ✅ Using Maps for efficient lookups
- ✅ DML statements outside loops
- ✅ Descriptive error messages
- ✅ Code comments

### **Testing:**
- ✅ @isTest annotation
- ✅ Test.startTest() and Test.stopTest()
- ✅ Creating test data
- ✅ Catching exceptions
- ✅ System.assert() statements
- ✅ Achieving high code coverage

---

## 📊 Results & Metrics

**Code Quality:**
- Lines of Code: 130 (trigger + test)
- Code Coverage: 96%
- Test Pass Rate: 100%
- Governor Limits: Well within limits
- Production-Ready: ✅ Yes

**Business Impact:**
- Prevents over-enrollment in courses
- Maintains course capacity integrity
- Provides clear user feedback
- Handles bulk operations efficiently
- Complete audit trail via error logs

**Time Investment:**
- Learning Apex basics: 30 min
- Writing trigger: 60 min
- Debugging trigger: 45 min
- Writing tests: 45 min
- Debugging tests: 60 min
- **Total: 4 hours**

---

## 💡 Key Takeaways

1. **Trigger Timing Matters:** Understanding before vs after triggers is crucial
2. **Bulkification is Essential:** Always assume multiple records will be processed
3. **Test Data is Tricky:** Must satisfy all validation rules and required fields
4. **Debugging is Normal:** Even simple triggers require multiple iterations
5. **Code Coverage ≠ Code Quality:** Tests must actually verify logic, not just execute code

---

## 🚀 Next Steps

**Potential Enhancements:**
- Add after update trigger to handle status changes
- Create helper class for better code organization
- Add more test scenarios (bulk enrollment, edge cases)
- Implement custom exception handling
- Add logging for production debugging

**Week 5 Preview:**
- Advanced Flow Builder
- Record-Triggered Flows
- Screen Flows with user interaction
- Flow debugging and optimization

---

## 📸 Screenshots

**Location:** `documentation/screenshots/week-04/`

1. `week-04-trigger-code.png` - Complete trigger code
2. `week-04-test-class-code.png` - Complete test class
3. `week-04-test-passed.png` - Test results showing passed
4. `week-04-code-coverage-96-percent.png` - Coverage at 96%
5. `week-04-manual-test-error.png` - Error message blocking enrollment

---

## 🏆 Achievement Unlocked

**Status:** Salesforce Developer ✅

**Capabilities:**
- Write Apex triggers
- Create comprehensive test classes
- Debug production code
- Follow Salesforce best practices
- Achieve deployment readiness

**Portfolio Value:**
- Production-ready Apex code
- High test coverage
- Problem-solving demonstrated
- End-to-end development cycle

---

**Week 4 Complete!** 🎉

*Next: Week 5 - Advanced Flows & Apex Classes*
```

