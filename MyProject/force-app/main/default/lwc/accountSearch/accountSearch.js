import { LightningElement, track } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountContactSearchController.searchAccounts';

export default class AccountSearch extends LightningElement {
    @track accounts = [];
    @track showList = false;
    searchKey = '';

    handleSearchInput(event) {
        this.searchKey = event.target.value;
        if (this.searchKey.length >= 3) {
            searchAccounts({ searchKey: this.searchKey })
                .then(result => {
                    this.accounts = result.slice(0, 5);
                    this.showList = true;
                })
                .catch(error => console.error(error));
        } else {
            this.showList = false;
        }
    }

    handleAccountSelect(event) {
        const accountId = event.currentTarget.dataset.id;
        const accountName = event.currentTarget.dataset.name;
        this.showList = false;
        this.searchKey = accountName;

        // 🔹 Fire event to parent
        const selectedEvent = new CustomEvent('accountselect', {
            detail: { accountId: accountId }
        });
        this.dispatchEvent(selectedEvent);
    }
}