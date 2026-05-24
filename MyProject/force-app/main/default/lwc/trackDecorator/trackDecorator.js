import { LightningElement, track } from 'lwc';



export default class TrackDecorator extends LightningElement {

    //itemList = [];

    @track itemList = [];

   

    newItem;



    handleChange(event){

        this.newItem = event.target.value;

    }



    addItemToList(){

        this.itemList.push(this.newItem);

        console.log('item list:', this.itemList);

    }



}