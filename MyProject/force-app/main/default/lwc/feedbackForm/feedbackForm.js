import { LightningElement, track } from 'lwc';
import createFeedback from '@salesforce/apex/FeedbackController.createFeedback';

export default class FeedbackForm extends LightningElement {
    @track name = '';
    @track email = '';
    @track feedback = '';
    @track successMessage = '';

    // Lifecycle hook
    connectedCallback() {
        console.log('Component inserted into the DOM');
    }

    handleChange(event) {
        const field = event.target.dataset.field;
        if (field === 'name') this.name = event.target.value;
        if (field === 'email') this.email = event.target.value;
        if (field === 'feedback') this.feedback = event.target.value;
    }

    handleSubmit() {
        createFeedback({ name: this.name, email: this.email, feedbackText: this.feedback })
            .then(() => {
                this.successMessage = 'Thank you for your feedback!';
                this.name = '';
                this.email = '';
                this.feedback = '';
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    disconnectedCallback() {
        console.log('Component removed from the DOM');
    }

    renderedCallback() {
        console.log('Component rendered');
    }
}