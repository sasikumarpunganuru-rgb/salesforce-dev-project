public class InstanceIdentifierRetriever {
    public static String getInstanceIdentifier() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://AP24.salesforce.com/services/data/v52.0/limits/');
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer your_access_token');

        HttpResponse res = new Http().send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> organizationInfo = (Map<String, Object>) data.get('organization');
            
            String instanceIdentifier = (String) organizationInfo.get('instanceName');
            return instanceIdentifier;
        } else {
            return 'Error: Unable to retrieve instance identifier';
        }
    }
}