\# Week 2 Summary: Education Data Model Complete ✅



\*\*Duration:\*\* December 29, 2024 - January 3, 2025  

\*\*Status:\*\* 🟢 100% Complete  

\*\*Total Time:\*\* ~20 hours over 7 days



---



\## 🎯 Week 2 Objectives - All Achieved!



\- ✅ Build complete university enrollment system

\- ✅ Master custom objects and relationships

\- ✅ Implement junction objects with rollup summaries

\- ✅ Import bulk data (100+ students, 50+ course offerings)

\- ✅ Create reports and dashboards for business insights

\- ✅ Demonstrate production-ready Salesforce skills



---



\## 🏗️ What Was Built



\### Custom Objects Created (5 Total)



\*\*1. Student\_\_c\*\*

\- Purpose: Store student information

\- Records: 100 students

\- Fields: 16 (11 custom + 5 formula)

\- Validation Rules: 5

\- Key Features:

&nbsp; - Auto-number record name (STU-0001)

&nbsp; - Academic standing calculation

&nbsp; - Age and years enrolled formulas

&nbsp; - Email domain extraction



\*\*2. Academic\_Program\_\_c\*\*

\- Purpose: Degree programs offered

\- Records: 10 programs

\- Fields: 7 custom fields

\- Programs:

&nbsp; - Bachelor's: CS, Business, Psychology, Engineering, Nursing, Math, English

&nbsp; - Master's: Data Science, MBA

&nbsp; - Associate: CS



\*\*3. Course\_\_c\*\*

\- Purpose: Course catalog

\- Records: 15 courses

\- Fields: 12 (9 custom + 3 formula)

\- Validation Rules: 4

\- Key Features:

&nbsp; - Self-lookup for prerequisites

&nbsp; - Course number validation

&nbsp; - Credit hour requirements

&nbsp; - Department organization



\*\*4. Course\_Offering\_\_c\*\*

\- Purpose: Specific course sections in terms

\- Records: 50 offerings

\- Fields: 16 (11 custom + 3 rollup + 2 formula)

\- Key Features:

&nbsp; - Master-detail to Course

&nbsp; - Auto-calculating enrollment counts

&nbsp; - Seats available formula

&nbsp; - Average grade calculation

&nbsp; - Multi-select picklist for meeting days



\*\*5. Enrollment\_\_c (Junction Object!) ⭐\*\*

\- Purpose: Connect students to course offerings (many-to-many)

\- Records: 305 enrollments

\- Fields: 10 (6 custom + 2 master-detail + 2 formula)

\- Key Features:

&nbsp; - Two master-detail relationships (Student + Course Offering)

&nbsp; - Grade to GPA conversion formula

&nbsp; - Cross-object formula (Credits Attempted)

&nbsp; - Status tracking (Completed, In Progress, Dropped, etc.)



---



\## 📊 Data Model Architecture



```

STUDENT (100 records)

├─ Lookup → ACADEMIC PROGRAM

└─ Master-Detail ← ENROLLMENT (305)

&nbsp;                     ↓

&nbsp;                 ENROLLMENT (Junction Object)

&nbsp;                     ↓

&nbsp;                 Master-Detail → COURSE OFFERING (50)

&nbsp;                     ↓

&nbsp;                 Master-Detail → COURSE (15)

&nbsp;                     ↓

&nbsp;                 Self-Lookup → PREREQUISITE COURSE

```



\*\*Total Records Across All Objects:\*\* 480+



\*\*Relationships Implemented:\*\*

\- 1 Lookup relationship

\- 3 Master-Detail relationships

\- 1 Self-Lookup relationship

\- 1 Junction object (many-to-many)



---



\## 💡 Advanced Features Implemented



\### Rollup Summary Fields (3)



\*\*On Course Offering object:\*\*

1\. \*\*Current Enrollment\*\* - COUNT of all enrollments

&nbsp;  - Updates automatically when students enroll/drop

&nbsp;  - Real-time capacity tracking



2\. \*\*Total Grade Points\*\* - SUM of grade points

&nbsp;  - Only counts completed enrollments

&nbsp;  - Used for average calculation



3\. \*\*Graded Enrollments\*\* - COUNT of completed enrollments

&nbsp;  - Filter: Status = Completed

&nbsp;  - Enables average grade calculation



\*\*Result:\*\* Automatic GPA calculations with zero manual work!



---



\### Formula Fields (15 total)



\*\*Student Object (5 formulas):\*\*

\- Age (from Date of Birth)

\- Years Enrolled (from Enrollment Date)

\- Academic Standing (GPA-based categorization)

\- Full Name (concatenation)

\- Email Domain (text parsing)



\*\*Course Object (3 formulas):\*\*

\- Full Course Code (code + name)

\- Credit Category (low/standard/high)

\- Has Prerequisite (boolean check)



\*\*Course Offering Object (2 formulas):\*\*

\- Seats Available (Max - Current)

\- Average Grade (Total Points ÷ Count)



\*\*Enrollment Object (2 formulas):\*\*

\- Grade Points (letter grade → 4.0 scale)

\- Credits Attempted (cross-object reference)



---



\### Validation Rules (9 total)



\*\*Student Object (5 rules):\*\*

1\. GPA must be 0.0-4.0

2\. Enrollment Date not in future

3\. Email must contain @

4\. Graduated students must have GPA and 120+ credits

5\. Active students must have enrollment date



\*\*Course Object (4 rules):\*\*

1\. Credits must be 0.5-6.0

2\. Course code must have letters AND numbers

3\. Course number must match level

4\. Max enrollment must be 5-500



\*\*Impact:\*\* Data quality enforced automatically, prevents user errors



---



\## 📥 Bulk Data Operations



\### Data Import Wizard Mastery



\*\*Students Import:\*\*

\- 95 students imported via CSV

\- Challenge: Lookup field (Academic Program) mapping

\- Solution: Special CSV header format `Academic Program: Program Name`

\- Match by: Student ID (external ID)



\*\*Course Offerings Import:\*\*

\- 40 offerings imported via CSV

\- Lookup to Course via Course Code (external ID)

\- Multi-select picklist format (semicolon-separated)



\*\*Enrollments Import:\*\*

\- 238 enrollments imported via CSV

\- Two lookups: Student (by Student ID) + Course Offering (by Name)

\- Cross-object data validation



\*\*Key Learnings:\*\*

\- External IDs are critical for bulk imports

\- CSV formatting must be precise

\- Lookup field matching strategies

\- Testing with small batches first



---



\## 📊 Reports \& Dashboards



\### Reports Created (7)



1\. \*\*Active Students - Enrollment Summary\*\*

&nbsp;  - Tabular report, 70+ active students, sorted by GPA



2\. \*\*Course Popularity - Fall 2024\*\*

&nbsp;  - Shows enrollment counts, identifies overenrolled courses



3\. \*\*Student GPA Distribution\*\*

&nbsp;  - Summary report grouped by Academic Standing

&nbsp;  - Bell curve distribution



4\. \*\*At-Risk Students (GPA < 2.5)\*\*

&nbsp;  - 15-25 students needing support

&nbsp;  - Early intervention tool



5\. \*\*Students by Status\*\*

&nbsp;  - Summary report: 70% Active, 10% On Leave



6\. \*\*Enrollments by Status\*\*

&nbsp;  - 60% Completed, 20% In Progress



7\. \*\*Students by Academic Program\*\*

&nbsp;  - 30% Computer Science, STEM dominance



---



\### Dashboard Created (1)



\*\*University Enrollment Dashboard\*\*



\*\*6 Widgets (All Tables):\*\*

1\. Students by Enrollment Status

2\. Student Distribution by Program

3\. Top 10 Courses by Enrollment

4\. Student Academic Performance (GPA)

5\. At-Risk Students (GPA < 2.5)

6\. Top 10 Students by GPA



\*\*Purpose:\*\* Executive overview of university enrollment health



---



\## 🎓 Skills Demonstrated



\### Salesforce Administration

\- Custom object creation and configuration

\- Field management

\- Page layout customization

\- List view creation



\### Data Modeling

\- One-to-many relationships (lookup)

\- Many-to-many relationships (junction objects)

\- Self-referential relationships

\- Master-detail vs lookup decisions



\### Automation \& Formulas

\- Text, number, date formulas

\- Conditional logic (IF, CASE)

\- Cross-object formulas

\- Boolean formulas



\### Data Quality

\- Validation rules with complex logic

\- Required field enforcement

\- Unique field constraints

\- External ID configuration



\### Business Intelligence

\- Report creation (tabular and summary)

\- Dashboard design and layout

\- KPI identification

\- Data visualization



\### Data Management

\- Bulk data import via CSV

\- Data Import Wizard configuration

\- Lookup field mapping strategies

\- Data integrity verification



---



\## 📈 Project Statistics



\*\*Objects:\*\* 5 custom objects  

\*\*Fields:\*\* 61 custom fields  

\*\*Formula Fields:\*\* 15 auto-calculating fields  

\*\*Validation Rules:\*\* 9 data quality rules  

\*\*Rollup Summaries:\*\* 3 automatic aggregations  

\*\*Relationships:\*\* 6 total connections  

\*\*Records:\*\* 480+ across all objects  

\*\*Reports:\*\* 7 business intelligence reports  

\*\*Dashboards:\*\* 1 executive dashboard  

\*\*Dashboard Widgets:\*\* 6 data visualizations  



---



\## 🚧 Major Challenges Overcome



\### Challenge 1: Understanding Junction Objects

\- \*\*Resolution:\*\* Learned junction objects enable many-to-many relationships

\- \*\*Impact:\*\* Mastered the most important Salesforce relationship pattern



\### Challenge 2: Rollup Summary AVG Not Available

\- \*\*Resolution:\*\* Created 2 rollups (SUM + COUNT) + formula (Total ÷ Count)

\- \*\*Impact:\*\* Learned to combine features for complex requirements



\### Challenge 3: Data Import Wizard Lookup Mapping

\- \*\*Resolution:\*\* Changed CSV header to `Academic Program: Program Name`

\- \*\*Impact:\*\* Mastered bulk import of related data



\### Challenge 4: Standard vs Custom Field Naming

\- \*\*Resolution:\*\* Changed formula from Course\_Name\_\_c to Name

\- \*\*Impact:\*\* Deep understanding of Salesforce naming conventions



---



\## 💭 Key Learnings



\### Technical Insights



\*\*Junction Objects Are Everywhere\*\* - Mastering this pattern = 80% of Salesforce data modeling



\*\*Rollup Summaries = Automatic Reports\*\* - No manual counting needed, real-time updates



\*\*Formula Fields = Business Logic Without Code\*\* - Complex calculations without programming



\*\*External IDs = Import Performance\*\* - Faster, more reliable for lookups



---



\### Business Value



\*\*From Data to Decisions\*\* - Reports answer business questions, dashboards enable quick decisions



\*\*Automation Saves Time\*\* - Manual enrollment counting: 10+ hours/semester, Automated: 0 hours



\*\*Data Quality = Trust\*\* - Validation rules prevent errors, users trust the system



---



\## 📸 Portfolio Screenshots



\*\*Location:\*\* `documentation/screenshots/week-02/`



\*\*Key Screenshots:\*\*

\- Student object with all fields

\- Course Offering with rollup summaries (40 enrollment, 3.5 avg)

\- Schema Builder (data model diagram)

\- Dashboard with 6 widgets

\- At-Risk Students report

\- 100 students list view



---



\## 🎯 Week 2 Success Metrics



\*\*Planned vs Actual:\*\*

\- Estimated time: 14-21 hours ✅

\- Actual time: ~20 hours ✅

\- Days planned: 7 days ✅

\- Days completed: 7 days ✅

\- Objects planned: 5 objects ✅

\- Objects created: 5 objects ✅

\- \*\*100% completion rate!\*\* 🎉



---



\## ⏭️ Week 3 Preview



\*\*Theme:\*\* Automation \& Process Builder



\*\*Topics:\*\*

\- Workflow Rules

\- Process Builder

\- Approval Processes

\- Email Alerts

\- Field Updates



\*\*Goal:\*\* Add automation to the university enrollment system



---



\## 🏆 Achievements Unlocked



\- ✅ Custom Object Master

\- ✅ Junction Object Expert

\- ✅ Rollup Summary Wizard

\- ✅ Formula Field Champion

\- ✅ Validation Rule Designer

\- ✅ Bulk Data Import Specialist

\- ✅ Report Builder Pro

\- ✅ Dashboard Creator



---



\## 💪 Confidence Assessment



\*\*Before Week 2:\*\* Beginner  

\*\*After Week 2:\*\* Intermediate to Advanced



\*\*Can Now Confidently:\*\*

\- Design complex data models

\- Implement many-to-many relationships

\- Create sophisticated formulas

\- Enforce data quality with validation

\- Import bulk data via CSV

\- Build reports for business insights

\- Create dashboards for executives

\- Troubleshoot Salesforce issues



---



\## 🌟 Final Thoughts



Week 2 was transformative. The moment when I saw Current Enrollment auto-update from 2 to 40 students - that's when I truly understood the power of Salesforce.



The At-Risk Students report could literally help real students succeed. The Course Popularity report could help universities allocate resources better. This isn't just a learning exercise - it's real business value.



Most importantly, I now think like a Salesforce professional. When I see a business problem, I think: "What objects would I need? How would they relate? What formulas? What validation? What reports?"



\*\*Ready for Week 3!\*\* 🚀



---



\*\*Status:\*\* ✅ Week 2 Complete - 100%  

\*\*Next:\*\* Week 3 - Automation \& Process Builder  

\*\*GitHub:\*\* https://github.com/Akularahul/edupath-ai-salesforce



---



\*Week 2 Complete: January 3, 2025\*  

\*From zero to hero in 7 days. From 0 records to 480+.\*  

\*Ready for the next challenge.\* 💪🎉

