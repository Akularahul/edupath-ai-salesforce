import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getCourseOfferings from '@salesforce/apex/CourseEnrollmentController.getCourseOfferings';
import createEnrollment from '@salesforce/apex/CourseEnrollmentController.createEnrollment';

export default class CourseBrowser extends LightningElement {
    @track courseOfferings = [];
    @track filteredCourses = [];
    @track searchKey = '';
    @track isLoading = true;
    @track error;
    
    wiredCoursesResult;

    @wire(getCourseOfferings)
    wiredCourses(result) {
        this.wiredCoursesResult = result;
        this.isLoading = true;
        
        if (result.data) {
            this.courseOfferings = result.data.map(course => {
                const currentEnrollment = course.Current_Enrollment__c || 0;
                const maxEnrollment = course.Max_Enrollment__c || 0;
                const seatsAvailable = maxEnrollment - currentEnrollment;
                
                return {
                    ...course,
                    seatsAvailable: seatsAvailable,
                    isFull: currentEnrollment >= maxEnrollment
                };
            });
            
            this.filteredCourses = this.courseOfferings;
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            this.error = result.error;
            this.courseOfferings = [];
            this.filteredCourses = [];
            this.isLoading = false;
            console.error('Error loading courses:', result.error);
        }
    }

    get hasCourses() {
        return !this.isLoading && this.filteredCourses && this.filteredCourses.length > 0;
    }

    get showNoCourses() {
        return !this.isLoading && (!this.filteredCourses || this.filteredCourses.length === 0);
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value.toLowerCase();
        this.filterCourses();
    }

    filterCourses() {
        if (this.searchKey) {
            this.filteredCourses = this.courseOfferings.filter(course => {
                const courseName = course.Course__r?.Name?.toLowerCase() || '';
                const courseCode = course.Course__r?.Course_Code__c?.toLowerCase() || '';
                return courseName.includes(this.searchKey) || courseCode.includes(this.searchKey);
            });
        } else {
            this.filteredCourses = this.courseOfferings;
        }
    }

    handleRefresh() {
        this.isLoading = true;
        return refreshApex(this.wiredCoursesResult);
    }

    handleEnroll(event) {
        const courseOfferingId = event.target.dataset.courseId;
        this.isLoading = true;

        createEnrollment({ courseOfferingId: courseOfferingId })
            .then(result => {
                this.showToast('Success!', result, 'success');
                return refreshApex(this.wiredCoursesResult);
            })
            .catch(error => {
                const errorMessage = error.body?.message || 'An error occurred while enrolling.';
                this.showToast('Error', errorMessage, 'error');
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}