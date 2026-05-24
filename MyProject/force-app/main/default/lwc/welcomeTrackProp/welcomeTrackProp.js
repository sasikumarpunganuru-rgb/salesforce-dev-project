import { LightningElement,track } from 'lwc';


export default class WelcomeTrackProp extends LightningElement {
    @track greetings;
    handleGreetingChanges(event){
        this.greetings=event.target.value;   
        
    }
}