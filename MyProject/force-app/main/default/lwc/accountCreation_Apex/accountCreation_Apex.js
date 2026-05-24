import { LightningElement,track} from 'lwc';
import createAccount from '@salesforce/apex/accountCreationController.createAccount';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
//import { ShowToastEvent } from 'lightning/platfromShowToastEvent';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountCreation_Apex extends LightningElement {
    @track accountId;
    @track error;
    @track accountRecord={
        Name:ACCOUNT_NAME,
        Phone:ACCOUNT_PHONE,
        Type:ACCOUNT_TYPE
    }
    handleChangeName(event){
        this.accountRecord.Name=event.target.value;

    }
    handleChangeType(event){
        this.accountRecord.Type=event.target.value;
    }
    handleChangePhone(event){
        this.accountRecord.Phone=event.target.value;
    }
    handleSaveChanges(){
        createAccount({accountRecObj:this.accountRecord})
        .then(result=>{
            this.accountRecord={};
            this.accountId=result.Id;
            const evt= new ShowToastEvent({
                title:'Success!',
                message:'Account record is created',
                variant:'success'
            });
            this.dispatchEvent(evt)
        })
        .catch(error=>{
            this.error=error.message;
        })
    }
}