public with sharing class CSVController {
    @AuraEnabled
    public static Map<String, Integer> processRecords(String recordsJson) {
        List<Map<String, String>> inputList = 
            (List<Map<String, String>>) JSON.deserializeUntyped(recordsJson);

        // Collect only non-empty External IDs from incoming data
        Set<String> externalIds = new Set<String>();
        for (Map<String, String> row : inputList) {
            String extId = row.get('External_Id__c');
            if (String.isNotBlank(extId)) {
                externalIds.add(extId);
            }
        }

        // Query existing Accounts by known External IDs
        Map<String, Account> existingMap = new Map<String, Account>();
        if (!externalIds.isEmpty()) {
            for (Account acc : [
                SELECT Id, External_Id__c, Name, Phone, Website
                FROM Account
                WHERE External_Id__c IN :externalIds
            ]) {
                existingMap.put(acc.External_Id__c, acc);
            }
        }

        List<Account> toInsert = new List<Account>();
        List<Account> toUpdate = new List<Account>();
        Integer skipped = 0;

        for (Map<String, String> row : inputList) {
            String extId = row.get('External_Id__c');
            String name = row.get('Name');
            String phone = row.get('Phone');
            String website = row.get('Website');

            if (String.isNotBlank(extId) && existingMap.containsKey(extId)) {
                Account existing = existingMap.get(extId);
                Boolean changed = existing.Name != name || 
                                  existing.Phone != phone || 
                                  existing.Website != website;

                if (changed) {
                    existing.Name = name;
                    existing.Phone = phone;
                    existing.Website = website;
                    toUpdate.add(existing);
                } else {
                    skipped++;
                }
            } else {
                // Generate a unique external ID (e.g., "EXT-" + timestamp + random suffix)
                String generatedId = 'EXT-' + DateTime.now().getTime() + '-' + String.valueOf(Crypto.getRandomInteger());
                Account acc = new Account(
                    Name = name,
                    Phone = phone,
                    Website = website,
                    External_Id__c = generatedId
                );
                toInsert.add(acc);
            }
        }

        if (!toInsert.isEmpty()) insert toInsert;
        if (!toUpdate.isEmpty()) update toUpdate;

        return new Map<String, Integer>{
            'inserted' => toInsert.size(),
            'updated' => toUpdate.size(),
            'skipped' => skipped
        };
    }
}