import { LightningElement, track } from 'lwc';

export default class ParentSearchContainer extends LightningElement {
    @track selectedAccountId;

    handleAccountSelect(event) {
        this.selectedAccountId = event.detail.accountId;
    }
}