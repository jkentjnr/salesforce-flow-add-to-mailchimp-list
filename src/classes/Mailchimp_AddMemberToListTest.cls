@isTest
public class Mailchimp_AddMemberToListTest
{

    @isTest static void Mailchimp_AddMemberToList_generateJsonMessage_01() {

        String email_address = 'james@gmail.com';
        String status = 'subscribed';
        String firstname = 'James';
        String lastname = 'Kent';
        String field1_name = 'BRANCH';
        String field1_value = 'Melbourne';
        String field3_name = 'COUNTRY';
        String field3_value = 'Australia';
        String message = Mailchimp_AddMemberToList.generateJsonMessage(email_address, status, firstname, lastname, field1_name, field1_value, null, null, field3_name, field3_value, null, null, null, null);

        System.Debug(message);
    }

}