import { LightningElement, api, track, wire } from 'lwc';
import getStudentEnrollments from '@salesforce/apex/EnrollmentSummaryController.getStudentEnrollments';
import { refreshApex } from '@salesforce/apex';

export default class EnrollmentSummary extends LightningElement {
    
    // @api allows parent to trigger refresh
    @api
    refresh() {
        this.isLoading = true;
        return refreshApex(this.wiredEnrollmentsResult);
    }

    @track enrollments = [];
    @track isLoading = true;
    @track error;

    wiredEnrollmentsResult;

    // Wire service to get enrollments
    @wire(getStudentEnrollments)
    wiredEnrollments(result) {
        this.wiredEnrollmentsResult = result;
        this.isLoading = true;

        if (result.data) {
            this.enrollments = result.data;
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            this.error = result.error;
            this.enrollments = [];
            this.isLoading = false;
            console.error('Error loading enrollments:', result.error);
        }
    }

    // Total number enrolled
    get totalEnrolled() {
        return this.enrollments ? this.enrollments.length : 0;
    }

    // Total credits across all enrollments
    get totalCredits() {
        if (!this.enrollments || this.enrollments.length === 0) {
            return 0;
        }
        return this.enrollments.reduce((total, enrollment) => {
            const credits = enrollment.Course_Offering__r?.Course__r?.Credits__c || 0;
            return total + credits;
        }, 0);
    }

    // Count active enrollments
    get activeEnrollments() {
        if (!this.enrollments) return 0;
        return this.enrollments.filter(e => e.Status__c === 'Enrolled').length;
    }

    // Count completed enrollments
    get completedEnrollments() {
        if (!this.enrollments) return 0;
        return this.enrollments.filter(e => e.Status__c === 'Completed').length;
    }

    // Check if has enrollments
    get hasEnrollments() {
        return !this.isLoading && this.enrollments && this.enrollments.length > 0;
    }

    // Check if no enrollments
    get hasNoEnrollments() {
        return !this.isLoading && (!this.enrollments || this.enrollments.length === 0);
    }
}