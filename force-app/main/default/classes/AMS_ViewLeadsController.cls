/*************************************************************** 
Name: AMS_ViewLeadsController
Copyright © 2022 Salesforce
======================================================
Purpose:
Class that show information in the component AMS_ViewLeads.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   13/07/2022    INITIAL    Class that show information in the component AMS_ViewLeads.
***************************************************************/
public without sharing class AMS_ViewLeadsController {
    
    @auraEnabled
    public static WrapperData getDataLeads(String idLead){
        WrapperData dataLead = new WrapperData();
        Lead company = [SELECT Id, Company FROM Lead WHERE Id=:idLead];
        String companyName = company.Company;
        if(companyName !=null){
            companyName = '%' + companyName.trim() + '%';
            
            
        }
        dataLead.LeadList = [SELECT Id, Name, Title, Status, Company, Email, Phone FROM Lead WHERE Company LIKE: companyName  AND Id !=:company.Id];
        if(dataLead.LeadList.size() !=0){
            dataLead.status = 'SUCCESS';
            
        }else{
            dataLead.status = 'ERROR';
            
        }
        
        return dataLead;
                
    }
    public class WrapperData{
        @auraEnabled
        public List<Lead> LeadList {get;set;}
        @auraEnabled
        public String status {get;set;}
    }
}