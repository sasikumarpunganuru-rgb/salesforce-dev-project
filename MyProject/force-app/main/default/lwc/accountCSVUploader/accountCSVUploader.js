import { LightningElement } from 'lwc';
import insertAccounts from '@salesforce/apex/AccountCSVUploader.insertAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountCSVUploader extends LightningElement {
    fileData;
    fileName = '';
    uploadSuccess = false;
    uploadError = false;
    insertedCount = 0;
    updatedCount = 0;
    skippedCount = 0;
    errorMessage = '';

    handleFileChange(event) {
        this.uploadSuccess = false;
        this.uploadError = false;
        this.insertedCount = 0;
        this.updatedCount = 0;
        this.skippedCount = 0;

        const file = event.target.files[0];
        if (file) {
            this.fileName = file.name;
            const reader = new FileReader();
            reader.onload = () => {
                const text = reader.result;
                this.fileData = this.parseCSV(text);
            };
            reader.readAsText(file);
        }
    }

    handleUpload() {
        if (this.fileData && this.fileData.length > 0) {
            insertAccounts({ accountList: this.fileData })
                .then(result => {
                    this.insertedCount = result.inserted || 0;
                    this.updatedCount = result.updated || 0;
                    this.skippedCount = result.skipped || 0;

                    // Show success message
                    this.uploadSuccess = true;
                    this.uploadError = false;

                    const message = `Inserted: ${this.insertedCount}, Updated: ${this.updatedCount}, Skipped: ${this.skippedCount}`;
                    this.showToast('Success', message, 'success');
                })
                .catch(error => {
                    this.uploadError = true;
                    this.uploadSuccess = false;
                    this.errorMessage = error.body.message || 'Unknown error occurred';
                    this.showToast('Error', this.errorMessage, 'error');
                });
        } else {
            this.showToast('Error', 'Please select a valid CSV file.', 'error');
        }
    }

    parseCSV(csvText) {
        const rows = csvText.trim().split('\n');
        const headers = rows.shift().split(',');

        return rows.map(row => {
            const values = row.split(',');
            let accountObj = {};
            headers.forEach((header, index) => {
                accountObj[header.trim()] = values[index]?.trim();
            });
            return accountObj;
        });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}