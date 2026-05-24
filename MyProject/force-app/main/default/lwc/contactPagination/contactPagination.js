import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactPaginationController.getContacts';
import getContactCount from '@salesforce/apex/ContactPaginationController.getContactCount';

export default class ContactPagination extends LightningElement {
    @track contacts;
    @track error;
    @track searchKey = '';
    @track pageNumber = 1;
    @track pageSize = 10;
    @track totalContacts = 0;

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    connectedCallback() {
        this.fetchContacts();
    }

    handleSearch(event) {
        this.searchKey = event.target.value;
        this.pageNumber = 1;
        this.fetchContacts();
    }

    handleNext() {
        this.pageNumber++;
        this.fetchContacts();
    }

    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.fetchContacts();
        }
    }

    get isPrevDisabled() {
        return this.pageNumber === 1;
    }

    get isNextDisabled() {
        return (this.pageNumber * this.pageSize >= this.totalContacts);
    }

    fetchContacts() {
        getContactCount({ searchKey: this.searchKey })
            .then(count => {
                this.totalContacts = count;
                return getContacts({
                    searchKey: this.searchKey,
                    pageSize: this.pageSize,
                    pageNumber: this.pageNumber
                });
            })
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.contacts = undefined;
            });
    }
}