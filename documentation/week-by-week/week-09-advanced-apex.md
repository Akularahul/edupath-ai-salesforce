# Week 9: Advanced Apex & SOQL Optimization

**Duration:** February 15, 2026  
**Status:** ✅ Completed  
**Time Invested:** 8 hours

---

## 🎯 Week 9 Overview

**Theme:** Advanced Apex Programming & SOQL Optimization  
**Goal:** Write efficient, bulkified code for enterprise-scale operations

**What I Built:**
- ✅ BulkEnrollmentProcessor (150 lines)
- ✅ StudentGradeCalculatorBatch (120 lines)
- ✅ EnrollmentReportGenerator (110 lines)
- ✅ AdvancedSOQLQueries (180 lines)
- ✅ Complete test coverage (360 lines)

**Total: 920 lines of advanced Apex code**

---

## 💻 Components Built

### **1. BulkEnrollmentProcessor**

**Purpose:** Handle mass enrollment operations efficiently

**Key Methods:**
- `enrollFromPrerequisite()` - Enroll 200+ students from prerequisite course
- `bulkEnroll()` - Enroll multiple students in multiple courses
- `getEnrollmentStatsByTerm()` - Aggregate SOQL statistics

**Bulkification Techniques:**
- No SOQL in loops
- Collection usage (Set, Map, List)
- Single DML statements
- Duplicate prevention
- Capacity validation

**Code Coverage:** 81%

---

### **2. StudentGradeCalculatorBatch**

**Purpose:** Calculate GPA for thousands of students asynchronously

**Implementation:**
- Implements `Database.Batchable<sObject>`
- Implements `Database.Stateful` for tracking
- Processes 200 students per batch
- Automatic grade point calculation
- Bulk GPA updates

**Three Required Methods:**
- `start()` - Returns QueryLocator with students to process
- `execute()` - Processes one batch (200 records)
- `finish()` - Logs completion statistics

**Code Coverage:** 97%

---

### **3. EnrollmentReportGenerator**

**Purpose:** Generate enrollment reports asynchronously

**Implementation:**
- Implements `Queueable` interface
- CSV and Text format options
- Background processing (non-blocking)
- Can chain multiple jobs
- Processes up to 1000 enrollments

**Features:**
- CSV export with headers
- Text-based report formatting
- Static helper methods for easy invocation
- Customizable report formats

**Code Coverage:** 96%

---

### **4. AdvancedSOQLQueries**

**Purpose:** Demonstrate advanced SOQL patterns

**Query Types Demonstrated:**
- **Aggregate Queries** - COUNT, AVG, SUM, GROUP BY, HAVING
- **Subqueries** - Parent-to-child and child-to-parent
- **Dynamic SOQL** - Build queries programmatically
- **Multiple Aggregates** - COUNT, COUNT_DISTINCT, AVG in one query

**Methods:**
- `getEnrollmentCountsByCourse()` - Aggregation with GROUP BY
- `getAverageGPAByProgram()` - AVG with GROUP BY
- `getStudentsWithEnrollments()` - Subquery (parent to child)
- `getCoursesWithOfferings()` - Subquery (parent to child)
- `searchEnrollments()` - Dynamic SOQL with filters
- `getPopularCourses()` - HAVING clause
- `getTermStatistics()` - Multiple aggregates

**Code Coverage:** 96%

---

## 🎓 Technical Skills Learned

### **Bulkification Pattern:**

**BAD - SOQL in Loop:**
```apex
for(Id studentId : studentIds) {
    Student__c s = [SELECT Id FROM Student__c WHERE Id = :studentId];
    // Process student
}
```

**GOOD - Query Once, Process Many:**
```apex
Map<Id, Student__c> studentMap = new Map<Id, Student__c>(
    [SELECT Id FROM Student__c WHERE Id IN :studentIds]
);
for(Id studentId : studentIds) {
    Student__c s = studentMap.get(studentId);
    // Process student
}
```

---

### **Collection Types:**

**Set<Id> - Deduplication & Fast Lookup:**
```apex
Set<Id> studentIds = new Set<Id>();
studentIds.add(student1.Id);
studentIds.add(student1.Id); // Duplicate automatically ignored
if(studentIds.contains(someId)) // O(1) lookup
```

**Map<Id, Object> - Key-Value Storage:**
```apex
Map<Id, List<Enrollment__c>> studentEnrollmentMap = new Map<Id, List<Enrollment__c>>();
```

**List<Object> - Ordered Collection:**
```apex
List<Student__c> studentsToUpdate = new List<Student__c>();
```

---

### **Batch Apex Pattern:**
```apex
global class MyBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Integer recordsProcessed = 0; // Persists across batches
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Student__c');
    }
    
    global void execute(Database.BatchableContext bc, List<Student__c> scope) {
        // Process up to 200 records
        recordsProcessed += scope.size();
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Processed: ' + recordsProcessed);
    }
}

// Execute batch
MyBatch batch = new MyBatch();
Id batchId = Database.executeBatch(batch, 200);
```

---

### **Queueable Apex Pattern:**
```apex
public class MyQueueable implements Queueable {
    
    public void execute(QueueableContext context) {
        // Async processing
        
        // Can chain another job
        System.enqueueJob(new AnotherQueueable());
    }
}

// Enqueue job
Id jobId = System.enqueueJob(new MyQueueable());
```

---

### **Aggregate SOQL:**

**COUNT:**
```apex
Integer count = [SELECT COUNT() FROM Enrollment__c WHERE Status__c = 'Enrolled'];
```

**GROUP BY:**
```apex
AggregateResult[] results = [
    SELECT Course__r.Name, COUNT(Id) total
    FROM Enrollment__c
    GROUP BY Course__r.Name
];
```

**HAVING:**
```apex
AggregateResult[] results = [
    SELECT Course__r.Name, COUNT(Id) total
    FROM Enrollment__c
    GROUP BY Course__r.Name
    HAVING COUNT(Id) > 10
];
```

**Multiple Aggregates:**
```apex
AggregateResult[] results = [
    SELECT 
        Course__r.Name,
        COUNT(Id) total,
        AVG(Grade__c) avgGrade,
        COUNT_DISTINCT(Student__c) uniqueStudents
    FROM Enrollment__c
    GROUP BY Course__r.Name
];
```

---

### **Dynamic SOQL:**
```apex
String query = 'SELECT Id FROM Student__c WHERE Status__c = \'Active\'';

if(programId != null) {
    query += ' AND Academic_Program__c = :programId';
}

query += ' LIMIT 100';

List<Student__c> students = Database.query(query);
```

---

## 📊 Results & Metrics

**Test Results:**
- Tests Ran: 20
- Pass Rate: 100%
- Code Coverage:
  - BulkEnrollmentProcessor: 81%
  - StudentGradeCalculatorBatch: 97%
  - EnrollmentReportGenerator: 96%
  - AdvancedSOQLQueries: 96%

**Code Statistics:**
- 4 production Apex classes
- 4 test classes
- 920 total lines of code
- 16 files deployed

**Performance:**
- Can process 200+ enrollments in single transaction
- Batch processes unlimited students (200 at a time)
- Queueable handles 1000 enrollments asynchronously

---

## 💡 Key Takeaways

1. **Bulkification is Essential** - Always design for 200 records
2. **Collections Optimize Performance** - Set for dedup, Map for lookup
3. **One SOQL per Transaction** - Never query in loops
4. **Batch for Large Datasets** - Process millions of records
5. **Queueable for Async Work** - Don't block users
6. **Aggregate SOQL Saves Limits** - One query vs. hundreds
7. **Dynamic SOQL for Flexibility** - Build queries based on input

---

## 🆚 Synchronous vs Asynchronous

| Aspect | Synchronous | Asynchronous (Batch/Queueable) |
|--------|-------------|--------------------------------|
| **Limit** | 200 SOQL queries | 200 SOQL queries per batch |
| **Records** | Up to 50,000 | Unlimited (chunked) |
| **Timeout** | 10 seconds | 10 minutes per chunk |
| **User Wait** | Blocks UI | Runs in background |
| **Use Case** | Real-time updates | Bulk processing |

---

## 🐛 Governor Limits Handled

**SOQL Limits:**
- ✅ Max 200 SOQL queries per transaction
- ✅ Bulkified to query once, not in loops

**DML Limits:**
- ✅ Max 150 DML statements per transaction
- ✅ Single DML for multiple records

**Heap Size:**
- ✅ Max 6 MB synchronous, 12 MB asynchronous
- ✅ Process in batches to stay under limit

**CPU Time:**
- ✅ Max 10 seconds synchronous
- ✅ Batch processes avoid timeout

---

## 🚀 Week 9 Achievements

- ✅ Enterprise-level bulkification
- ✅ Batch Apex for large datasets
- ✅ Queueable for async processing
- ✅ Advanced SOQL (aggregates, subqueries)
- ✅ 96%+ code coverage
- ✅ Dynamic SOQL
- ✅ Collection mastery (Set, Map, List)
- ✅ Governor limit optimization

---

## 📸 Screenshots

**Location:** `documentation/screenshots/week-09/`

1. `week-09-test-results.png` - All tests passing
2. `week-09-code-coverage.png` - Coverage report
3. `week-09-bulk-processor.png` - BulkEnrollmentProcessor code
4. `week-09-batch-apex.png` - StudentGradeCalculatorBatch code
5. `week-09-queueable.png` - EnrollmentReportGenerator code
6. `week-09-soql.png` - AdvancedSOQLQueries code

---

**Week 9 Complete!** 🎉

*Next: Week 10 - Integration & REST APIs*