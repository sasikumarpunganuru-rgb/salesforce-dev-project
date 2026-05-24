@IsTest
public class AccountClassTest {
    @IsTest
    static void testBeforeDelete() {
        // Create a System Administrator profile
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];

        // Create a user with the System Administrator profile
        User adminUser = new User(
            Alias = 'sysadm',
            Email = 'sysadmin@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Admin',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'sysadmin' + DateTime.now().getTime() + '@example.com'
        );
        insert adminUser;

        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Set the running user to the System Administrator
        System.runAs(adminUser) {
            Test.startTest();

            // Attempt to delete the test Account
            Database.DeleteResult result = Database.delete(testAccount, false);

            Test.stopTest();

            // Verify that the deletion failed
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);

            // Verify that the expected error message is present
            Boolean expectedErrorFound = false;
            for (Database.Error error : result.getErrors()) {
                if (error.getMessage().contains('You dont have Sysadm Access please get the access or contact System Admin')) {
                    expectedErrorFound = true;
                    break;
                }
            }
            System.assert(expectedErrorFound, 'Expected error message not found.');
        }
    }
}