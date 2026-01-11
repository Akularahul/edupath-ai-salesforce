# EduPath AI - Intelligent Learning Management Platform

![Project Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Week](https://img.shields.io/badge/Week-2-green) 

## 🎓 Project Overview

EduPath AI is a comprehensive Education Cloud platform that transforms student success through AI-powered predictions, personalized career pathways, and automated engagement.

**Built by:** Rahul Akula  
**Timeline:** 24 weeks (Dec 2024 - June 2025)  
**Status:** Week 3 Complete ✅

## 🚀 Key Features

- **AI Student Success Prediction** - Identify at-risk students 4-6 weeks early
- **Personalized Career Pathways** - AI-driven course and career recommendations
- **Automated Engagement** - Marketing Cloud journeys for timely interventions
- **360° Student View** - Data Cloud unified profile
- **Self-Service Portals** - Experience Cloud for students, faculty, alumni
- **Real-Time Analytics** - Einstein Analytics dashboards
- **AI Virtual Advisor** - Agentforce 24/7 support chatbot

## 🛠️ Technology Stack

**Salesforce Products:**
- Education Cloud (Custom Data Model)
- Experience Cloud
- Einstein Analytics / Tableau CRM
- Marketing Cloud Account Engagement
- Data Cloud
- Agentforce

**Development:**
- Apex, Lightning Web Components (LWC)
- Salesforce Flow
- VS Code, Git, GitHub

## 📊 Certifications

**Completed:**
- ✅ Salesforce Administrator
- ✅ Agentforce Specialist

**In Progress:**
- 🎯 Platform Developer I

**Planned:**
- Education Cloud Consultant
- Experience Cloud Consultant
- Tableau CRM Consultant
- Platform Developer II

## 📅 Progress

- **Week 1** ✅ Foundation & Setup - COMPLETED
- **Week 2** ✅ Building Education Data Model - COMPLETED
- **Week 3** ✅ Automation & Process Builder - COMPLETED 
- **Week 4** 🎯 Advanced Flows - NEXT

## 🎓 Week 1: Foundation & Setup ✅

**Duration:** December 23-29, 2024

### Achievements:
- ✅ Set up Salesforce Developer Edition org
- ✅ Configured VS Code with Salesforce extensions
- ✅ Connected GitHub repository
- ✅ Completed Salesforce Admin certification
- ✅ Completed Agentforce Specialist certification
- ✅ Planned 24-week project roadmap

### Skills Gained:
- Salesforce org setup and navigation
- Development environment configuration
- Version control with Git/GitHub
- Project planning and documentation

**📋 [View Week 1 Details](documentation/week-01-summary.md)**

---

## 🎓 Week 2: Education Data Model ✅  ← ADD THIS NEW SECTION!

**Duration:** December 29, 2024 - January 3, 2025

### What I Built:
- ✅ **5 Custom Objects** (Student, Academic Program, Course, Course Offering, Enrollment)
- ✅ **480+ Records** of realistic university data
- ✅ **Junction Object** implementing many-to-many relationships
- ✅ **15 Formula Fields** for automated calculations
- ✅ **9 Validation Rules** ensuring data quality
- ✅ **3 Rollup Summaries** auto-counting enrollments & calculating GPAs
- ✅ **7 Business Reports** providing actionable insights
- ✅ **1 Executive Dashboard** with 6 widgets

### Key Achievements:
- 🎯 Mastered junction objects (Enrollment connects Students ↔ Course Offerings)
- 🎯 Implemented rollup summaries (auto-calculating enrollment counts & averages)
- 🎯 Built self-lookup relationship (Course prerequisites)
- 🎯 Imported bulk data (300+ records via Data Import Wizard)
- 🎯 Created At-Risk Student identification system

### Data Model:
```
Student (100) → Enrollment (305) ← Course Offering (50) → Course (15)
              ↘                  ↗
                Academic Program (10)
```

### Technical Skills Demonstrated:
- Complex data modeling (5 custom objects)
- Master-Detail vs Lookup relationships
- Cross-object formulas (3 levels deep)
- Rollup summary fields (COUNT, SUM, AVG)
- Data Import Wizard expertise
- Report & Dashboard building
- Validation rule creation
- Formula field development

### Business Value:
- At-Risk Student report identifies 15-25 students needing intervention
- Course Popularity dashboard shows capacity planning needs
- GPA Distribution analysis tracks academic health
- Real-time enrollment tracking eliminates manual counting

**📊 [View Week 2 Summary](documentation/WEEK-02-SUMMARY.md)**  
**📸 [View Screenshots](documentation/screenshots/week-02/)**


---

## 🎓 Week 3: Automation & Process Builder ✅ COMPLETE

**Duration:** January 6-10, 2026  
**Status:** ✅ Completed

### What I Built:
- ✅ **5 Workflow Rules** - Email automation and field updates
- ✅ **3 Process Builder Flows** - Multi-action automation with cross-object updates
- ✅ **1 Approval Process** - Course override workflow with dynamic routing
- ✅ **8 Email Templates** - Professional text and HTML templates
- ✅ **3 New Fields** - Supporting automation logic
- ✅ **13 Automated Actions** - Eliminating manual work

### Automation Rules Created:

**Workflow Rules:**
1. New Student Welcome Email - Immediate confirmation on enrollment
2. Auto-Update to Senior Status - Automatic progression at 90 credits
3. At-Risk Student Notification - Alerts when GPA < 2.5
4. Registration Reminder - Time-based workflow (7 days before deadline)
5. Student Leave Task Assignment - Creates advisor follow-up tasks

**Process Builder Flows:**
1. Enrollment Confirmation Process - 3 actions (email + 2 field updates)
2. Course Capacity Alert Process - Formula-based monitoring (80% threshold)
3. Graduate Status Automation - Auto-graduation at 120 credits with congratulations

**Approval Process:**
1. Course Override Approval - Controlled enrollment with instructor approval

### Key Achievements:
- 🎯 Cross-object field updates (update Student from Enrollment)
- 🎯 Formula-based criteria (80% capacity calculation)
- 🎯 Time-dependent workflows (scheduled reminders)
- 🎯 HTML email templates with professional CSS styling
- 🎯 Approval workflows with automatic status changes
- 🎯 Multi-action processes (3 actions in 1 trigger)

### Technical Skills Demonstrated:
- Workflow Rules configuration and evaluation criteria
- Process Builder multi-action flows
- Approval process design with Jump Start Wizard
- Email automation with merge fields (3 levels deep)
- Formula criteria expressions
- Time-based workflow actions
- Cross-object relationship traversal
- Record locking during approvals

### Business Value Delivered:
- **Enrollment confirmations:** 5 min × 300 enrollments = 25 hours saved/semester
- **At-risk monitoring:** Proactive intervention prevents dropouts
- **Capacity management:** Prevents overenrollment issues
- **Graduation automation:** Zero missed graduations
- **Override control:** Maintains enrollment integrity
- **Total time saved:** 50+ hours per semester automated

### System Capabilities:
✅ Automatic welcome emails for new students  
✅ Proactive at-risk student alerts to advisors  
✅ Course capacity monitoring and department notifications  
✅ Automatic graduation status progression  
✅ Registration deadline reminders (scheduled)  
✅ Controlled course override approvals  
✅ Advisor task creation for student leave  
✅ Zero manual intervention required!  

**📊 [View Week 3 Documentation](documentation/week-by-week/week-03-day-03.md)**  
**📸 [View Screenshots](documentation/screenshots/week-03/)**



## 👨‍💻 About

**Rahul Akula**  
Master's in Information Systems (Data Analytics)  
Transitioning into Salesforce Development

**Repository:** https://github.com/Akularahul/edupath-ai-salesforce

---

⭐ Star this repo to follow the journey!
