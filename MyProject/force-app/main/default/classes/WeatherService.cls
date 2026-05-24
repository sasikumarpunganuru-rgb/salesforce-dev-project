public with sharing class WeatherService {
    private static final String API_KEY = 'c16c274758c920aab7b13cbd46db0c5e'; // Replace with actual API key
    private static final String BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getWeather(String city) {
        Map<String, Object> result = new Map<String, Object>();
        try {
            String requestUrl = BASE_URL + '?q=' + EncodingUtil.urlEncode(city, 'UTF-8') + '&appid=' + API_KEY + '&units=metric';

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(requestUrl);
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Deserialize JSON response into a Map
                Map<String, Object> weatherData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

                // Extract main weather details (temperature, description, city)
                Map<String, Object> mainData = (Map<String, Object>) weatherData.get('main');
                List<Object> weatherList = (List<Object>) weatherData.get('weather');
                Map<String, Object> weatherDesc = (weatherList != null && weatherList.size() > 0) ? 
                    (Map<String, Object>) weatherList[0] : new Map<String, Object>();

                // Put extracted values into result map
                result.put('temperature', mainData != null ? mainData.get('temp') : 'N/A');
                result.put('description', weatherDesc != null ? weatherDesc.get('description') : 'N/A');
                result.put('city', weatherData.get('name'));
                result.put('status', 'success');
            } else {
                result.put('status', 'error');
                result.put('message', 'Failed to fetch weather data');
            }
        } catch (Exception e) {
            result.put('status', 'error');
            result.put('message', e.getMessage());
        }
        return result;
    }
}