import { LightningElement } from 'lwc';
import processRecords from '@salesforce/apex/CSVController.processRecords';

export default class CsvUploader extends LightningElement {
    isLoading = false;
    message = '';

    handleFileUpload(event) {
        const file = event.target.files[0];
        if (!file) return;

        this.isLoading = true;
        const reader = new FileReader();

        reader.onload = () => {
            const text = reader.result;
            const records = this.parseCSV(text);
            this.sendToApex(records);
        };

        reader.readAsText(file);
    }

    parseCSV(csv) {
        const lines = csv.trim().split('\n');
        const headers = lines[0].split(',').map(h => h.trim());
        const records = [];

        for (let i = 1; i < lines.length; i++) {
            const values = lines[i].split(',');
            const obj = {};

            headers.forEach((header, index) => {
                obj[header] = values[index]?.trim();
            });

            records.push(obj);
        }

        return records;
    }

    sendToApex(records) {
        processRecords({ recordsJson: JSON.stringify(records) })
            .then(result => {
                this.message = `✅ Inserted: ${result.inserted}, 🔄 Updated: ${result.updated}, ⏭️ Skipped: ${result.skipped}`;
            })
            .catch(error => {
                console.error(error);
                this.message = '❌ Error occurred during processing';
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}