import { LightningElement } from 'lwc';

export default class Learning1 extends LightningElement {
    fname='sasi';
    lname='punganuru';
    customtext='welcome to salesforce';
    //creating object data and sending it to html component 
elemment={
        age :25,
        city :'bengaluru',
        company:'IBM'
    }
    //creating get method to get the rank of the person basedup on age 
    get agecategory(){
        const rank =this.elemment.age>=50?'old':this.elemment.age>=30? 'middle age':'young';
        return rank;
    }
    get Tier (){
        if(this.elemment.city==='bengaluru')
        return 'tier 1';
    else if (this.elemment.city==='mysore')
        return 'tier 2';
    }
}