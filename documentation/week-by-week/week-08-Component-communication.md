# Week 8: Component Communication & Events

**Date:** February 14, 2026  
**Status:** ✅ Completed  
**Time Invested:** 7 hours

---

## 🎯 Week 8 Overview

**Theme:** Component Communication - Building components that work together

**What I Built:**
- ✅ Parent Component: Enrollment Dashboard
- ✅ Child Component 1: Course Card
- ✅ Child Component 2: Enrollment Summary
- ✅ Real-time communication between components
- ✅ Complete enrollment workflow in one dashboard

---

## 💻 Components Built

### **1. enrollmentDashboard (Parent)**
- Controls both child components
- Manages all data and state
- Handles enrollment logic
- Refreshes children after actions
- Files: HTML, JS, XML, CSS

### **2. courseCard (Child 1)**
- Displays individual course information
- Receives data FROM parent via @api
- Fires custom events TO parent
- Shows enrollment status
- Files: HTML, JS, XML, CSS

### **3. enrollmentSummary (Child 2)**
- Shows enrollment statistics
- Receives refresh call FROM parent
- Displays enrollment list
- Calculates totals dynamically
- Files: HTML, JS, XML, CSS

### **4. Apex Controllers**
- CourseEnrollmentController (existing)
- EnrollmentSummaryController (new)

---

## 🔄 Component Communication Flow
```
USER CLICKS ENROLL
        ↓
courseCard (Child 1)
fires CustomEvent('enroll')
        ↓
enrollmentDashboard (Parent)
catches onenroll event
calls createEnrollment Apex
        ↓
refreshApex (both wire services)
        ↓
summaryComponent.refresh()
        ↓
enrollmentSummary (Child 2)
updates stats automatically
```

---

## 🎓 Technical Skills Learned

### **@api Decorator:**
```javascript
// In child component (courseCard.js)
@api course;              // Parent passes data IN
@api enrolledCourseIds;   // Parent passes list IN

@api
refresh() {               // Parent can call this method
    return refreshApex(this.wiredResult);
}
```

### **Custom Events (Child → Parent):**
```javascript
// In child: FIRE the event
const enrollEvent = new CustomEvent('enroll', {
    detail: {
        courseId: courseId,
        courseName: this.course.Course__r.Name
    }
});
this.dispatchEvent(enrollEvent);

// In parent HTML: LISTEN for event
<c-course-card
    onenroll={handleCourseEnroll}>
</c-course-card>

// In parent JS: HANDLE the event
handleCourseEnroll(event) {
    const courseId = event.detail.courseId;
    // Do something with the data
}
```

### **Parent Calling Child Method:**
```javascript
// Parent JS: Call method on child
const summaryComponent = 
    this.template.querySelector('c-enrollment-summary');
if (summaryComponent) {
    summaryComponent.refresh();
}
```

### **Passing Data to Child:**
```html
<!-- Parent HTML: Pass data DOWN to child -->
<c-course-card
    course={course}
    enrolled-course-ids={enrolledCourseIds}
    onenroll={handleCourseEnroll}>
</c-course-card>
```

### **Refreshing Multiple Wire Services:**
```javascript
// Refresh both at same time
Promise.all([
    refreshApex(this.wiredCoursesResult),
    refreshApex(this.wiredEnrollmentsResult)
]).then(() => {
    // Both refreshed - update children
});
```

### **Dynamic CSS Classes:**
```javascript
get cardClass() {
    let baseClass = 'slds-box course-card';
    if (this.isEnrolled) baseClass += ' enrolled-card';
    if (this.course.isFull) baseClass += ' full-card';
    return baseClass;
}
```

---

## 📊 Results & Metrics

**Code Written:**
- enrollmentDashboard: 180 lines
- courseCard: 140 lines
- enrollmentSummary: 150 lines
- EnrollmentSummaryController: 50 lines
- Total: 520 lines

**Features Working:**
- ✅ Parent-child data passing
- ✅ Custom event communication
- ✅ Parent calling child methods
- ✅ Real-time stats updates
- ✅ Search and term filtering
- ✅ Enrollment with validation
- ✅ Toast notifications
- ✅ Refresh all functionality

---

## 💡 Key Takeaways

1. **@api = Public Interface:** Makes data/methods accessible to parent
2. **CustomEvent = Communication Up:** Child tells parent something happened
3. **querySelector = Find Child:** Parent can directly call child methods
4. **Promise.all = Parallel Refresh:** Refresh multiple sources simultaneously
5. **Component Composition:** Build complex UIs from simple pieces
6. **Single Source of Truth:** Parent owns the data, children display it
7. **Event-Driven Architecture:** Components react to events, not direct calls

---

## 🆚 Week 7 vs Week 8

| Aspect | Week 7 | Week 8 |
|--------|--------|--------|
| **Components** | 1 component | 3 components |
| **Communication** | None | Parent ↔ Child |
| **Architecture** | Monolithic | Composable |
| **Events** | Basic clicks | Custom events |
| **Data Flow** | One-directional | Bi-directional |
| **Reusability** | Single use | Reusable cards |
| **Lines of Code** | 360 | 520 |

---

## 🐛 Debugging Journey

### **Challenge 1: Child Event Not Reaching Parent**
- Problem: Event listener name mismatch
- Solution: onenroll in HTML matches 'enroll' in CustomEvent
- Learning: Event name must match exactly

### **Challenge 2: Summary Not Updating**
- Problem: Child component not receiving refresh call
- Solution: Used querySelector to find child after Promise.all
- Learning: querySelector works after wire refresh

### **Challenge 3: enrolledCourseIds Not Passing**
- Problem: @api property not updating in child
- Solution: Used track on parent, passed correctly
- Learning: @api is reactive to parent changes

---

## 🚀 Week 8 Achievements

- ✅ 3 working LWC components
- ✅ Complete parent-child architecture
- ✅ Custom event system
- ✅ Real-time UI updates
- ✅ Professional dashboard UI
- ✅ Reusable component design
- ✅ Full enrollment workflow

---

## 📸 Screenshots

**Location:** documentation/screenshots/week-08/

1. week-08-dashboard-complete.png
2. week-08-course-cards.png
3. week-08-enrollment-summary.png
4. week-08-after-enrollment.png
5. week-08-success-toast.png
6. week-08-component-structure.png
7. week-08-search-filter.png

---

**Week 8 Complete!** 🎉

*Next: Week 9 - Apex Advanced & SOQL Optimization*
```
