import { LightningElement, track } from 'lwc';

export default class secondCode extends LightningElement {
    @track contacts = [
        { id: 1, name: 'John Doe' },
        { id: 2, name: 'Jane Smith' }
    ];
    newContact = '';

    // Handle input change
    handleInputChange(event) {
        this.newContact = event.target.value;
    }

    // Add a new contact
    addContact() {
        if (this.newContact.trim() !== '') {
            this.contacts = [
                ...this.contacts, 
                { id: this.contacts.length + 1, name: this.newContact }
            ];
            this.newContact = ''; // Clear input field
        }
    }

    // Remove a contact
    removeContact(event) {
        const contactId = parseInt(event.target.dataset.id, 10);
        this.contacts = this.contacts.filter(contact => contact.id !== contactId);
    }
}