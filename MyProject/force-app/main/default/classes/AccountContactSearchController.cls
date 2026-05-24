public with sharing class AccountContactSearchController {

    /**
     * 🔹 Search for Accounts by name
     * Returns a list of Account Ids and Names (limit 10)
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKey) {
        if (String.isBlank(searchKey))
            {
            return new List<Account>();
        }
        return [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE :('%' + searchKey + '%')
            ORDER BY Name
            LIMIT 10
        ];
    }

    /**
     * 🔹 Search Contacts by Account Id and (optionally) Name
     * If no search key is passed, returns up to 10 contacts for that Account
     */
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String accountId, String searchKey) {
        if (String.isBlank(accountId)) {
            return new List<Contact>();
        }

        String filterKey = (String.isNotBlank(searchKey) && searchKey.length() >= 3)
            ? ('%' + searchKey + '%')
            : '%';

        return [
            SELECT Id, Name, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId
            AND Name LIKE :filterKey
            ORDER BY Name
            LIMIT 10
        ];
    }
}