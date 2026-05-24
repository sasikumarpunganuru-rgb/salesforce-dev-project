import { LightningElement } from 'lwc';

export default class FileUpload extends LightningElement {
  Name='Guest';
  isVisible=false;
 get UpperCase(){
    return this.Name.toUpperCase();}
  handleChange(event){
    this.Name=event.target.value;
  }
  toggleVisibility(){
    this.isVisible=! this.isVisible;
  }
  get ButtonLabel(){
return this.isVisible?'HIde':'Show';
  }
}