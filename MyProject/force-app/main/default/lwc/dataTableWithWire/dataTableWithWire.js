import { LightningElement ,track,wire} from 'lwc';
import AccountList from '@salesforce/apex/accountDemo.AccountList';

export default class DataTableWithWire extends LightningElement {
    @track data
    @track columns=[{label:'label',fieldName:'Name',type:'text' },
    {label:'Type',fieldName:'Type',type:'picklist'},
    {label:'Industry',fieldName:'Industry',type:'picklist'},

    
];
@wire (AccountList) AccountRecords({error,data})
{
    if (data)
    {
        this.data=data;
    }
    else if(error)
    {
        this.data=undefined;
    }
}
}