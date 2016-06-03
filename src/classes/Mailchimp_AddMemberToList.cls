public class Mailchimp_AddMemberToList
{
    @InvocableMethod(label='Add a Member to a Mailchimp List')
    public static void Execute(List<ExecuteActionRequest> itemList)
    {
        for (ExecuteActionRequest item : itemList) {
            Mailchimp_AddMemberToList.addMemberToListCallout(item.apikey, item.list_id, item.email_address, item.status, item.firstname, item.lastname,
                item.field1_name, item.field1_value, item.field2_name, item.field2_value, item.field3_name, item.field3_value, item.field4_name, item.field4_value, item.field5_name, item.field5_value);
        }
    }

    public static String generateJsonMessage(String email_address, String status, String firstname, String lastname,
        String field1_name, String field1_value, String field2_name, String field2_value, String field3_name, String field3_value, String field4_name, String field4_value, String field5_name, String field5_value) {

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('email_address', email_address);
        gen.writeStringField('status', status);
        
        gen.writeFieldName('merge_fields');
        gen.writeStartObject();
        gen.writeStringField('FNAME', firstname);
        gen.writeStringField('LNAME', lastname);

        if (field1_name != null)
            gen.writeStringField(field1_name, field1_value);

        if (field2_name != null)
            gen.writeStringField(field2_name, field2_value);

        if (field3_name != null)
            gen.writeStringField(field3_name, field3_value);

        if (field4_name != null)
            gen.writeStringField(field4_name, field4_value);
        
        if (field5_name != null)
            gen.writeStringField(field5_name, field5_value);

        gen.writeEndObject();

        return gen.getAsString();
    }

    @future(Callout=true)
    public static void addMemberToListCallout(String apikey, String list_id, String email_address, String status, String firstname, String lastname,
        String field1_name, String field1_value, String field2_name, String field2_value, String field3_name, String field3_value, String field4_name, String field4_value, String field5_name, String field5_value) {

        // Generate basic authentication.
        Blob authValue = Blob.valueOf('user:' + apiKey);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(authValue);

        // Determine data center and construct the path.
        String dataCenter = apiKey.split('-')[1];
        String path = 'https://' + dataCenter + '.api.mailchimp.com/3.0';
        String method = '/lists/' + list_id + '/members';
        String url = path + method;
        System.Debug('URL: ' + url);

        // --------------------------------------------

        String body = Mailchimp_AddMemberToList.generateJsonMessage(email_address, status, firstname, lastname,
        field1_name, field1_value, field2_name, field2_value, field3_name, field3_value, field4_name, field4_value, field5_name, field5_value);

        System.Debug(body);

        // --------------------------------------------

        HttpRequest req = new HttpRequest(); 
         
        //Set HTTPRequest Method
        req.setMethod('POST');

        //Set HTTPRequest header properties
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', authorizationHeader);
        req.setEndpoint( url );

        //Set the HTTPRequest body  
        req.setBody(body);

        Http http = new Http();
          
        //Execute web service call here       
        HTTPResponse res = http.send(req);    

        //Helpful debug messages
        System.debug(res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
    }

	public class ExecuteActionRequest {

        public ExecuteActionRequest(String apikey, String list_id, String email_address, String status, String firstname, String lastname,
            String field1_name, String field1_value, String field2_name, String field2_value, String field3_name, String field3_value, String field4_name, String field4_value, String field5_name, String field5_value) {

            this.apikey = apikey;
            this.list_id = list_id;
            this.email_address = email_address;
            this.status = status;
            this.firstname = firstname;
            this.lastname = lastname;
            this.field1_name = field1_name;
            this.field1_value = field1_value;
            this.field2_name = field2_name;
            this.field2_value = field2_value;
            this.field3_name = field3_name;
            this.field3_value = field3_value;
            this.field4_name = field4_name;
            this.field4_value = field4_value;
            this.field5_name = field5_name;
            this.field5_value = field5_value;
        }

		@InvocableVariable(label='API Key' description='Mailchimp API Key' required=true)
		public String apikey;

        @InvocableVariable(label='List ID' description='Mailchimp List ID' required=true)
        public String list_id;

        @InvocableVariable(label='API Key' description='Email Address' required=true)
        public String email_address;

        @InvocableVariable(label='Status' description='Mailchimp Status')
        public String status;

        @InvocableVariable(label='Member First Name')
        public String firstname;

        @InvocableVariable(label='Member Last Name')
        public String lastname;

        @InvocableVariable(label='Custom Field 1: Name')
        public String field1_name;

        @InvocableVariable(label='Custom Field 1: String Value')
        public String field1_value;

        @InvocableVariable(label='Custom Field 2: Name')
        public String field2_name;

        @InvocableVariable(label='Custom Field 2: String Value')
        public String field2_value;

        @InvocableVariable(label='Custom Field 3: Name')
        public String field3_name;

        @InvocableVariable(label='Custom Field 3: String Value')
        public String field3_value;

        @InvocableVariable(label='Custom Field 4: Name')
        public String field4_name;

        @InvocableVariable(label='Custom Field 4: String Value')
        public String field4_value;

        @InvocableVariable(label='Custom Field 5: Name')
        public String field5_name;

        @InvocableVariable(label='Custom Field 5: String Value')
        public String field5_value;

	}

}