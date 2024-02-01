/*************************************************************** 
Name: AMS_ViewLeadsController_Test
Copyright © 2022 Salesforce
======================================================
Purpose:
Test class to execute methods of the AMS_ViewLeadsController class.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   13/07/2022    INITIAL    Class that show information in the component AMS_ViewLeads.
***************************************************************/
@isTest
public class AMS_ViewLeadsController_Test {
    public static testMethod void getDataLeads(){
        Lead lead = new Lead();
        lead.FirstName ='Prueba Lead';
        lead.LastName ='TS4';
        lead.Status ='New';
        lead.Company ='TS4 Strategy';
        insert lead;
        
        Lead lead2 = new Lead();
        lead2.FirstName ='Prueba';
        lead2.LastName ='TS4';
        lead2.Status ='New';
        lead2.Company ='TS4 Strategy';
        insert lead2;
        
        AMS_ViewLeadsController.getDataLeads(lead.Id);
        List<Lead> listLead = new List<Lead>([SELECT Id FROM Lead]);
        System.assertEquals(2, listLead.size(),'ok');
    }
}