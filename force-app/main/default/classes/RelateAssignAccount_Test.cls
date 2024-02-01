/*************************************************************** 
Name: RelateAssignAccount_Test
Copyright © 2022 Salesforce
======================================================
Purpose:
Test class to execute the methods of the class RelateAssignAccount.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   13/06/2022    INITIAL    Test class to execute the methods of the class RelateAssignAccount.
2.0		 vruiz@ts4.mx	  26/09/2023	TESTING	   Added test cases to a test class.
***************************************************************/
@isTest
public class RelateAssignAccount_Test {
   @isTest
    public static void createList(){
        
        Account accountContract = new Account();
        accountContract.Name  = 'Soriana';
        insert accountContract;
        
        Contact contactAMSContract = new Contact();
        contactAMSContract.LastName = 'Manuel Gonzalez';
        contactAMSContract.AccountId = accountContract.Id;
        contactAMSContract.AMS_TipoContacto__c = 'Agente AMS';
        contactAMSContract.AMS_IdUserClickup__c='12345';
        insert contactAMSContract;
        
        Date fechaInicio = Date.newInstance(2023, 04, 01);
        Date fechaFinalizacion = Date.newInstance(2023, 12, 31);
        
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
        cseContract.Operador__c = contactAMSContract.Id;
        cseContract.Origin = 'Correo electrónico';
        cseContract.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract.Status = 'En proceso';
        cseContract.Nivel__c = 'N1';
        cseContract.Priority = 'Baja';
        cseContract.Tiempo_de_resoluci_n__c = '3';
        cseContract.Tiempo_Real__c= 4;
        cseContract.SlaStartDate =System.now();
        
        Case cseContract2 = new Case();
        cseContract2.AccountId = accountContract.Id;
        cseContract2.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract2.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract2.Subject = 'Caso test contrato servicio';
        cseContract2.Operador__c = contactAMSContract.Id;
        cseContract2.Origin = 'Correo electrónico';
        cseContract2.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract2.Status = 'En validación';
        cseContract2.Nivel__c = 'N1';
        cseContract2.Priority = 'Baja';
        cseContract2.Tiempo_de_resoluci_n__c = '3';
        cseContract2.Tiempo_Real__c= 4;
        cseContract2.SlaStartDate =System.now();
        
        Case cseContract3 = new Case();
        cseContract3.AccountId = accountContract.Id;
        cseContract3.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract3.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract3.Subject = 'Caso test contrato servicio';
        cseContract3.Operador__c = contactAMSContract.Id;
        cseContract3.Origin = 'Correo electrónico';
        cseContract3.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract3.Status = 'Resuelto';
        cseContract3.Nivel__c = 'N1';
        cseContract3.Priority = 'Baja';
        cseContract3.Tiempo_de_resoluci_n__c = '3';
        cseContract3.Tiempo_Real__c= 4;
        cseContract3.SlaStartDate =System.now();
        
        Case cseContract4 = new Case();
        cseContract4.AccountId = accountContract.Id;
        cseContract4.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract4.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract4.Subject = 'Caso test contrato servicio';
        cseContract4.Operador__c = contactAMSContract.Id;
        cseContract4.Origin = 'Correo electrónico';
        cseContract4.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract4.Status = 'Cancelado';
        cseContract4.Nivel__c = 'N1';
        cseContract4.Priority = 'Baja';
        cseContract4.Tiempo_de_resoluci_n__c = '3';
        cseContract4.Tiempo_Real__c= 4;
        cseContract4.SlaStartDate =System.now();
        
        Case cseContract5 = new Case();
        cseContract5.AccountId = accountContract.Id;
        cseContract5.NombreDelSolicitante__c  = 'Victor';
        cseContract5.AMS_EmailSolicitante__c = 'vruiz@ts4.mx';
        cseContract5.Subject = 'Caso test contrato servicio';
        cseContract5.Operador__c = contactAMSContract.Id;
        cseContract5.Origin = 'Correo electrónico';
        cseContract5.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract5.Status = 'Cerrado';
        cseContract5.Nivel__c = 'N1';
        cseContract5.Priority = 'Baja';
        cseContract5.Tiempo_de_resoluci_n__c = '3';
        cseContract5.Tiempo_Real__c= 4;
        cseContract5.SlaStartDate =System.now();

        List <Id> casos = new List <Id>();
        casos.add(cseContract.Id);
        casos.add(cseContract4.Id);
        List <Case> casosList = new List <Case>();
        casosList.add(cseContract);
        casosList.add(cseContract2);
        casosList.add(cseContract3);
        casosList.add(cseContract4);
        casosList.add(cseContract5);

        DateTime completionDate = System.now(); 
        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.Name = cseContract.Subject;

        String body = JSON.serialize(datos);
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',body,null));
        Test.startTest();
        RelateAssignAccount.milestoneUtils(casos,'Hi',completionDate);
        RelateAssignAccount.milestoneUtilsPause(casosList);
        RelateAssignAccount.completeMilestone(casosList);
        RelateAssignAccount.defaultRelatedAcc(casosList);
        Test.stopTest();
    }
}