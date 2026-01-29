# Week 6: Lightning Web Components - Introduction

**Duration:** January 28-29, 2026  
**Status:** ✅ Completed  
**Time Invested:** 7 hours

---

## 🎯 Week 6 Overview

**Theme:** Lightning Web Components (LWC) - Modern UI Development  
**Goal:** Build first interactive LWC with proper development environment

**What I Built:**
- ✅ Professional development environment (VS Code + Salesforce CLI)
- ✅ Lightning Web Component: Enrollment Viewer (95 lines)
- ✅ Apex Controller: EnrollmentController (40 lines)
- ✅ Interactive UI with search and refresh functionality
- ✅ Deployed and working in Salesforce org

---

## 💻 Development Environment Setup

### **Tools Installed:**

**Visual Studio Code (VS Code):**
- Professional code editor for developers
- Syntax highlighting and IntelliSense
- Integrated terminal
- Extensions marketplace

**Salesforce CLI:**
- Command-line interface for Salesforce
- Version: @salesforce/cli/2.119.8
- Deploy, retrieve, and manage metadata
- Org authorization and management

**Salesforce Extensions Pack:**
- Lightning Web Components extension
- Apex Language Server
- SOQL syntax support
- Aura Components support
- Visualforce support
- Salesforce CLI Integration

### **Setup Process:**

**1. VS Code Installation:**
- Downloaded from code.visualstudio.com
- Installed with PATH configuration
- Created desktop shortcut

**2. Salesforce CLI Installation:**
- Downloaded Windows 64-bit installer
- Verified with `sf --version` command
- Tested with `sf --help` command

**3. Salesforce Extensions:**
- Installed Extension Pack from marketplace
- 8 extensions installed automatically
- Reloaded VS Code to activate

**4. Org Authorization:**
- Used CLI command: `sf org login web --alias EduPath-Org`
- Browser-based authentication
- OAuth flow completed
- Org connected successfully

**5. Project Creation:**
- Created project: `sf project generate --name edupath-lwc`
- Standard project structure generated
- Default org set for deployment

---

## 🖥️ Lightning Web Component: Enrollment Viewer

### **Purpose:**
Display current user's course enrollments in an interactive, searchable interface.

### **Component Structure:**

**3 Core Files:**
1. enrollmentViewer.html (82 lines)
2. enrollmentViewer.js (70 lines)
3. enrollmentViewer.js-meta.xml (10 lines)

### **Features Implemented:**

**UI Features:**
- Card-based layout with Lightning Design System
- Course icon and visual hierarchy
- Responsive grid for course details
- Status badges for enrollment status
- Search input with real-time filtering
- Refresh button for data reload
- Loading spinner during data fetch
- "No enrollments" empty state message

**Data Display:**
- Course name (from related Course object)
- Term and section information
- Enrollment status with badge
- Instructor name
- Organized in card format

**Interactive Features:**
- Search by course name (case-insensitive)
- Real-time filtering as user types
- Refresh button to reload data
- Responsive to user input

### **Technical Implementation:**

**HTML Template:**
```
- Lightning Card component
- Lightning Input (search box)
- Lightning Spinner (loading state)
- Lightning Icon (course icon)
- Lightning Badge (status)
- Lightning Button (refresh)
- Conditional rendering (if:true, if:false)
- List iteration (for:each)
- SLDS utility classes for styling
```

**JavaScript Controller:**
```javascript
- LightningElement base class
- @track decorator for reactive properties
- @wire decorator for data loading
- Apex integration via wire service
- Computed properties (get methods)
- Event handlers (onchange, onclick)
- Array filtering for search
- refreshApex for data refresh
```

**Metadata Configuration:**
```xml
- API version: 60.0
- Exposed to Lightning App Builder
- Available on: App Page, Record Page, Home Page
```

---

## 🔧 Apex Controller: EnrollmentController

### **Purpose:**
Backend service to fetch enrollment data for Lightning Web Component.

### **Method:**

**getEnrollments():**
- Annotated with @AuraEnabled(cacheable=true)
- Returns List<Enrollment__c>
- Queries current user's enrollments
- Includes related Course Offering and Course data
- Filters by user email
- Orders by enrollment date (newest first)
- Limits to 100 records
- Error handling with AuraHandledException

### **SOQL Query:**
```apex
SELECT Id, Status__c, Enrollment_Date__c,
       Course_Offering__c,
       Course_Offering__r.Term__c,
       Course_Offering__r.Section__c,
       Course_Offering__r.Instructor__c,
       Course_Offering__r.Course__c,
       Course_Offering__r.Course__r.Name,
       Course_Offering__r.Course__r.Course_Code__c,
       Student__c,
       Student__r.Email__c
FROM Enrollment__c
WHERE Student__r.Email__c = :userEmail
ORDER BY Enrollment_Date__c DESC
LIMIT 100
```

### **Security:**
- with sharing keyword (respects sharing rules)
- User email validation
- Exception handling
- Debug logging for errors

---

## 🚀 Deployment Process

### **Deployment Command:**
```bash
sf project deploy start --source-dir force-app
```

### **Deployed Components:**
- LightningComponentBundle: enrollmentViewer
- ApexClass: EnrollmentController
- Metadata successfully pushed to org

### **Lightning Page Setup:**
1. Created new App Page "My Enrollments"
2. Added enrollmentViewer component to page
3. Activated page for Sales app
4. Assigned to System Administrator profile

### **Verification:**
- Component visible in Lightning App Builder
- Component renders on Lightning page
- Data loads from Salesforce
- Search functionality working
- Refresh button functional

---

## 🎓 Technical Skills Learned

### **Development Environment:**
- ✅ VS Code proficiency
- ✅ Salesforce CLI usage
- ✅ Command line navigation
- ✅ Project structure management
- ✅ Org authorization workflow

### **Lightning Web Components:**
- ✅ Component structure (HTML, JS, XML)
- ✅ LightningElement base class
- ✅ Decorators (@track, @wire, @api)
- ✅ Template syntax (if:true, for:each)
- ✅ Event handling (onchange, onclick)
- ✅ Computed properties (getters)
- ✅ Lightning Design System (SLDS)
- ✅ Standard Lightning components

### **JavaScript:**
- ✅ ES6+ syntax
- ✅ Arrow functions
- ✅ Array methods (filter, map)
- ✅ Template literals
- ✅ Destructuring
- ✅ Optional chaining (?.)

### **Apex Integration:**
- ✅ @AuraEnabled methods
- ✅ Wire service integration
- ✅ refreshApex for cache refresh
- ✅ Error handling with AuraHandledException

### **SOQL:**
- ✅ Relationship queries (parent-to-child)
- ✅ Dot notation for related fields
- ✅ WHERE clause filtering
- ✅ ORDER BY and LIMIT

### **Lightning Platform:**
- ✅ Lightning App Builder
- ✅ App Page creation
- ✅ Component activation
- ✅ Profile assignment

---

## 📊 Results & Metrics

**Code Quality:**
- LWC: 95 lines (HTML + JS + XML)
- Apex: 40 lines
- Total: 135 lines of production code
- All deployed successfully
- Zero compilation errors

**Component Features:**
- 5 interactive elements (search, refresh, cards, icons, badges)
- 3 different states (loading, data, empty)
- 8+ data fields displayed
- Real-time search filtering
- Complete error handling

**Development Time:**
- Environment setup: 90 min
- Component development: 120 min
- Apex controller: 30 min
- Deployment & testing: 60 min
- **Total: 7 hours**

**Business Value:**
- Self-service enrollment viewing
- Mobile-responsive interface
- Real-time data display
- Professional user experience
- Scalable component architecture

---

## 💡 Key Takeaways

1. **Modern Development:** VS Code + CLI is the professional standard
2. **Component Architecture:** Separation of concerns (HTML, JS, metadata)
3. **Reactive Programming:** Decorators make data flow simple
4. **SLDS is Essential:** Lightning Design System provides professional styling
5. **Wire Service:** Automatic data binding reduces boilerplate code
6. **Error Handling:** Always plan for loading, success, and error states
7. **Testing with Real Data:** Component only works when data setup is correct
8. **Deployment Process:** Simple CLI commands deploy entire projects

---

## 🆚 LWC vs Other Approaches

**LWC vs Visualforce:**
- ✅ Modern JavaScript (not proprietary)
- ✅ Better performance (client-side rendering)
- ✅ Mobile-responsive by default
- ✅ Reusable components

**LWC vs Aura:**
- ✅ Faster rendering (native web components)
- ✅ Smaller bundle size
- ✅ Modern syntax (ES6+)
- ✅ Better debugging

**LWC vs Flows:**
- ✅ Complete UI control
- ✅ Complex interactions possible
- ✅ Reusable across pages
- ❌ Requires coding knowledge

---

## 🐛 Challenges & Solutions

### **Challenge 1: Authorization Command Not Found**
- **Problem:** SFDX commands not appearing in VS Code
- **Solution:** Used CLI directly with `sf org login web`
- **Learning:** CLI is more reliable than VS Code commands sometimes

### **Challenge 2: Authentication Timeout**
- **Problem:** Browser login took too long
- **Solution:** Completed login quickly in browser
- **Learning:** OAuth tokens have time limits

### **Challenge 3: Metadata XML Error**
- **Problem:** Invalid property in metadata file
- **Solution:** Removed unsupported `<property>` tag
- **Learning:** LWC metadata has specific schema

### **Challenge 4: No Data Displaying**
- **Problem:** Component showed "No enrollments"
- **Solution:** Created Student record with matching user email
- **Learning:** Apex query filters by current user's email

---

## 🚀 Week 6 Achievements

**Environment:**
- ✅ Professional development setup complete
- ✅ VS Code configured with extensions
- ✅ Salesforce CLI operational
- ✅ Org authorized and connected

**Component:**
- ✅ First LWC created and working
- ✅ Interactive search functionality
- ✅ Refresh capability
- ✅ Professional UI design

**Integration:**
- ✅ Apex backend integrated
- ✅ SOQL relationship queries
- ✅ Lightning page deployment
- ✅ Component activation

**Skills:**
- ✅ JavaScript development
- ✅ HTML templating
- ✅ Modern web development workflow
- ✅ Professional deployment process

---

## 📸 Screenshots

**Location:** `documentation/screenshots/week-06/`

1. `week-06-vscode-setup.png` - Development environment
2. `week-06-lwc-files.png` - Component file structure
3. `week-06-apex-controller.png` - Apex controller code
4. `week-06-deploy-success.png` - Successful deployment
5. `week-06-app-builder.png` - Lightning App Builder
6. `week-06-component-with-data.png` - Working component
7. `week-06-component-search.png` - Search functionality
8. `week-06-component-details.png` - Enrollment card details

---

## 🏆 Achievement Unlocked

**Status:** Full-Stack Salesforce Developer ✅

**Capabilities:**
- Setup professional development environment
- Build Lightning Web Components
- Write modern JavaScript
- Create Apex backend services
- Deploy to Salesforce orgs
- Design responsive UIs
- Integrate frontend with backend

**Portfolio Value:**
- Production LWC component
- Modern JavaScript skills
- Professional development workflow
- End-to-end solution delivery
- Visual, working demo

---

## 🎯 Next Steps

**Potential Enhancements:**
- Add pagination for large enrollment lists
- Show more course details (schedule, location)
- Add status filters (Enrolled, Completed, etc.)
- Create enrollment action buttons
- Add course materials access
- Build advisor view component

**Week 7 Preview:**
- Advanced LWC features
- Component communication
- Custom events
- Record editing
- Dynamic styling

---

**Week 6 Complete!** 🎉

*Next: Week 7 - Advanced Lightning Web Components*
```

