@isTest
public without sharing class AMS_ServiceContractDetailTest {
    public static testMethod void busquedaListaContratos(){
        Account cuentas = new Account ();
        cuentas.Name = 'Empresas JLT';
        insert cuentas;
        
        Contact contacto = new Contact();
        contacto.Firstname = 'Javier';
        contacto.LastName  = 'Tenorio Lopez';
        contacto.Email = 'jlopez@ts4.mx';
        contacto.Password__c = '123456';
        insert contacto;  
        
        AMS_ClickupIntegration_Test.createList();
        ServiceContract contrato = [SELECT AccountId FROM ServiceContract WHERE Name ='Contrato Prueba'];
        ServiceContract contratoV2 = [SELECT AccountId FROM ServiceContract WHERE Name ='contratoV2'];
        
        AMS_ServiceContractDetail.InfoDetail(contrato.id);
        AMS_ServiceContractDetail.InfoDetail(contratoV2.id);
        
        
    }
}