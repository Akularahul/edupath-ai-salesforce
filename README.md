<!-- Header -->
<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:0f0c29,50:302b63,100:24243e&height=200&section=header&text=EduPath%20AI&fontSize=56&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=AI-Powered%20Salesforce%20Education%20Cloud%20Platform%20·%20Agentforce%20·%20Einstein&descSize=16&descAlignY=60&descColor=a5b4fc" />

<div align="center">

![Salesforce](https://img.shields.io/badge/Salesforce-00A1E0?style=flat-square&logo=salesforce&logoColor=white)
![Education Cloud](https://img.shields.io/badge/Education%20Cloud-032D60?style=flat-square&logo=salesforce&logoColor=white)
![Agentforce](https://img.shields.io/badge/Agentforce-1798c1?style=flat-square&logo=salesforce&logoColor=white)
![Apex](https://img.shields.io/badge/Apex-00A1E0?style=flat-square&logo=salesforce&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-22c55e?style=flat-square)

</div>

## ◈ Overview

**EduPath AI** is an intelligent Salesforce Education Cloud platform that streamlines student onboarding and surfaces at-risk students in real time. It combines a robust seven-object schema with Agentforce-aligned proactive intelligence to help advising teams intervene early and act on data — not guesswork.

## ◈ Key Features

- 🏗️ **Seven-object Education Cloud schema** with **20 validation rules**, **10 formula fields**, and **4 roll-up summaries**
- ⚙️ **6 Flows + 3 automations** that cut student onboarding from **12 steps to 3**
- 🚨 **GPA-based at-risk alerts** and **enrollment-capacity triggers** across **500 student records**
- 🤖 **Agentforce-aligned intelligence** surfacing real-time intervention opportunities
- 🧪 **Bulkified Apex trigger** with **96% test coverage** across **8 test methods**
- 🎯 **Personalized career pathways** and automated student engagement

## ◈ Architecture

```
Student Record  →  Onboarding Flow (3 steps)  →  Enrollment Automation
      │                                                │
      ▼                                                ▼
  GPA Monitor  →  At-Risk Trigger (Apex)  →  Agentforce Alert / Advisor Task
                                                       │
                                                       ▼
                                        Dashboards (Retention & Success KPIs)
```

## ◈ Tech Stack

| Layer | Technology |
|---|---|
| Platform | Salesforce Education Cloud |
| Automation | Apex Triggers, Record-Triggered Flows |
| AI | Agentforce, Einstein Analytics |
| Data | 7 Custom Objects, Validation Rules, Roll-Up Summaries |
| DevOps | SFDX, GitHub |

## ◈ Project Structure

```
force-app/main/default/
├── classes/            # Bulkified Apex triggers, handlers, tests (96% coverage)
├── flows/              # Onboarding, enrollment, and alert automations
├── objects/            # 7-object Education Cloud schema
├── layouts/            # Student & program page layouts
└── permissionsets/     # Advisor & admin access
```

## ◈ Getting Started

```bash
# Authorize a Salesforce org
sf org login web --alias EduPathAI

# Deploy metadata
sf project deploy start --target-org EduPathAI

# Run Apex tests
sf apex run test --target-org EduPathAI --code-coverage
```

## ◈ Roadmap

- [ ] Predictive enrollment forecasting with Einstein
- [ ] Conversational Agentforce advising assistant
- [ ] Experience Cloud student self-service portal

---

<div align="center">

**Built by Rahul Akula** · Salesforce Certified Administrator & Agentforce Specialist

<a href="https://www.linkedin.com/in/rahulakula"><img src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat-square&logo=linkedin&logoColor=white"/></a>
&nbsp;
<a href="mailto:akula.rahul4545@gmail.com"><img src="https://img.shields.io/badge/Email-Say%20Hello-EA4335?style=flat-square&logo=gmail&logoColor=white"/></a>

</div>
