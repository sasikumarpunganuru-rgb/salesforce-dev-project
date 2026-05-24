import { LightningElement,track,api} from 'lwc';
import getsumresult from '@salesforce/apex/CalculateNumbers.getsumresult';

export default class CalculateUsingParameters extends LightningElement {
    
    @track fnumber;
    @track snumber;
    @track errors;
    @track sum;
    @api title;
    @api greeting;
    handleclick(){
        getsumresult({firstnumber:this.fnumber,secondnumber:this.snumber})
        .then(result=>{this.sum=result;})
        .catch(error=>{
            this.errors=error;
        });
    }
    handleChange(event)
    {
        if(event.target.name==='fstnumber')
        {
            this.fnumber=event.target.value;
        }
        else if(event.target.name='scdnumber')
        {
            this.snumber=event.target.value;
        }
    }
    handleClear()
    {
        this.fnumber=0;
        this.snumber=0;
        this.sum=null;
    }
}