import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getCourseOfferings from '@salesforce/apex/CourseEnrollmentController.getCourseOfferings';
import createEnrollment from '@salesforce/apex/CourseEnrollmentController.createEnrollment';
import getStudentEnrollments from '@salesforce/apex/EnrollmentSummaryController.getStudentEnrollments';

export default class EnrollmentDashboard extends LightningElement {

    // Reactive properties
    @track courseOfferings = [];
    @track filteredCourses = [];
    @track enrollments = [];
    @track enrolledCourseIds = [];
    @track searchKey = '';
    @track selectedTerm = '';
    @track isLoadingCourses = true;
    @track currentUserName = 'Student';

    // Store wire results for refresh
    wiredCoursesResult;
    wiredEnrollmentsResult;

    // ─────────────────────────────────────
    // WIRE: Load Course Offerings
    // ─────────────────────────────────────
    @wire(getCourseOfferings)
    wiredCourses(result) {
        this.wiredCoursesResult = result;
        this.isLoadingCourses = true;

        if (result.data) {
            // Process courses and calculate seat availability
            this.courseOfferings = result.data.map(course => {
                const current = course.Current_Enrollment__c || 0;
                const max = course.Max_Enrollment__c || 0;
                return {
                    ...course,
                    seatsAvailable: max - current,
                    isFull: current >= max
                };
            });

            this.filteredCourses = this.courseOfferings;
            this.isLoadingCourses = false;
        } else if (result.error) {
            this.isLoadingCourses = false;
            console.error('Error loading courses:', result.error);
        }
    }

    // ─────────────────────────────────────
    // WIRE: Load Student Enrollments
    // ─────────────────────────────────────
    @wire(getStudentEnrollments)
    wiredEnrollments(result) {
        this.wiredEnrollmentsResult = result;

        if (result.data) {
            this.enrollments = result.data;

            // Build list of enrolled course IDs
            // This gets passed to each CourseCard child
            this.enrolledCourseIds = result.data.map(
                enrollment => enrollment.Course_Offering__c
            );
        } else if (result.error) {
            console.error('Error loading enrollments:', result.error);
        }
    }

    // ─────────────────────────────────────
    // COMPUTED PROPERTIES
    // ─────────────────────────────────────

    get hasCourses() {
        return !this.isLoadingCourses &&
               this.filteredCourses &&
               this.filteredCourses.length > 0;
    }

    get showNoCourses() {
        return !this.isLoadingCourses &&
               (!this.filteredCourses || this.filteredCourses.length === 0);
    }

    // Build term filter options from loaded courses
    get termOptions() {
        const terms = new Set();
        this.courseOfferings.forEach(course => {
            if (course.Term__c) {
                terms.add(course.Term__c);
            }
        });

        const options = [{ label: 'All Terms', value: '' }];
        terms.forEach(term => {
            options.push({ label: term, value: term });
        });

        return options;
    }

    // ─────────────────────────────────────
    // EVENT HANDLERS - FILTERS
    // ─────────────────────────────────────

    handleSearchChange(event) {
        this.searchKey = event.target.value.toLowerCase();
        this.applyFilters();
    }

    handleTermChange(event) {
        this.selectedTerm = event.detail.value;
        this.applyFilters();
    }

    applyFilters() {
        let filtered = this.courseOfferings;

        // Apply term filter
        if (this.selectedTerm) {
            filtered = filtered.filter(course =>
                course.Term__c === this.selectedTerm
            );
        }

        // Apply search filter
        if (this.searchKey) {
            filtered = filtered.filter(course => {
                const name = course.Course__r?.Name?.toLowerCase() || '';
                const code = course.Course__r?.Course_Code__c?.toLowerCase() || '';
                return name.includes(this.searchKey) ||
                       code.includes(this.searchKey);
            });
        }

        this.filteredCourses = filtered;
    }

    // ─────────────────────────────────────
    // EVENT HANDLER - CHILD FIRES "enroll"
    // ─────────────────────────────────────
    // This is CALLED when CourseCard child
    // fires the custom "enroll" event
    // ─────────────────────────────────────
    handleCourseEnroll(event) {
        // Get data sent from child component
        const courseId = event.detail.courseId;
        const courseName = event.detail.courseName;

        this.isLoadingCourses = true;

        // Call Apex to create enrollment
        createEnrollment({ courseOfferingId: courseId })
            .then(result => {
                // Show success toast
                this.showToast('Enrolled Successfully!', result, 'success');

                // Refresh BOTH wire services
                return Promise.all([
                    refreshApex(this.wiredCoursesResult),
                    refreshApex(this.wiredEnrollmentsResult)
                ]);
            })
            .then(() => {
                // After refresh, tell summary component to refresh too
                // This is PARENT CALLING CHILD METHOD
                const summaryComponent = this.template.querySelector('c-enrollment-summary');
                if (summaryComponent) {
                    summaryComponent.refresh();
                }
            })
            .catch(error => {
                const msg = error.body?.message || 'Error enrolling in course.';
                this.showToast('Error', msg, 'error');
            })
            .finally(() => {
                this.isLoadingCourses = false;
            });
    }

    // ─────────────────────────────────────
    // REFRESH ALL
    // ─────────────────────────────────────
    handleRefreshAll() {
        this.isLoadingCourses = true;

        Promise.all([
            refreshApex(this.wiredCoursesResult),
            refreshApex(this.wiredEnrollmentsResult)
        ]).then(() => {
            // Refresh summary child component
            const summaryComponent = this.template.querySelector('c-enrollment-summary');
            if (summaryComponent) {
                summaryComponent.refresh();
            }
            this.showToast('Refreshed!', 'All data updated successfully.', 'success');
        }).finally(() => {
            this.isLoadingCourses = false;
        });
    }

    // ─────────────────────────────────────
    // TOAST HELPER
    // ─────────────────────────────────────
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        }));
    }
}