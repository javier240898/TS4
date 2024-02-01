public without sharing class TS4_SURV_SeleccionContactos {
    
    @Auraenabled
    public static List<Contact> obtieneContactos(String idAppEncuesta){
        string idCuenta=[select TS4_account__c from TS4_appSurvey__c where id=:idAppEncuesta].TS4_account__c;
        List<Contact> contactosCuenta = new List<Contact>();
        //contactosCuenta=[select firstName, lastName, MobilePhone, Email ,id from contact where accountId =:idCuenta];
        
        for(AccountContactRelation contactAccount : [select contact.firstName, contact.lastName, contact.MobilePhone, contact.Email ,id from AccountContactRelation  where accountId =:idCuenta]){
            Contact contactoAdd = new Contact();
            contactoAdd.firstName = contactAccount.Contact.firstName;
            contactoAdd.lastName = contactAccount.Contact.lastName;
            contactoAdd.MobilePhone = contactAccount.Contact.MobilePhone;
            contactoAdd.Email = contactAccount.Contact.Email;
            contactoAdd.Id = contactAccount.Contact.Id;
            contactosCuenta.add(contactoAdd);
        }
        return contactosCuenta; 
    }
    
    @Auraenabled
    public static List<TS4_surveyApplicationContact__c> obtieneAppContactos(String idAppEncuesta){
        return [select TS4_contact__c, TS4_appEncuesta__c from TS4_surveyApplicationContact__c where TS4_appEncuesta__c =:idAppEncuesta]; 
    }
    @Auraenabled
    public static void guardarContactos (List<Contact> contactos, String idAppEncuesta){
        List<TS4_surveyApplicationContact__c> listAppContact = new List<TS4_surveyApplicationContact__c>();
            for(Contact cont: contactos){
                TS4_surveyApplicationContact__c  appContact = new TS4_surveyApplicationContact__c();
                appContact.TS4_contact__c = cont.id;
                appContact.TS4_appEncuesta__c = idAppEncuesta;
                listAppContact.add(appContact);
            }
        insert listAppContact;
    }
    @Auraenabled
    public static void eliminarContactos (List<Contact> contactosEliminar, String idAppEncuesta){
        List<id> idsContactDel = new List<id>();
            for(Contact contEliminar: contactosEliminar){
                idsContactDel.add(contEliminar.Id);
            }
       List<TS4_surveyApplicationContact__c> listAppContactD = [select TS4_contact__c, TS4_appEncuesta__c from TS4_surveyApplicationContact__c where TS4_contact__c IN:(idsContactDel) and TS4_appEncuesta__c =:idAppEncuesta];
       delete listAppContactD;
    }   
}