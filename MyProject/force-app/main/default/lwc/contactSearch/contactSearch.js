import { LightningElement, api, track } from 'lwc';
import searchContacts from '@salesforce/apex/AccountContactSearchController.searchContacts';
import { NavigationMixin } from 'lightning/navigation';

export default class ContactSearch extends NavigationMixin(LightningElement) {
    @api accountId;
    @track contacts = [];
    @track showList = false;
    searchKey = '';

    handleSearchInput(event) {
        this.searchKey = event.target.value;
        if (this.searchKey.length >= 3) {
            searchContacts({ accountId: this.accountId, searchKey: this.searchKey })
                .then(result => {
                    this.contacts = result.slice(0, 5);
                    this.showList = true;
                })
                .catch(error => console.error(error));
        } else {
            this.showList = false;
        }
    }

    handleContactSelect(event) {
        const contactId = event.currentTarget.dataset.id;
        this.showList = false;

        // Navigate to contact record
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: contactId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }
}