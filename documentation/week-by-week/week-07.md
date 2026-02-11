# Week 7: Advanced LWC - Course Enrollment Component

**Duration:** February 10, 2026  
**Status:** ✅ Completed  
**Time Invested:** 8 hours

---

## 🎯 Week 7 Overview

**Theme:** Advanced Lightning Web Components - Interactive Course Enrollment  
**Goal:** Build production-ready enrollment component with form interactions and validation

**What I Built:**
- ✅ Course Browser Component (200+ lines)
- ✅ Advanced Apex Controller with validation (120 lines)
- ✅ Real-time seat availability tracking
- ✅ One-click enrollment with toast notifications
- ✅ Duplicate enrollment prevention
- ✅ Capacity management and validation

---

## 💻 Component Built: Course Browser

### **Purpose:**
Allow students to browse available courses and enroll with one click, with automatic validation and real-time feedback.

### **Component Files:**

**1. courseBrowser.html (140 lines)**
- Search box for filtering courses
- Refresh button for reloading data
- Course cards with detailed information
- Conditional rendering for loading/empty states
- Seat availability badges
- Dynamic button states

**2. courseBrowser.js (100 lines)**
- Wire service for automatic data loading
- Search filtering logic
- Enrollment creation with error handling
- Toast message notifications
- Seat calculation logic
- Full course detection

**3. CourseEnrollmentController.cls (120 lines)**
- getCourseOfferings() - cacheable query method
- createEnrollment() - DML operation with validation
- Duplicate prevention logic
- Capacity checking
- User email-based student lookup

---

## 🎨 Features Implemented

### **User Interface:**
- Search box with real-time filtering
- Refresh button for manual data reload
- Course cards with education icon
- Responsive grid layout
- Color-coded availability badges
- Disabled button states for full courses

### **Data Display:**
- Course name and code
- Term and section information
- Instructor name
- Meeting schedule (days and time)
- Location details
- Current enrollment vs. max capacity
- Calculated seats available

### **Interactive Features:**
- Search by course name or code
- One-click enrollment
- Automatic seat count updates
- Success toast notifications
- Error toast for validation failures
- Loading spinner during operations
- Automatic component refresh after enrollment

### **Business Logic:**
- Prevent duplicate enrollments
- Check course capacity before enrolling
- Update Current_Enrollment__c on Course Offering
- Create Enrollment__c record
- Match student by email address
- Real-time seat availability calculation

---

## 🔧 Technical Implementation

### **LWC Advanced Concepts:**

**Wire Service:**
```javascript
@wire(getCourseOfferings)
wiredCourses(result) {
    // Automatic data binding
    // Reactive updates
    // Refresh capability
}
```

**Imperative Apex Calls:**
```javascript
createEnrollment({ courseOfferingId: courseOfferingId })
    .then(result => {
        // Success handling
        this.showToast('Success!', result, 'success');
        return refreshApex(this.wiredCoursesResult);
    })
    .catch(error => {
        // Error handling
    });
```

**Toast Notifications:**
```javascript
showToast(title, message, variant) {
    const event = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
    });
    this.dispatchEvent(event);
}
```

**Data Transformation:**
```javascript
this.courseOfferings = result.data.map(course => {
    const seatsAvailable = maxEnrollment - currentEnrollment;
    return {
        ...course,
        seatsAvailable: seatsAvailable,
        isFull: currentEnrollment >= maxEnrollment
    };
});
```

**Search Filtering:**
```javascript
filterCourses() {
    this.filteredCourses = this.courseOfferings.filter(course => {
        const courseName = course.Course__r?.Name?.toLowerCase() || '';
        return courseName.includes(this.searchKey);
    });
}
```

---

## 🔐 Apex Controller Details

### **Method 1: getCourseOfferings()**

**Purpose:** Retrieve all course offerings with related course data

**Key Features:**
- Cacheable for performance
- SOQL query with relationship fields
- Includes enrollment counts
- Ordered by term and course name
- Limited to 100 records

**SOQL Query:**
```apex
SELECT Id, Term__c, Section__c, Instructor__c,
       Meeting_Days__c, Meeting_Time__c, Location__c,
       Max_Enrollment__c, Current_Enrollment__c,
       Course__r.Name, Course__r.Course_Code__c
FROM Course_Offering__c
WHERE Id != null
ORDER BY Term__c, Course__r.Name
LIMIT 100
```

### **Method 2: createEnrollment()**

**Purpose:** Create enrollment record with comprehensive validation

**Validation Steps:**
1. Find student by current user's email
2. Verify course offering exists
3. Check for duplicate enrollment
4. Verify course capacity available
5. Create enrollment record
6. Return success message

**Error Handling:**
- No student found: Custom error message
- Already enrolled: Duplicate prevention
- Course full: Capacity exceeded
- DML errors: Generic error handling

**Security:**
- with sharing keyword (respects org sharing rules)
- User-based student lookup
- Prevents enrolling other students
- Safe DML operations

---

## 🎓 Skills Learned

### **Advanced LWC:**
- ✅ Imperative Apex calls (vs wire service)
- ✅ Promise handling (.then/.catch)
- ✅ Toast notifications (ShowToastEvent)
- ✅ refreshApex for cache refresh
- ✅ Data transformation with map()
- ✅ Computed properties for UI logic
- ✅ Event.target.dataset for passing data
- ✅ Conditional class binding

### **JavaScript:**
- ✅ Spread operator (...course)
- ✅ Optional chaining (Course__r?.Name)
- ✅ Nullish coalescing (|| operator)
- ✅ Array filter and map methods
- ✅ Async/await patterns
- ✅ Error object handling

### **Apex:**
- ✅ @AuraEnabled with cacheable
- ✅ @AuraEnabled without cacheable (DML)
- ✅ SOQL relationship queries
- ✅ List processing and validation
- ✅ Custom AuraHandledException
- ✅ UserInfo class usage
- ✅ Safe DML operations

### **User Experience:**
- ✅ Loading states
- ✅ Empty states
- ✅ Error states
- ✅ Success feedback
- ✅ Visual indicators (badges)
- ✅ Disabled button states

---

## 📊 Results & Metrics

**Code Quality:**
- LWC: 240 lines (HTML + JS + XML)
- Apex: 120 lines
- Total: 360 lines of production code
- Zero compilation errors
- All validations working

**Component Features:**
- 1 search box
- 1 refresh button
- Dynamic course cards
- 2 badge types (Available/Full)
- 1 enrollment button per course
- Toast notifications
- Loading spinner

**Business Rules Enforced:**
- Duplicate enrollment prevention ✅
- Capacity management ✅
- User-based enrollment ✅
- Real-time seat tracking ✅
- Automatic updates ✅

**Time Investment:**
- Component development: 3 hours
- Apex controller: 2 hours
- Testing and debugging: 2 hours
- Documentation: 1 hour
- **Total: 8 hours**

---

## 💡 Key Takeaways

1. **Wire vs Imperative:** Use @wire for display, imperative for DML
2. **Toast Messages:** Essential for user feedback on actions
3. **refreshApex:** Keep UI in sync after server changes
4. **Validation in Apex:** Always validate on server side
5. **User Context:** UserInfo.getUserEmail() for current user
6. **Error Handling:** Try-catch in both JS and Apex
7. **Computed Properties:** Keep template logic simple
8. **Data Transformation:** Process server data for UI needs

---

## 🆚 Week 6 vs Week 7

| Aspect | Week 6 | Week 7 |
|--------|--------|--------|
| **Complexity** | Display only | Create + Validate |
| **Apex Methods** | Read-only | Read + Write |
| **User Actions** | View, search | Enroll, validate |
| **Feedback** | Static | Toast messages |
| **Data Flow** | One-way | Bi-directional |
| **State Management** | Simple | Complex |
| **Lines of Code** | 135 | 360 |

---

## 🐛 Challenges & Solutions

### **Challenge 1: Component Caching**
- **Problem:** Lightning App Builder cached old version
- **Solution:** Hard refresh (Ctrl+Shift+R) and rebuild page
- **Learning:** Always hard refresh after deployment

### **Challenge 2: Search/Refresh Not Showing**
- **Problem:** HTML syntax errors in conditional rendering
- **Solution:** Fixed template tags and conditional attributes
- **Learning:** `if:true` only works on `<template>` tags

### **Challenge 3: No Courses Displaying**
- **Problem:** Date filter excluded all courses
- **Solution:** Changed `WHERE Start_Date__c >= TODAY` to `WHERE Id != null`
- **Learning:** Always verify data matches query filters

### **Challenge 4: Multiple Code Iterations**
- **Problem:** Multiple versions causing confusion
- **Solution:** Final complete code provided
- **Learning:** Test thoroughly before giving code to user

---

## 🚀 Week 7 Achievements

**Component:**
- ✅ Advanced LWC with full CRUD capability
- ✅ Interactive search and filtering
- ✅ Real-time data updates
- ✅ Professional toast notifications
- ✅ Comprehensive error handling

**Apex:**
- ✅ Complex validation logic
- ✅ Safe DML operations
- ✅ Custom error messages
- ✅ User context awareness
- ✅ Business rule enforcement

**Skills:**
- ✅ Imperative Apex calls
- ✅ Promise handling
- ✅ Toast events
- ✅ Data transformation
- ✅ Advanced JavaScript
- ✅ Production-ready code

---

## 📸 Screenshots

**Location:** `documentation/screenshots/week-07/`

1. `week-07-component-complete.png` - Full component view
2. `week-07-available-course.png` - Course with seats available
3. `week-07-full-course.png` - Full course with disabled button
4. `week-07-success-toast.png` - Success notification
5. `week-07-search-working.png` - Search functionality
6. `week-07-lwc-files.png` - Component files in VS Code
7. `week-07-apex-controller.png` - Apex controller code
8. `week-07-enrollment-record.png` - Created enrollment record

---

## 🏆 Achievement Unlocked

**Status:** Advanced Salesforce Developer ✅

**Capabilities:**
- Build complex interactive UIs
- Implement business logic validation
- Handle user input and feedback
- Manage application state
- Create production-ready components
- Deploy full-stack solutions

**Portfolio Value:**
- Working enrollment system
- Real-world validation logic
- Professional user experience
- Complete error handling
- Scalable architecture

---

## 🎯 Next Steps

**Potential Enhancements:**
- Add term filter dropdown
- Show course prerequisites
- Display course ratings/reviews
- Add waitlist functionality
- Export enrollment list
- Email confirmations
- Schedule conflict detection

**Week 8 Preview:**
- Component communication
- Parent-child data flow
- Custom events
- Lightning Message Service
- Pub-sub patterns

---

**Week 7 Complete!** 🎉

