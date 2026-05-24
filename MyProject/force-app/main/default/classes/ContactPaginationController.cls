public with sharing class ContactPaginationController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchKey, Integer pageSize, Integer pageNumber) {
        Integer offsetVal = (pageNumber - 1) * pageSize;
        String key = '%' + searchKey + '%';

        return [SELECT Id, Name, Email, Phone 
                FROM Contact 
                WHERE Name LIKE :key  or Email like : key
                ORDER BY Name 
                LIMIT :pageSize OFFSET :offsetVal];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getContactCount(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT COUNT() FROM Contact WHERE Name LIKE :key OR Email LIKE :KEY];
    }
}