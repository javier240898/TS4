@isTest
public class TS4_ListaReportesController_Test {
    @testSetup static void ConsultaListaReportes(){
       
        List<Account> testCuenta = new List<Account>();
        for(Integer i = 0; i<2; i++){
            testCuenta.add(new Account(Name= 'TS4 Test' + i));
        }
        insert testCuenta;
      
        
    }
    
    public static testmethod void getListReports()
    {
        Account cuenta = [Select Id, Name FROM Account WHERE Name = 'TS4 Test0'];
        
        Contact contacto = new Contact();
        contacto.AccountId = cuenta.id;
        contacto.FirstName = 'Rogelio';
        contacto.LastName = 'Jimenez';
        insert contacto;
        
        TS4_appSurvey__c appEncuesta = new TS4_appSurvey__c();
        appEncuesta.Name  = 'TEST SAndbox';
        appEncuesta.TS4_referenceGuide__c = 'Guía de Referencia I;Guía de Referencia II;Guía de Referencia III';
        appEncuesta.TS4_account__c = cuenta.Id; 
        appEncuesta.TS4_applicationPlace__c = 'Oficinas TS4';
        insert appEncuesta;
        
        TS4_surveyApplicationContact__c contactoAppEncuesta = new TS4_surveyApplicationContact__c();
        contactoAppEncuesta.TS4_appEncuesta__c = appEncuesta.Id;
        contactoAppEncuesta.TS4_contact__c = contacto.Id;
        insert contactoAppEncuesta;
        
       
        TS4_Reportes__c Reportes = new TS4_Reportes__c();
        Reportes.IdReporte__c = 'a08c000000HwIrMAAV';
        Reportes.Name = 'Respuestas Por Aplicación de Encuesta';
        Reportes.Descripcion__c = 'consulta las respuestas sobre las encuestas realizadas';
        Reportes.URL__c = 'https://ts4--ts4dev.lightning.force.com/lightning/r/Report/00Oc0000000mlpWEAQ/view?fv0=' + appEncuesta.Id;
        Insert Reportes;
        
        
        TS4_Reportes__c Reportes2 = new TS4_Reportes__c();
        Reportes2.IdReporte__c = 'a08c000000HwIrHAAV'; 
        Reportes2.Name = 'Links de acceso por contacto';
        Reportes2.Descripcion__c = 'Puede consultar los link de acceso para todos los usuarios que están en la aplicación de encuestas';
        Reportes2.URL__c = 'https://ts4--ts4dev.lightning.force.com/lightning/r/Report/00Oc0000000mlpbEAA/view?fv0=' + appEncuesta.Id;
        Insert Reportes2;
        
       
       
        TS4_ListaReportesController.getReportes(appEncuesta.Id);
        
        
         
    }
    
 
}