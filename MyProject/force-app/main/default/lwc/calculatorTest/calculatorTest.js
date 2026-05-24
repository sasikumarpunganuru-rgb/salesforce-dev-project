import { LightningElement,track } from 'lwc';

export default class ButtonBasic extends LightningElement {
    firstnumber=0;
    secondnumber=0;
    @track result;


    handlerchange(event) {
        if(event.target.name==='fname')
        {
            this.firstnumber=event.target.value;
        }
         if(event.target.name==='sname')
        {
            this.secondnumber=event.target.value;
        }
        if(event.target.name==='add')
        {
        this.result=parseInt(this.firstnumber)+parseInt(this.secondnumber);
        }
        if(event.target.name==='sub')
        {
        this.result=parseInt(this.firstnumber)-parseInt(this.secondnumber);
        }
        if(event.target.name==='mul')
        {
        this.result=parseInt(this.firstnumber)*parseInt(this.secondnumber);
        }
        if(event.target.name==='div')
        {
        this.result=parseInt(this.firstnumber)/parseInt(this.secondnumber);
        }
        if(event.target.name==='per')
        {
        this.result=parseInt(this.firstnumber)%parseInt(this.secondnumber);
        }
    }
    handleReset()
    {
        this.firstnumber=0;
        this.secondnumber=0;
        this.result=null;
    }
}