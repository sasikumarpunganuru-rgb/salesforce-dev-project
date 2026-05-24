import { LightningElement, track } from 'lwc';
import getWeather from '@salesforce/apex/WeatherService.getWeather';

export default class WeatherComponent extends LightningElement {
    @track city = 'New York'; // Default city
    @track weatherData;
    @track error;

    handleCityChange(event) {
        this.city = event.target.value;
    }

    getWeatherData() {
        getWeather({ city: this.city })
            .then(result => {
                if (result.status === 'success') {
                    this.weatherData = result;
                    this.error = undefined;
                } else {
                    this.error = result.message || 'Error fetching weather data';
                    this.weatherData = undefined;
                }
            })
            .catch(error => {
                this.error = error.body ? error.body.message : error.message;
                this.weatherData = undefined;
            });
    }
}