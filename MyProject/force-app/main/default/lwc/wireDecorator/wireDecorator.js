import { LightningElement, wire } from 'lwc';

import getApexData from '@salesforce/apex/accountDemo.getAccounts';



export default class Wiredecorator extends LightningElement {



    @wire(getApexData) getAccountData



    /*

    --wire property returns

-- data

-- error

    */

}