import { LightningElement, track, wire } from 'lwc';
import AccountList from '@salesforce/apex/accountDemo.AccountList';
export default class WireProperty extends LightningElement {
    @track data;
    @wire(AccountList) accounts
}