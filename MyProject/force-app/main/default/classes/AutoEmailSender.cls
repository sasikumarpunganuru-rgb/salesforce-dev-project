public class AutoEmailSender {
    public static void sendEmailToContact(Id contactId) {
        Contact c = [SELECT Name, Email FROM Contact WHERE Id = :contactId LIMIT 1];
        if (c.Email != null) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { c.Email });
            mail.setSubject('Hello from Salesforce');
            mail.setPlainTextBody('Hi ' + c.Name + ',\n\nThis is an automated message from Salesforce.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}