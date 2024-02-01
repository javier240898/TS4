/****************************************************************************************************************
Name: TS4_DocumentsController.apxc
Copyright © 2021 Salesforce 
====================================================================================================================
Purpose: Class containing methods for the TS4_DocumentsController component VisorDocument.cmp

====================================================================================================================
History:
This document the visor in opp, project, lead, factura 
Creation
VERSION  AUTHOR     DATE          LINES     DETAIL           DESCRIPTION.
1.0      ereyna    20/01/2022    15-48     initDocument.    VisorDocument

********************************************************************************************************************/
@IsTest
public without sharing class TS4_DocumentsController_test {
    
    @IsTest public static void validalead() {
        Test.startTest();
        Lead prospecto = new lead();
        prospecto.LastName = 'Aqui';
        prospecto.FirstName = 'Esta';
        prospecto.Status = 'Nuevo';
        prospecto.Company = 'Comnpañia';
        
        insert prospecto;
        TS4_DocumentsController.initDocument(prospecto.Id);
        
        Account cuenta = new Account ();
        cuenta.Name = 'Cuenta';
        insert cuenta;
        
        Opportunity oppo = new Opportunity();
        oppo.Name = 'Aqui';
        oppo.CloseDate = system.today();
        oppo.AccountId = cuenta.Id;
        oppo.StageName = 'Pipeline';
        insert oppo;
        
        TS4_DocumentsController.initDocument(oppo.Id);
        
        Milestone1_Project__c proyecto = new  Milestone1_Project__c();
        proyecto.Name = 'Proyecto mas';
        insert proyecto;
        
        Factura__c factura = new  Factura__c();
        factura.Proyecto__c = proyecto.Id;
        factura.Name = 'folio';
        insert factura;
        
        TS4_DocumentsController.initDocument(factura.Id);
        
        Campaign campa = new Campaign();
        campa.Name ='Campaña';
        insert campa;
        
        TS4_DocumentsController.initDocument(campa.Id);
        
        Test.stopTest();   
        
    }
}