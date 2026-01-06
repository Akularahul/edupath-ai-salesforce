# Week 2 - Day 3: Academic Programs & Courses ✅

**Date:** December 30, 2024  
**Status:** 🟢 Complete

---

## 🎯 Goals Accomplished

- ✅ Created Academic Program custom object with 7 fields
- ✅ Created 10 academic program records
- ✅ Created Course custom object with 9 custom fields
- ✅ Created 15 course records
- ✅ Implemented Student → Academic Program lookup relationship
- ✅ Implemented Course → Prerequisite Course self-lookup relationship
- ✅ Added 4 validation rules to Course object
- ✅ Added 3 formula fields to Course object
- ✅ Created organized page layouts
- ✅ Created 3 custom list views

---

## 🏗️ Objects Created

### Academic Program Object

**Purpose:** Store degree programs offered by the university

**Custom Fields (7):**
1. **Program Code** (Text, 20) - Unique, External ID
   - Examples: BS-CS, BA-PSY, MBA
2. **Degree Type** (Picklist)
   - Values: Associate, Bachelor, Master, Doctoral, Certificate
3. **Department** (Text, 100) - Required
4. **Total Credits Required** (Number, 3, 0) - Default: 120
5. **Description** (Long Text Area, 32768)
6. **Active** (Checkbox) - Default: Checked
7. **Established Date** (Date)

**Records Created:** 10 programs
- Bachelor of Science in Computer Science (BS-CS)
- Bachelor of Science in Business Administration (BS-BA)
- Bachelor of Arts in Psychology (BA-PSY)
- Bachelor of Science in Engineering (BS-ENG)
- Bachelor of Science in Nursing (BS-NUR)
- Master of Science in Data Science (MS-DS)
- Master of Business Administration (MBA)
- Associate of Science in Computer Science (AS-CS)
- Bachelor of Science in Mathematics (BS-MATH)
- Bachelor of Arts in English (BA-ENG)

**Relationships:**
- Has many Students (one-to-many via lookup)

---

### Course Object

**Purpose:** Store general course information (course catalog)

**Custom Fields (9):**
1. **Course Code** (Text, 20) - Unique, External ID, Required
   - Examples: CS101, MATH201, ENG101
2. **Course Number** (Number, 4, 0)
   - Course level indicator (101, 201, 301, etc.)
3. **Credits** (Number, 2, 1) - Required, Default: 3
4. **Department** (Picklist)
   - 13 departments including CS, Math, English, Business, etc.
5. **Description** (Long Text Area)
6. **Active** (Checkbox) - Default: Checked
7. **Level** (Picklist)
   - 100-Introductory, 200-Intermediate, 300-Advanced, 400-Senior, 500-Graduate, 600-Advanced Graduate
8. **Maximum Enrollment** (Number, 3, 0) - Default: 30
9. **Prerequisite** (Lookup to Course) - Self-lookup for course dependencies

**Formula Fields (3):**
1. **Full Course Code** (Text)
   - Formula: `Course_Code__c & " - " & Name`
   - Example: "CS101 - Introduction to Programming"
2. **Credit Category** (Text)
   - Categorizes as Low Credit (≤1), Standard Credit (≤3), or High Credit (>3)
3. **Has Prerequisite** (Checkbox)
   - Formula: `NOT(ISBLANK(Prerequisite__c))`
   - Indicates if course requires prerequisite

**Validation Rules (4):**
1. **Credits_Must_Be_Valid**
   - Ensures credits between 0.5 and 6.0
2. **Course_Code_Must_Have_Letters_And_Numbers**
   - Validates format contains both letters and numbers
3. **Course_Number_Must_Match_Level**
   - Ensures course number matches selected level (100s for Introductory, etc.)
4. **Maximum_Enrollment_Must_Be_Reasonable**
   - Ensures enrollment between 5 and 500 students

**Records Created:** 15 courses
- CS101 - Introduction to Programming
- CS201 - Data Structures and Algorithms (Prereq: CS101)
- CS202 - Web Development (Prereq: CS101)
- CS301 - Database Systems (Prereq: CS201)
- CS401 - Software Engineering (Prereq: CS201)
- MATH201 - Calculus I
- MATH202 - Calculus II (Prereq: MATH201)
- MATH221 - Introduction to Statistics
- MATH301 - Linear Algebra (Prereq: MATH201)
- ENG101 - English Composition I
- BIOL101 - General Biology I
- CHEM101 - General Chemistry I
- BUS201 - Principles of Management
- PSY101 - Introduction to Psychology
- PHYS201 - Physics I - Mechanics (Prereq: MATH201)

**Relationships:**
- Self-lookup: Prerequisite Course
- Has many: Advanced Courses (courses that use this as prerequisite)
- Has many: Course Offerings (one-to-many)

---

## 🔗 Relationships Implemented

### Student → Academic Program (Lookup Relationship)

**Type:** Lookup  
**Direction:** Student looks up to Academic Program  
**Purpose:** Track which degree program each student is pursuing

**Features:**
- Optional (students can be prospective without program)
- Creates "Students" related list on Academic Program
- Allows filtering students by program

**Example:**
- John Doe → Bachelor of Science in Computer Science
- Sarah Johnson → Bachelor of Science in Business Administration
- Emily Rodriguez → Bachelor of Science in Computer Science

---

### Course → Prerequisite Course (Self-Lookup)

**Type:** Self-Lookup (Course relates to itself)  
**Direction:** Course looks up to another Course  
**Purpose:** Establish course dependency chains

**Features:**
- Optional (100-level courses typically have no prerequisites)
- Creates "Advanced Courses" related list
- Enables course hierarchy (CS101 → CS201 → CS301 → CS401)

**Example Prerequisite Chains:**
```
CS101 (Intro Programming)
  ↓
CS201 (Data Structures)
  ↓
  ├─→ CS301 (Databases)
  └─→ CS401 (Software Engineering)

MATH201 (Calculus I)
  ↓
  ├─→ MATH202 (Calculus II)
  ├─→ MATH301 (Linear Algebra)
  └─→ PHYS201 (Physics I)
```

---

## 📊 List Views Created

### 1. Computer Science Courses
- **Filter:** Department equals "Computer Science"
- **Shows:** 5 courses (CS101, CS201, CS202, CS301, CS401)
- **Use Case:** Quickly view all CS courses

### 2. Introductory Courses
- **Filter:** Level equals "100 - Introductory"
- **Shows:** 5 courses (CS101, ENG101, BIOL101, CHEM101, PSY101)
- **Use Case:** New student course selection

### 3. Courses with Prerequisites
- **Filter:** Has Prerequisite equals TRUE
- **Shows:** 7 courses with prerequisites
- **Use Case:** Identify advanced courses requiring prior courses

---

## 💡 Key Learnings

### Understanding Relationships

**Lookup vs Master-Detail:**
- **Lookup:** Loose connection, optional, used for Student → Program
- **Master-Detail:** Tight connection, required, used later for Enrollments
- **Self-Lookup:** Object relates to itself, enables hierarchies

**Related Lists:**
- Automatically created on parent object
- Show all child records
- Enable quick navigation between related records

### Standard vs Custom Fields

**Critical Discovery:**
- Standard fields don't have `__c` suffix (e.g., `Name`, `Id`)
- Custom fields have `__c` suffix (e.g., `Course_Code__c`)
- **Error encountered:** Used `Course_Name__c` in formula instead of `Name`
- **Solution:** Changed formula to use `Name` (standard field)
- **Learning:** Always check field API names in Object Manager

### Formula Field Best Practices

1. **Always use Check Formula** button to verify syntax
2. **Reference standard fields correctly** (Name, Id, CreatedDate)
3. **Reference custom fields with __c** (Field_Name__c)
4. **Cross-object formulas** use relationship name: `Prerequisite__r.Course_Code__c`

### Validation Rules in Action

- Prevent invalid course codes (must have letters AND numbers)
- Ensure course numbers match levels (101-199 for level 100)
- Enforce business rules at data entry
- Better than relying on user training

---

## 🚧 Challenges Faced

### Challenge 1: Formula Field Error - Course Name

**Issue:** Formula field "Full Course Code" showed error:
```
Error: Field Course_Name__c does not exist. Check spelling
```

**Root Cause:**
- Assumed Course Name would be `Course_Name__c`
- Actually stored in standard `Name` field (no __c suffix)

**Solution:**
- Changed formula from `Course_Name__c` to `Name`
- Correct formula: `Course_Code__c & " - " & Name`

**Lesson Learned:**
- Every custom object has a standard `Name` field
- Standard fields don't use `__c` naming convention
- Always verify field API names before writing formulas

---

### Challenge 2: Understanding Self-Lookup

**Initial Confusion:**
- "How can a course relate to itself?"
- Seemed circular or confusing

**Clarity:**
- Self-lookup creates parent-child within same object
- CS101 (parent) ← CS201 (child with prerequisite)
- Enables unlimited depth hierarchy
- Common pattern for prerequisites, managers, categories

**Implementation:**
- Created lookup field on Course pointing to Course
- Named child relationship "Advanced_Courses"
- Now CS101 shows all courses that require it

---

## 🎨 Page Layout Organization

### Course Layout Sections:

**Information Section:**
- Course Code | Course Number
- Course Name (full width)
- Department | Level
- Credits | Maximum Enrollment
- Description (full width)
- Prerequisite | Active

**Calculated Fields Section:**
- Full Course Code | Credit Category
- Has Prerequisite |

**Related Lists:**
- Advanced Courses (courses using this as prerequisite)
- Course Offerings (specific sections in terms)

---

## 📈 Data Model Progress

### Objects Completed:
```
STUDENT (5 records)
├─ 11 custom fields
├─ 5 formula fields
├─ 5 validation rules
└─ Relates to → ACADEMIC PROGRAM

ACADEMIC PROGRAM (10 records)
├─ 7 custom fields
└─ Shows → Students (related list)

COURSE (15 records)
├─ 9 custom fields
├─ 3 formula fields
├─ 4 validation rules
└─ Self-lookup → Prerequisite Course
```

**Total So Far:**
- 3 custom objects
- 27 custom fields
- 8 formula fields
- 9 validation rules
- 30+ records with realistic data

---

## ⏱️ Time Spent

**Total:** ~4 hours

**Breakdown:**
- Academic Program object creation: 30 min
- Academic Program data entry: 20 min
- Course object creation: 45 min
- Course validation rules: 20 min
- Course formula fields: 25 min
- Course data entry: 30 min
- Page layout organization: 20 min
- List view creation: 15 min
- Troubleshooting formula error: 10 min
- Testing and verification: 20 min

---

## 🎯 Success Metrics

- ✅ 2 new custom objects created and deployed
- ✅ 10 academic programs covering major disciplines
- ✅ 15 courses with realistic descriptions
- ✅ 7 prerequisite relationships established
- ✅ 4 validation rules protecting data quality
- ✅ 3 formula fields auto-calculating values
- ✅ 3 list views for easy filtering
- ✅ All students assigned to programs
- ✅ 100% of fields on page layouts
- ✅ All objects have custom tabs

---

## 📸 Screenshots

Location: `documentation/screenshots/week-02/day-03/`

**Screenshots taken:**
1. Academic Programs list view (10 programs)
2. Course list view (15 courses)
3. CS201 course showing prerequisite to CS101
4. CS101 course showing Advanced Courses related list
5. Computer Science Courses list view
6. Student record showing Academic Program field
7. Academic Program showing Students related list
8. Course validation rule in action
9. Full Course Code formula field working

---

## 🔍 Testing Performed

### Validation Rule Testing:
✅ Tried to save course with credits > 6.0 → Error displayed  
✅ Tried course code "CS" (no numbers) → Error displayed  
✅ Tried course number 150 with level "200-Intermediate" → Error displayed  
✅ Valid data saves successfully

### Formula Field Testing:
✅ Full Course Code displays "CS101 - Introduction to Programming"  
✅ Credit Category shows "Standard Credit" for 3-credit courses  
✅ Has Prerequisite shows checked for CS201, unchecked for CS101

### Relationship Testing:
✅ CS101 shows 3 courses in "Advanced Courses" related list  
✅ Student record shows selected Academic Program  
✅ Academic Program shows 2 students in "Students" related list

---

## 🛠️ Salesforce Skills Practiced

**Object Management:**
- Custom object creation (2 objects)
- Field creation (16 fields)
- Tab creation and icon selection

**Relationship Types:**
- Lookup relationships
- Self-lookup relationships
- Related list configuration

**Data Quality:**
- Validation rules (4 rules)
- Picklist value restrictions
- Required field enforcement
- Complex formula validation

**Formula Fields:**
- Text concatenation
- Conditional logic (IF statements)
- Boolean formulas (ISBLANK)
- Cross-object references

**User Interface:**
- Page layout editing
- Field organization and sections
- List view creation and filtering
- Search layout optimization

**Data Management:**
- Manual data entry (25 records)
- Maintaining data relationships
- Testing data integrity

---

## 📚 Trailhead Modules Relevant

- Salesforce Data Modeling
- Formula Fields
- Validation Rules
- Object Relationships
- Lookup Relationships

---

## ⏭️ Next Steps - Day 4

**Tomorrow's Focus:** Course Offerings & Enrollments (Junction Objects!)

**What We'll Build:**
- Course Offering object (specific course sections in terms)
- Enrollment object (junction connecting students to course offerings)
- Master-Detail relationships (2 on one object!)
- Rollup Summary fields (auto-count enrollments)
- Formula fields calculating seats available

**Why It Matters:**
- Junction objects enable many-to-many relationships
- Students can enroll in multiple courses
- Courses can have multiple students
- Everything connects through Enrollment!

**Estimated Time:** 3-4 hours

---

## 💭 Reflections

**What Went Well:**
- Smooth object creation process
- Validation rules working perfectly
- Prerequisite chain makes logical sense
- Page layouts look professional

**What Was Challenging:**
- Understanding standard vs custom field naming
- Formula field syntax with cross-object references
- Debugging the Course_Name__c error

**What I Learned:**
- Self-lookups are powerful for hierarchical data
- Validation rules catch errors before they corrupt data
- Formula fields reduce manual work
- Salesforce naming conventions are critical

**Confidence Level:** 🟢 High
- Comfortable creating objects and fields
- Understanding relationships better
- Ready for more complex concepts (junction objects!)

---

**Status:** ✅ Complete  
**Next:** [Day 4 - Course Offerings & Enrollments](week-02-day-04.md)

---

*This documentation is part of the EduPath AI project - a 24-week Salesforce learning journey.*
*GitHub Repository: https://github.com/Akularahul/edupath-ai-salesforce*