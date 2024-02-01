@isTest
public class TS4_SURV_SeleccionContactos_Test {

    @testSetup public static void start(){
        Account cuenta = new Account();
        cuenta.Name = 'TS4 Test';
        insert cuenta;
        
        Contact contactotest = new Contact();
        contactotest.AccountId = cuenta.id;
        contactotest.FirstName = 'Janeth';
        contactotest.LastName = 'Bautista';
        
        List<Contact> contactosList = new List<Contact>();
        Contact contacto = new Contact();
        contacto.AccountId = cuenta.id;
        contacto.FirstName = 'Janeth';
        contacto.LastName = 'Bautista';
        contacto.Email = 'janethbautistatapia@gmail.com';
        contacto.MobilePhone = '5335353535';
        contactosList.add(contacto);
        contactosList.add(contactotest);
        insert contactosList;
        
        TS4_appSurvey__c appEncuesta = new TS4_appSurvey__c();
        appEncuesta.Name  = 'Encuesta Test';
        appEncuesta.TS4_referenceGuide__c = 'Guía de Referencia I;Guía de Referencia II';
        appEncuesta.TS4_account__c = cuenta.Id; 
        appEncuesta.TS4_applicationPlace__c = 'Sala de junta';
        insert appEncuesta;
        
        
        TS4_surveyApplicationContact__c contactoAppEncuesta = new TS4_surveyApplicationContact__c();
        contactoAppEncuesta.TS4_appEncuesta__c = appEncuesta.Id;
        contactoAppEncuesta.TS4_contact__c = contacto.Id;
        insert contactoAppEncuesta;
    }
    public static testMethod void obtieneContactosTest(){
        TS4_appSurvey__c appEncuesta = [select id from TS4_appSurvey__c limit 1];
        List<Contact> contactosList = [select AccountId, FirstName,LastName, Email,MobilePhone from Contact];
        TS4_SURV_SeleccionContactos.guardarContactos(contactosList, appEncuesta.Id);        
        TS4_SURV_SeleccionContactos.obtieneContactos(appEncuesta.Id);
        TS4_SURV_SeleccionContactos.obtieneAppContactos(appEncuesta.Id);
        TS4_SURV_SeleccionContactos.eliminarContactos(contactosList, appEncuesta.Id);

    }
    

}