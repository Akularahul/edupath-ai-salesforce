import { LightningElement, track, wire } from 'lwc';
import getEnrollments from '@salesforce/apex/EnrollmentController.getEnrollments';
import { refreshApex } from '@salesforce/apex';

export default class EnrollmentViewer extends LightningElement {
    // Reactive properties
    @track enrollments = [];
    @track filteredEnrollments = [];
    @track searchKey = '';
    @track isLoading = true;
    @track error;
    
    // Store wire result for refresh
    wiredEnrollmentsResult;

    // Wire service to get enrollments
    @wire(getEnrollments)
    wiredEnrollments(result) {
        this.wiredEnrollmentsResult = result;
        this.isLoading = true;
        
        if (result.data) {
            // Data loaded successfully
            this.enrollments = result.data;
            this.filteredEnrollments = result.data;
            this.error = undefined;
            this.isLoading = false;
        } else if (result.error) {
            // Error occurred
            this.error = result.error;
            this.enrollments = [];
            this.filteredEnrollments = [];
            this.isLoading = false;
            console.error('Error loading enrollments:', result.error);
        }
    }

    // Computed property: Check if we have enrollments to display
    get hasEnrollments() {
        return !this.isLoading && this.filteredEnrollments && this.filteredEnrollments.length > 0;
    }

    // Computed property: Show "no enrollments" message
    get showNoEnrollments() {
        return !this.isLoading && (!this.filteredEnrollments || this.filteredEnrollments.length === 0);
    }

    // Handle search input change
    handleSearchChange(event) {
        this.searchKey = event.target.value.toLowerCase();
        this.filterEnrollments();
    }

    // Filter enrollments based on search
    filterEnrollments() {
        if (this.searchKey) {
            // Filter by course name
            this.filteredEnrollments = this.enrollments.filter(enrollment => {
                const courseName = enrollment.Course_Offering__r?.Course__r?.Name?.toLowerCase() || '';
                return courseName.includes(this.searchKey);
            });
        } else {
            // No search, show all
            this.filteredEnrollments = this.enrollments;
        }
    }

    // Handle refresh button click
    handleRefresh() {
        this.isLoading = true;
        // Refresh the wired data
        return refreshApex(this.wiredEnrollmentsResult);
    }
}