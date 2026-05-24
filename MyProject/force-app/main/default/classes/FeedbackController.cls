public with sharing class FeedbackController {
    @auraEnabled
    public static void createFeedback(String Name, String email, String FeedbackText)
    {
        Feedback__c fb=new Feedback__c();
        fb.Name=name;
        fb.Email__c=email;
        fb.Feedback__c=FeedbackText;
        Insert fb; 
    }
        }