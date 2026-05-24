import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {createRecord} from 'lightning/uiRecordApi';
import {NavigationMixin} from 'lightning/navigation';


export default class CreateRecord_LWC extends NavigationMixin (LightningElement) {
    name='';
    phone='';
    handleChange(event){
        if(event.target.label=='Name')
        {
            this.name=event.target.value;
        }
        if(event.target.label=='Phone')
        {
            this.phone=event.target.value;
        }
    }
    CreateAccount()
    {
        const fields={};
        fields[NAME_FIELD.fieldApiName]=this.name;
        fields[PHONE_FIELD.fieldApiName]=this.phone;
        const recordInput={apiName:ACCOUNT_OBJECT.objectApiName,fields};

        createRecord(recordInput)
            .then(Account=>{
                this.accountId=account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title:'Success',
                        message:'Account Created',
                        variant:'Success',
                    }),
                );
                this[NavigationMixin.Navigate]({
                    type:'Standard__recordPage',
                    attributes:{
                        recordId:Account.id,
                        objectApiName:'Account',
                        actionName:'view'
                    },
                });
            })
            .catch(error=>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title:'Error Creating Record',
                        Message:'error.body.message',
                        variant:'error',
                    }),
                );
            });
        
    }
}