# EduPath AI - Intelligent Learning Management Platform

![Project Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Week](https://img.shields.io/badge/Week-2-green) 

## 🎓 Project Overview

EduPath AI is a comprehensive Education Cloud platform that transforms student success through AI-powered predictions, personalized career pathways, and automated engagement.

**Built by:** Rahul Akula  
**Timeline:** 24 weeks (Dec 2024 - June 2025)  
**Status:** Week 2 Complete ✅

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
- **Week 3** 🎯 Automation & Process Builder - NEXT 


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


## 👨‍💻 About

**Rahul Akula**  
Master's in Information Systems (Data Analytics)  
Transitioning into Salesforce Development

**Repository:** https://github.com/Akularahul/edupath-ai-salesforce

---

⭐ Star this repo to follow the journey!
