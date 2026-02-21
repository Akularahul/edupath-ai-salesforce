import { LightningElement, api, track } from 'lwc';

export default class CourseCard extends LightningElement {
    
    // @api means this data comes FROM the parent component
    @api course;
    @api enrolledCourseIds = [];

    // Track loading state
    @track isLoading = false;

    // Check if student is already enrolled in this course
    get isEnrolled() {
        if (!this.enrolledCourseIds || !this.course) {
            return false;
        }
        return this.enrolledCourseIds.includes(this.course.Id);
    }

    // Dynamic CSS class based on enrollment status
    get cardClass() {
        let baseClass = 'slds-box slds-m-bottom_medium course-card';
        if (this.isEnrolled) {
            baseClass += ' enrolled-card';
        }
        if (this.course && this.course.isFull) {
            baseClass += ' full-card';
        }
        return baseClass;
    }

    // Handle enroll button click
    // This fires a CUSTOM EVENT to the parent component
    handleEnrollClick(event) {
        const courseId = event.target.dataset.courseId;
        
        // Create custom event with course data
        // Parent component will LISTEN for this event
        const enrollEvent = new CustomEvent('enroll', {
            detail: {
                courseId: courseId,
                courseName: this.course.Course__r.Name
            }
        });
        
        // Fire the event UP to parent
        this.dispatchEvent(enrollEvent);
    }
}