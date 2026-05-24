import { LightningElement,track } from 'lwc';

import AccountList from '@salesforce/apex/accountDemo.AccountListRecords';

export default class DataDisplayWithImperative extends LightningElement {
    @track AccountRecords;
    @track errors;
    @track columns=[{label: 'Name',fieldName:'Name',type:'text'},
                    {label:'Industry',fieldName:'Industry',type:'text'},
                    {label:'Type',fieldName:'Type',type:'phone'} ];
    connectedCallback(){
    AccountList()
        .then(result=>{
            this.AccountRecords=result;
        })
        .catch(error=>{
            this.errors=error;
        })
    }
    
}