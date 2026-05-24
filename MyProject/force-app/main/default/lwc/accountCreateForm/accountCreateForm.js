import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountCreateForm extends NavigationMixin(LightningElement) {
    handleSuccess(event) {
        const recordId = event.detail.id;

        // Show success message
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Success",
                message: "Account created with ID: " + recordId,
                variant: "success"
            })
        );
  
         
        }
    
          onclick(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        }).then((url) => {
            this.recordPageUrl = url;
        });
          }
}