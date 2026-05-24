import { LightningElement,track} from 'lwc';
import Lead_Name from '@salesforce/schema/Lead.Name';
import Lead_Email from '@salesforce/schema/Lead.Email';
import Lead_Phone from '@salesforce/schema/Lead.Phone';
import Lead_Company from '@salesforce/schema/Lead.Company';
import Lead_Country from '@salesforce/schema/Lead.Country__c';
import Lead_Owner from '@salesforce/schema/Lead.OwnerId';
import Lead_Convertion from '@salesforce/schema/Lead.lead_Conversion__c'

//import Lead_Address from '@salesforce/schema/Lead.Address';
import Lead_Industry from '@salesforce/schema/Lead.Industry';
import Lead_Annual  from '@salesforce/schema/Lead.AnnualRevenue';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import{NavigationMixin} from 'lightning/navigation';


export default class leadCreationForm extends NavigationMixin(LightningElement) {
  @track recordId;
  @track objectApiName = 'Lead';
  @track assignmentRuleId = '03d5g000000llxUAAQ';

    fieldList=[Lead_Owner,Lead_Name,Lead_Email,Lead_Phone,Lead_Company,Lead_Industry,Lead_Annual,Lead_Country,Lead_Convertion];
    handleLeadCreate(event){
        this.recordId = event.detail.id;
        const evt=new ShowToastEvent({
            title:"Lead Created",
            Message: "Record Id: "+event.detail.id,
            variant:"sucess",
        });
        this.dispatchEvent(evt);
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId: event.detail.id,
                objectApiName: 'Account',
                actionName:'view'
               
            },
        });
    }
}