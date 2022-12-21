public with sharing class TrialforceSignupController {

    @AuraEnabled(cacheable=false)
    public static String createSignupTrial(String firstName, String lastName, String email, String userName, String company, String myDomain, String country, String preferredLanguage, String templateId, Integer trialDays, Boolean isSignupEmailSuppressed, Boolean shouldConnectToEnvHub, String signupSource){
        
        if(isSignupRequest() == true){
            return insertSignup(firstName, lastName, email, userName, company, myDomain, country, preferredLanguage, templateId, trialDays, isSignupEmailSuppressed, shouldConnectToEnvHub, signupSource);
        } else {
            return 'Unable to create Trials. Log a support case in the Salesforce Partner Community to enable the SignupRequest API in your org';
        }
    }

    private static string insertSignup(String firstName, String lastName, String email, String userName, String company, String myDomain, String country, String preferredLanguage, String templateId, Integer trialDays, Boolean isSignupEmailSuppressed, Boolean shouldConnectToEnvHub, String signupSource){
        SObjectType sObjectType = Schema.getGlobalDescribe().get('SignupRequest');
        Schema.DescribeSObjectResult describeResult = sObjectType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 

        Boolean objectCrudCheck = sObjectType.getDescribe().isCreateable();
        SObject signupRequest = sObjectType.newSObject();
        
        if(objectCrudCheck == true){
            if(fieldsMap.get('FirstName').getDescribe().isCreateable()){
                signupRequest.put('FirstName', String.escapeSingleQuotes(firstName));
            }
            if(fieldsMap.get('LastName').getDescribe().isCreateable()){
                signupRequest.put('LastName', String.escapeSingleQuotes(lastName));
            }
            if(fieldsMap.get('SignupEmail').getDescribe().isCreateable()){
                signupRequest.put('SignupEmail', String.escapeSingleQuotes(email));
            }
            if(fieldsMap.get('Username').getDescribe().isCreateable()){
                signupRequest.put('Username', String.escapeSingleQuotes(userName));
            }
            if(fieldsMap.get('Company').getDescribe().isCreateable()){
                signupRequest.put('Company', String.escapeSingleQuotes(company));
            }
            if(fieldsMap.get('Subdomain').getDescribe().isCreateable() && myDomain != null){
                signupRequest.put('Subdomain', String.escapeSingleQuotes(myDomain));
            }
            if(fieldsMap.get('Country').getDescribe().isCreateable() && country != null){
                signupRequest.put('Country', String.escapeSingleQuotes(country));
            }
            if(fieldsMap.get('PreferredLanguage').getDescribe().isCreateable() && preferredLanguage != null){
                signupRequest.put('PreferredLanguage', String.escapeSingleQuotes(preferredLanguage));
            }
            if(fieldsMap.get('TemplateId').getDescribe().isCreateable()){
                signupRequest.put('TemplateId', String.escapeSingleQuotes(templateId));
            }
            if(fieldsMap.get('TrialDays').getDescribe().isCreateable() && trialDays != null){
                signupRequest.put('TrialDays', Integer.valueOf(trialDays));
            }
            if(fieldsMap.get('IsSignupEmailSuppressed').getDescribe().isCreateable()){
                signupRequest.put('IsSignupEmailSuppressed', Boolean.valueOf(isSignupEmailSuppressed));
            }
            if(fieldsMap.get('ShouldConnectToEnvHub').getDescribe().isCreateable()){
                signupRequest.put('ShouldConnectToEnvHub', Boolean.valueOf(shouldConnectToEnvHub));
            }
            if(fieldsMap.get('SignupSource').getDescribe().isCreateable()){
                signupRequest.put('SignupSource', String.escapeSingleQuotes(signupSource));
            }
            insert signupRequest;
            return String.valueOf(signupRequest);
        } else {
            return 'Error';
        }
    }

    public static boolean isSignupRequest(){
        return (Type.forName('SignupRequest') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isLMA(){
        return (Type.forName('sfLma__License__c') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isAccount(){
        return (Type.forName('Account') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isContact(){
        return (Type.forName('Contact') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isLead(){
        return (Type.forName('Lead') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isOpportunity(){
        return (Type.forName('Opportunity') != null);
    }
    
    @AuraEnabled(cacheable=true)
    public static boolean isCampaign(){
        return (Type.forName('Campaign') != null);
    }

}