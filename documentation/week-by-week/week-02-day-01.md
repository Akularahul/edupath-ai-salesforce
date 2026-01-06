# Week 2 - Day 1: Student Object Creation ✅

**Date:** December 29, 2024  
**Status:** 🟢 Complete

## 🎯 Goals Accomplished

- ✅ Created Student custom object
- ✅ Created custom tab with icon
- ✅ Added 11 custom fields with various data types
- ✅ Configured page layout
- ✅ Created 5 student records manually
- ✅ Created 2 custom list views

## 🏗️ What I Built

### Student Custom Object

**Object Settings:**
- API Name: `Student__c`
- Record Name: Auto-number (STU-{0000})
- Features Enabled:
  - Reports
  - Activities
  - Field History Tracking
  - Search
  - Bulk API
  - Streaming API

### Custom Fields Created (11 fields)

1. **Student ID** (Text, 20)
   - Required, Unique, External ID
   - Format: STU001, STU002, etc.

2. **First Name** (Text, 80)
   - Required

3. **Last Name** (Text, 80)
   - Required

4. **Email** (Email)
   - Required
   - Used for communications

5. **Phone** (Phone)
   - Optional contact number

6. **Date of Birth** (Date)
   - For age calculation

7. **Enrollment Date** (Date)
   - Required
   - When student enrolled

8. **Status** (Picklist)
   - Values: Prospective, Applied, Accepted, Enrolled, Active, On Leave, Graduated, Withdrawn
   - Default: Prospective

9. **GPA** (Number, 3, 2)
   - Grade Point Average on 4.0 scale

10. **Total Credits Completed** (Number, 3, 0)
    - Default: 0
    - Most degrees require 120 credits

11. **Expected Graduation Date** (Date)
    - Anticipated graduation

### Student Records Created

Created 5 sample students:

1. **STU-0001 - John Doe**
   - Status: Active
   - GPA: 3.45
   - Credits: 30

2. **STU-0002 - Sarah Johnson**
   - Status: Active
   - GPA: 3.89
   - Credits: 45

3. **STU-0003 - Michael Chen**
   - Status: On Leave
   - GPA: 2.85
   - Credits: 60

4. **STU-0004 - Emily Rodriguez**
   - Status: Active
   - GPA: 3.92
   - Credits: 90

5. **STU-0005 - David Williams**
   - Status: Prospective
   - GPA: 0.00
   - Credits: 0

### List Views Created

1. **Recently Viewed** (Default)
   - Shows all recently accessed students

2. **Active Students**
   - Filter: Status equals "Active"
   - Shows 3 students (John, Sarah, Emily)

3. **High GPA Students**
   - Filter: GPA greater than 3.5
   - Shows 2 students (Sarah, Emily)

## 💡 Key Learnings

### Custom Object Creation
- Objects are the foundation of Salesforce data model
- Auto-number fields provide unique identifiers
- Tab creation makes objects accessible to users

### Field Types
- **Text** - For names, IDs, general text
- **Email** - Validates email format
- **Phone** - For phone numbers
- **Date** - For dates (birth, enrollment, graduation)
- **Number** - For numeric values (GPA, credits)
- **Picklist** - For predefined options (Status)

### Page Layouts
- Control which fields appear on record pages
- Can organize fields in sections
- Drag-and-drop interface
- Required for new objects

### List Views
- Filter and organize records
- Can be shared with all users
- Essential for finding specific records
- Support multiple filter criteria

## 🚧 Challenges Faced

**Challenge 1: Fields Not Showing on New Record Form**
- **Issue:** Only "Student Name" and "Owner" fields visible
- **Solution:** Added custom fields to page layout using drag-and-drop
- **Lesson:** New fields must be added to page layouts to be visible

**Challenge 2: Understanding Auto-Number vs Text**
- **Issue:** Confusion about when to use auto-number vs text for IDs
- **Solution:** Auto-number for record name (STU-0001), text for Student ID (STU001)
- **Lesson:** Record names are internal; custom fields for user-facing IDs

## ⏱️ Time Spent

Approximately 3 hours:
- Object creation: 30 min
- Field creation: 45 min
- Page layout configuration: 30 min
- Data entry: 30 min
- List views: 20 min
- Exploration: 25 min

## 🛠️ Salesforce Skills Used

- Setup navigation
- Object Manager
- Custom object creation
- Field creation (multiple types)
- Page layout editing
- List view creation and filtering
- Data entry and record management

 

## 🎯 Success Metrics

- ✅ 1 custom object created
- ✅ 11 custom fields configured
- ✅ 5 student records entered
- ✅ 3 list views created
- ✅ Page layout configured
- ✅ All fields visible and functional

## 📸 Screenshots

See: documentation/screenshots/week-01/day-01/

## ⏭️ Next Steps

**Day 2:** Add validation rules and formula fields for:
- Data quality enforcement (GPA range, date validation)
- Auto-calculations (Age, Years Enrolled, Academic Standing)
- Enhanced user experience

---

**Status:** ✅ Complete  
**Next:** [Day 2 - Validation Rules & Formula Fields](week-02-day-02.md)