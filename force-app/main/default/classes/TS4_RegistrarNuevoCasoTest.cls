@isTest
public without sharing class TS4_RegistrarNuevoCasoTest {
    public static testMethod void creacionCasoNuevo(){
        TS4_RegistrarNuevoCaso_CC.NewCase infoCases = new TS4_RegistrarNuevoCaso_CC.NewCase();
        appendToFile appen = new appendToFile();
        //appen.fileId = '';
        
        //Map<String, String> cases= new Map<String, String>();
        Account cuenta = new Account();
        cuenta.Name ='Prueba cuenta';
        insert cuenta; 
        
        infoCases.Asunto = 'Asunto';
        infoCases.descReporte = 'Descripción';
        infoCases.comAdicionales= 'Adicionales';
        
        Contact contacto = new Contact();
        contacto.Firstname = 'Javier';
        contacto.LastName  = 'Tenorio Lopez';
        contacto.Email = 'jlopez@ts4.mx';
        contacto.Password__c = '123456';
        contacto.AccountId = cuenta.Id;
        insert contacto;
        
        TS4_RegistrarNuevoCaso_CC.saveNewCase(infoCases, contacto.id);
        
        Test.startTest();
        TS4_RegistrarNuevoCaso_CC.saveChunk(contacto.id, 'test', '', 'test', '');
        
        TS4_RegistrarNuevoCaso_CC.saveTheFile(contacto.id, 'test', '', 'test');
        
       
       // TS4_RegistrarNuevoCaso_CC.appendToFile(fileId, 'test');
        Test.stopTest();
    }
    
    
    public class NewCase{
        @auraEnabled public String Asunto{get;set;}
        @auraEnabled public String descReporte{get;set;}
        @auraEnabled public String comAdicionales{get;set;}
    }
    
    public class appendToFile{
        @auraEnabled public Id fileId{get;set;}
    }
}