public with sharing class AccountCSVUploader {

    @AuraEnabled
    public static Map<String, Integer> insertAccounts(List<Map<String, String>> accountList) {
        if (accountList == null || accountList.isEmpty()) {
            throw new AuraHandledException('No data received from file.');
        }

        // Map incoming records by Name
        Map<String, Map<String, String>> inputMap = new Map<String, Map<String, String>>();
        for (Map<String, String> row : accountList) {
            String name = row.get('Name');
            if (String.isNotBlank(name)) {
                inputMap.put(name.trim().toLowerCase(), row);
            }
        }

        // Query existing Accounts by Name
        List<Account> existingAccounts = [
            SELECT Id, Name, Phone, Website
            FROM Account
            WHERE Name IN :inputMap.keySet()
        ];

        Map<String, Account> existingMap = new Map<String, Account>();
        for (Account acc : existingAccounts) {
            existingMap.put(acc.Name.trim().toLowerCase(), acc);
        }

        List<Account> toInsert = new List<Account>();
        List<Account> toUpdate = new List<Account>();
        Integer insertedCount = 0;
        Integer updatedCount = 0;
        Integer skippedCount = 0;

        for (String key : inputMap.keySet()) {
            Map<String, String> csvRow = inputMap.get(key);
            String phone = csvRow.get('Phone');
            String website = csvRow.get('Website');

            if (existingMap.containsKey(key)) {
                Account existing = existingMap.get(key);
                Boolean needsUpdate = false;

                if (String.valueOf(existing.Phone) != String.valueOf(phone)) {
                    existing.Phone = phone;
                    needsUpdate = true;
                }
                if (String.valueOf(existing.Website) != String.valueOf(website)) {
                    existing.Website = website;
                    needsUpdate = true;
                }

                if (needsUpdate) {
                    toUpdate.add(existing);
                    updatedCount++;
                } else {
                    skippedCount++;  // No changes, skipped update
                }

            } else {
                // New record
                Account newAcc = new Account();
                newAcc.Name = csvRow.get('Name');
                newAcc.Phone = phone;
                newAcc.Website = website;
                toInsert.add(newAcc);
                insertedCount++;
            }
        }

        if (toInsert.isEmpty() && toUpdate.isEmpty() && skippedCount == accountList.size()) {
            throw new AuraHandledException('The data you inserted is already present.');
        }

        if (!toInsert.isEmpty()) insert toInsert;
        if (!toUpdate.isEmpty()) update toUpdate;

        // Return inserted and updated count
        return new Map<String, Integer>{
            'inserted' => insertedCount,
            'updated' => updatedCount,
            'skipped' => skippedCount
        };
    }
}