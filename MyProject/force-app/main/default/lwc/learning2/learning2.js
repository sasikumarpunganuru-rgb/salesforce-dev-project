import { LightningElement } from 'lwc';

export default class Learning2 extends LightningElement {
    flag=false;
    getinfo(event)
    {
        this.flag=event.target.checked;
    }
}