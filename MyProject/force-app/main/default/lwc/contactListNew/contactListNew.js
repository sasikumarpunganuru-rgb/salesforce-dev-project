import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactListNew extends LightningElement {
    contacts = [];
    error;
    loading = true;
    timerId;

    constructor() {
        super();
        console.log('Constructor: Component instance created');
    }

    connectedCallback() {
        console.log('connectedCallback: Component added to DOM');
        this.loadContacts();

        // Example interval (e.g., refreshing every 30 sec)
        this.timerId = setInterval(() => {
            console.log('Refreshing contacts...');
            this.loadContacts();
        }, 30000);
    }

    loadContacts() {
        this.loading = true;
        getContacts()
            .then(result => {
                this.contacts = result;
                this.error = undefined;
                console.log('Contacts loaded:', result);
            })
            .catch(error => {
                this.error = error;
                this.contacts = [];
                console.error('Error loading contacts:', error);
            })
            .finally(() => {
                this.loading = false;
            });
    }

    renderedCallback() {
        console.log('renderedCallback: DOM rendered or re-rendered');
        const searchBox = this.template.querySelector('.search-box');
        if (searchBox) {
            searchBox.focus();
        }
    }

    disconnectedCallback() {
        console.log('disconnectedCallback: Component removed from DOM');
        clearInterval(this.timerId); // Clean up interval
    }

    errorCallback(error, stack) {
        console.error('errorCallback: Error in child component', error, stack);
    }
}