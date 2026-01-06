# Week 2 - Day 6: Reports & Dashboards ✅

**Date:** January 3, 2025  
**Status:** 🟢 Complete

---

## 🎯 Goals Accomplished

- ✅ Created 7 custom reports
- ✅ Built 1 comprehensive dashboard with 6 widgets
- ✅ Learned report builder interface
- ✅ Mastered summary reports and grouping
- ✅ Created filters for targeted data views
- ✅ Visualized 480+ records of university data
- ✅ Generated actionable business insights

---

## 📊 Reports Created

### Report 1: Active Students - Enrollment Summary

**Type:** Tabular Report  
**Purpose:** Show all active students with enrollment details

**Fields:**
- Student ID
- Full Name
- Email
- Academic Program
- GPA
- Total Credits Completed
- Enrollment Date
- Status

**Filters:**
- Status = Active

**Sort:**
- GPA Descending (highest first)

**Results:**
- ~70-75 active students
- Top student: Zoe Sanders (GPA 3.99)
- Provides quick snapshot of current student body

**Use Case:** Academic advisors reviewing current students

---

### Report 2: Course Popularity - Fall 2024

**Type:** Tabular Report  
**Purpose:** Identify most popular course offerings

**Fields:**
- Course Offering Name (auto-number)
- Course (related course name)
- Term
- Section
- Instructor
- Current Enrollment (rollup summary!)
- Seats Available (formula field!)
- Average Grade (formula field!)
- Status

**Filters:**
- Status = In Progress
- Term = Fall 2024

**Sort:**
- Current Enrollment Descending

**Results:**
- Top courses with 30-40 students
- Some courses overenrolled (negative seats available)
- Shows which courses need additional sections

**Key Insight:** CS101 and MATH201 are most popular, consistently overenrolled

**Use Case:** Course scheduling and capacity planning

---

### Report 3: Student GPA Distribution

**Type:** Summary Report (Grouped)  
**Purpose:** Analyze academic performance distribution

**Grouping:**
- Academic Standing (formula field)
  - Dean's List (GPA ≥ 3.5)
  - Good Standing (3.0-3.49)
  - Satisfactory (2.0-2.99)
  - Academic Probation (<2.0)

**Fields:**
- Student Name
- GPA
- Total Credits Completed
- Status

**Results:**
- Dean's List: ~12 students (12%)
- Good Standing: ~45 students (45%)
- Satisfactory: ~28 students (28%)
- Probation: ~15 students (15%)

**Key Insight:** Bell curve distribution shows realistic academic performance

**Use Case:** Academic standards monitoring, honors program selection

---

### Report 4: At-Risk & Struggling Students (GPA < 2.5)

**Type:** Tabular Report  
**Purpose:** Identify students needing academic support

**Fields:**
- Student ID
- Full Name
- Email
- Academic Program
- GPA
- Total Credits Completed
- Enrollment Date
- Status

**Filters:**
- Status = Active
- GPA < 2.5
- Total Credits Completed > 15

**Sort:**
- GPA Ascending (lowest first)

**Results:**
- 15-25 students needing support
- Lowest GPA around 2.0-2.2
- Mix of programs and year levels

**Key Insight:** Intervention needed before students fall below 2.0

**Use Case:** Academic advising, tutoring program enrollment, early intervention

---

### Report 5: Students by Status

**Type:** Summary Report  
**Purpose:** Show student distribution across enrollment statuses

**Grouping:**
- Status

**Results:**
- Active: ~70 students (70%)
- On Leave: ~10 students (10%)
- Graduated: ~5 students (5%)
- Prospective: ~5 students (5%)
- Withdrawn: ~5 students (5%)
- Other: ~5 students (5%)

**Key Insight:** Healthy retention with 70% active enrollment

**Use Case:** Enrollment reporting, retention analysis

---

### Report 6: Enrollments by Status

**Type:** Summary Report  
**Purpose:** Analyze enrollment completion rates

**Grouping:**
- Enrollment Status

**Fields:**
- Student Name
- Course Offering
- Enrollment Date
- Grade
- Attendance Percentage

**Results:**
- Completed: ~180 enrollments (60%)
- In Progress: ~60 enrollments (20%)
- Enrolled (future): ~40 enrollments (13%)
- Dropped: ~15 enrollments (5%)
- Withdrawn: ~10 enrollments (3%)

**Key Insight:** 60% completion rate is realistic, 5% drop rate acceptable

**Use Case:** Course retention analysis, dropout prevention

---

### Report 7: Students by Academic Program

**Type:** Summary Report  
**Purpose:** Show student distribution across degree programs

**Grouping:**
- Academic Program

**Results:**
- Computer Science: ~30 students (30%)
- Business Administration: ~20 students (20%)
- Psychology: ~15 students (15%)
- Engineering: ~12 students (12%)
- Nursing: ~10 students (10%)
- Mathematics: ~5 students (5%)
- English: ~3 students (3%)
- Master's Programs: ~5 students (5%)

**Key Insight:** STEM programs dominate enrollment

**Use Case:** Program planning, resource allocation, marketing focus

---

## 📈 Dashboard Created

### Dashboard: University Enrollment Dashboard

**Description:** Comprehensive view of key enrollment metrics and student performance

**Location:** Public Dashboards folder

**Refresh Schedule:** Daily (automatic)

---

### Dashboard Components (6 Widgets)

#### Widget 1: Students by Enrollment Status

**Type:** Table  
**Source:** Students by Status report  
**Size:** Medium  
**Location:** Top Left

**Display:**
- Status categories
- Student count per status
- Percentage distribution

**Insight:** Quick view of enrollment health

---

#### Widget 2: Student Distribution by Program

**Type:** Table  
**Source:** Students by Academic Program report  
**Size:** Medium  
**Location:** Top Right

**Display:**
- Program names
- Student count
- Sorted by enrollment (highest first)

**Insight:** Which programs are growing/declining

---

#### Widget 3: Top 10 Courses by Enrollment

**Type:** Table  
**Source:** Course Popularity - Fall 2024 report  
**Size:** Medium  
**Location:** Middle Left

**Display:**
- Course name
- Current enrollment
- Seats available
- Average grade

**Insight:** Capacity planning and course demand

---

#### Widget 4: Student Academic Performance

**Type:** Table  
**Source:** Student GPA Distribution report  
**Size:** Medium  
**Location:** Middle Right

**Display:**
- Academic standing categories
- Student count per category
- Performance distribution

**Insight:** Overall academic health of student body

---

#### Widget 5: At-Risk Students (GPA < 2.5)

**Type:** Table  
**Source:** At-Risk & Struggling Students report  
**Size:** Medium  
**Location:** Bottom Left/Center

**Display:**
- Student names
- Current GPA
- Program
- Credits completed

**Insight:** Who needs immediate academic support

---

#### Widget 6: Top 10 Students by GPA

**Type:** Table  
**Source:** Active Students - Enrollment Summary report  
**Size:** Medium  
**Location:** Bottom Right/Full Width

**Display:**
- Student names
- GPA (sorted highest first)
- Program
- Credits completed

**Insight:** Honors recognition, scholarship eligibility

---

## 💡 Key Learnings

### Report Types

**Tabular Reports:**
- Simple list of records
- Best for detailed data views
- Can filter, sort, export
- Used for: Student lists, course rosters

**Summary Reports:**
- Groups records by field
- Shows subtotals and counts
- Better for analysis
- Used for: GPA distribution, status breakdown

**Matrix Reports:** (Not used in this project)
- Groups by rows AND columns
- Advanced analysis
- More complex setup

---

### Report Builder Skills

**Filters:**
- Field-based conditions (Status = Active)
- Multiple filters with AND logic
- Numeric comparisons (GPA < 2.5)
- Date filters (Enrollment Date)

**Sorting:**
- Ascending (lowest first)
- Descending (highest first)
- Critical for prioritization

**Grouping:**
- Summary reports require grouping
- Can group by formula fields
- Shows subtotals automatically

**Columns:**
- Add/remove fields
- Reorder for readability
- Show related object fields
- Include formula and rollup fields

---

### Dashboard Best Practices

**Layout:**
- Logical grouping of related metrics
- Most important metrics at top
- Balance between detail and overview
- White space for readability

**Widget Selection:**
- Tables for exact numbers
- Charts for trends (when available)
- Metrics for KPIs
- Mix types for variety

**Titles:**
- Clear, descriptive names
- Indicate what data shows
- Include filters/date ranges

**Audience:**
- Design for end users (administrators, advisors)
- Show actionable data
- Focus on decisions, not just data

---

### Data Insights Generated

**Student Performance:**
- 12% of students on Dean's List (excellent)
- 15% on academic probation (need support)
- Average GPA across university: ~3.2 (good)

**Enrollment Trends:**
- 70% active enrollment (healthy)
- 5% withdrawal rate (acceptable)
- STEM programs dominate (30%+ of students)

**Course Demand:**
- CS101 consistently overenrolled
- Need additional sections for popular courses
- Average class size: 25-30 students

**At-Risk Population:**
- 15-25 students need academic support
- Early intervention possible before failing
- Concentrated in certain programs

---

## 🚧 Challenges Overcome

### Challenge 1: Chart Widgets Not Available

**Issue:**
- Dashboard builder only showed Table option
- Expected Chart and Metric widgets
- Interface different than training materials

**Solution:**
- Created professional dashboard using only tables
- Tables actually preferred by many executives
- Shows exact numbers vs. visualizations

**Lesson:**
- Salesforce editions vary in features
- Table-based dashboards are equally valuable
- Adapt to available tools

---

### Challenge 2: Report Filters Showing Zero Results

**Issue:**
- At-Risk Students report (GPA < 2.0) showed 0 students
- Filters too restrictive

**Solution:**
- Broadened GPA filter to < 2.5
- Changed credits filter from > 0 to > 15
- Now shows 15-25 students needing support

**Lesson:**
- Filter criteria must match actual data
- Realistic thresholds matter
- Test filters before finalizing

---

### Challenge 3: Academic Program Showing Only 5 Programs

**Issue:**
- Summary report grouped by program
- Expected 10 programs, saw only 5
- Status filter was limiting results

**Solution:**
- Removed Status = Active filter
- Now shows all 10 programs
- Some programs have 0 active students (realistic)

**Lesson:**
- Filters affect grouping summaries
- Consider if filters align with goals
- All data vs. filtered data decisions

---

## ⏱️ Time Spent

**Total:** 2.5 hours

**Breakdown:**
- Report 1 creation and learning: 20 min
- Reports 2-7 creation: 60 min (faster after learning)
- Dashboard setup: 30 min
- Widget configuration: 30 min
- Layout and refinement: 15 min
- Testing and verification: 15 min

---

## 🎯 Success Metrics

- ✅ 7 reports covering key business needs
- ✅ 1 comprehensive dashboard
- ✅ 6 dashboard widgets showing critical data
- ✅ All reports pulling from 480+ records
- ✅ Actionable insights generated
- ✅ Professional appearance
- ✅ Ready for stakeholder presentation

---

## 🛠️ Salesforce Skills Mastered

**Report Creation:**
- Creating tabular reports
- Creating summary reports
- Adding and configuring filters
- Sorting data effectively
- Selecting and ordering columns
- Using formula fields in reports
- Using rollup summary fields in reports

**Dashboard Building:**
- Creating new dashboards
- Adding table widgets
- Configuring widget data sources
- Arranging dashboard layout
- Setting widget titles and properties
- Understanding dashboard refresh

**Business Analysis:**
- Identifying key metrics (KPIs)
- Translating data into insights
- Creating actionable reports
- Designing for end-user needs

---

## 📸 Screenshots

Location: `documentation/screenshots/week-02/day-06/`

**Screenshots taken:**
1. Active Students report (sorted by GPA)
2. Course Popularity report (showing overenrolled courses)
3. GPA Distribution summary report
4. At-Risk Students report (filtered list)
5. Students by Status summary report
6. Complete dashboard with 6 widgets
7. Dashboard edit mode showing widget configuration

---

## 💭 Reflections

**Most Rewarding Moment:**
Seeing the dashboard come together with real data! After 5 days of building the data model (students, programs, courses, enrollments), watching those 480+ records transform into visual insights was incredible. The "At-Risk Students" widget immediately identified 15-25 students who need help - that's real business value!

**Biggest Challenge:**
Chart widgets not being available was initially frustrating, but it taught me to adapt. Tables actually provide more precise data than charts in many cases, and executives often prefer exact numbers over visualizations.

**Key Insight:**
Reports and dashboards aren't just about displaying data - they're about answering business questions:
- Which students need help? (At-Risk report)
- Which courses need more sections? (Course Popularity)
- How is academic performance trending? (GPA Distribution)
- Which programs are growing? (Students by Program)

This is when Salesforce becomes a decision-making tool, not just a database!

**Confidence Level:** 🟢 Very High
- Comfortable creating reports
- Can design dashboards for business needs
- Understand difference between report types
- Ready to present data to stakeholders

**Portfolio Impact:**
This demonstrates:
- Business intelligence skills
- Data visualization
- Stakeholder communication
- Analytics mindset

Employers want admins who can turn data into insights - Day 6 proves I can do that!

---

## 📊 Business Value Delivered

**For Students:**
- At-Risk report enables early intervention
- Top Students report identifies honors candidates

**For Faculty:**
- Course Popularity shows demand
- Helps plan additional sections

**For Administrators:**
- Enrollment status shows retention
- Program distribution guides resources
- GPA distribution measures academic health

**For Leadership:**
- Dashboard provides executive overview
- KPIs visible at a glance
- Data-driven decision making

---

## ⏭️ Next Steps - Day 7

**Tomorrow:** Week 2 Wrap-up

**Goals:**
- Review everything built in Week 2
- Create comprehensive Week 2 documentation
- Commit all work to GitHub
- LinkedIn post showcasing Week 2 achievements
- Plan Week 3 activities

**Week 2 Achievements:**
- 5 custom objects (Student, Program, Course, Course Offering, Enrollment)
- 480+ records across all objects
- Junction object with rollup summaries
- 7 reports
- 1 dashboard
- Complete data model for university system

**Estimated Time:** 2 hours

---

**Status:** ✅ Complete  
**Achievement Unlocked:** 🏆 Reports & Dashboards Expert!  
**Next:** [Day 7 - Week 2 Wrap-up](week-02-day-07.md)

---

*Day 6 Complete! From raw data to actionable insights - this is the power of Salesforce reporting. The dashboard transforms 480+ records into clear business intelligence. Ready to present to stakeholders!*

*GitHub Repository: https://github.com/Akularahul/edupath-ai-salesforce*