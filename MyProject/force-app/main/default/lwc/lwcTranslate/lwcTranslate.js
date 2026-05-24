import { LightningElement } from 'lwc';



// importing Custom Label

import WelcomeNoteLabel from '@salesforce/label/c.WelcomeNoteLabel';

import  GreetingLabel from '@salesforce/label/c.GreetingLabel';



export default class CustomLabelExampleLWC extends LightningElement {

    label = {

        WelcomeNoteLabel,

        GreetingLabel

    };

}