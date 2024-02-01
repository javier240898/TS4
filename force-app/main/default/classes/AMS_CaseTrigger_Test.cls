/*************************************************************** 
Name: AMS_CaseTrigger_Test
Copyright © 2022 Salesforce
======================================================
Purpose:
Class test trigger to calculate service contract time of a case.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      eortega@ts4.mx   26/04/2022    INITIAL    Class test trigger to calculate service contract time of a case.
***************************************************************/
@isTest
public class AMS_CaseTrigger_Test {
    @isTest static void TestCaseTrigger() {
       
        Account accountContract = new Account();
        accountContract.Name  = 'TS4 Strategy';
        insert accountContract;
        
        Contact contactAMSContract = new Contact();
        contactAMSContract.LastName = 'Manuel Gonzalez';
        contactAMSContract.AccountId = accountContract.Id;
        contactAMSContract.AMS_TipoContacto__c = 'Agente AMS';
        contactAMSContract.AMS_IdUserClickup__c='12345';
        insert contactAMSContract;
        
        //Si en algun momento vuelve a realizar pruebas por alguna modificacion a la clase AMS_CaseTrigger
        //no olvide que la fechaInicio siempre debe ser menor a la fecha en ejecute esta clase test
        //y que la fechaFinalizacion debe ser mayor a la fecha en que ejecute esta clase test
        Date fechaInicio = Date.newInstance(2023, 09, 30);
        Date fechaFinalizacion = Date.newInstance(2023, 10, 31);
        
        ServiceContract contract = new ServiceContract();
        contract.Name= '1234';
        contract.AccountId= accountContract.Id;
        contract.StartDate = fechaInicio;
        contract.EndDate= fechaFinalizacion;
        contract.AMS_Estatus__c = 'Activo';
        insert contract;
        
        Case cseContract = new Case();
        cseContract.AccountId = accountContract.Id;
        cseContract.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract.Subject = 'Caso test contrato servicio';
        cseContract.AMS_EspecialistaAsignado__c = contactAMSContract.Id;
        cseContract.Origin = 'Correo electrónico';
        cseContract.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract.Status = 'Nuevo';
        cseContract.Nivel__c = 'N1';
        cseContract.Priority = 'Baja';
        cseContract.Tiempo_de_resoluci_n__c = '3';
        cseContract.Tiempo_Real__c= 4;
        cseContract.AMS_IdTareaClickup__c = '123456';
        
        Case cseContractExpired = new Case();
        cseContractExpired.AccountId = accountContract.Id;
        cseContractExpired.NombreDelSolicitante__c  = 'Elizabeth';
        cseContractExpired.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContractExpired.Subject = 'Caso test contrato servicio vencido';
        cseContractExpired.AMS_EspecialistaAsignado__c = contactAMSContract.Id;
        cseContractExpired.Origin = 'Correo electrónico';
        cseContractExpired.AMS_TipoIncidencia__c = 'Incidencia';
        cseContractExpired.Status = 'Nuevo';
        cseContractExpired.Nivel__c = 'N1';
        cseContractExpired.Priority = 'Baja';
        cseContractExpired.Tiempo_de_resoluci_n__c = '3';
        
        Account account = new Account();
        account.Name  = 'Bticino Legrand';
        insert account;
        
        Contact contactAMS = new Contact();
        contactAMS.LastName = 'Mario Juarez';
        contactAMS.AccountId = account.Id;
        contactAMS.AMS_TipoContacto__c = 'Agente AMS';
        contactAMS.AMS_IdUserClickup__c='12345';
        insert contactAMS;
        
        Case cse = new Case();
        cse.AccountId = account.Id;
        cse.NombreDelSolicitante__c  = 'Salvador';
        cse.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cse.Subject = 'Caso test sin contrato servicio';
        cse.AMS_EspecialistaAsignado__c = contactAMS.Id;
        cse.Origin = 'Correo electrónico';
        cse.AMS_TipoIncidencia__c = 'Incidencia';
        cse.Status = 'Nuevo';
        cse.Nivel__c = 'N1';
        cse.Priority = 'Baja';
        cse.Tiempo_de_resoluci_n__c = '3';
        
        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.Name = cse.Subject;

        String body = JSON.serialize(datos);
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',body,null));
        Test.startTest();
            insert cseContract;
            cseContract.Tiempo_Real__c= 5.5;
            update cseContract;
        Test.stopTest();
       
        
    }
    
}