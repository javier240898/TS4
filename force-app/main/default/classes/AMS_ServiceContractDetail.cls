public without sharing class AMS_ServiceContractDetail {
    
    @auraEnabled
    public static ServiceContractData InfoDetail(String currentContractId){
        ServiceContractData dataService = new ServiceContractData();
        ServiceContract contractList = [SELECT Id, AccountId, Name, StartDate, EndDate, AMS_Estatus__c, AMS_HorasCompradas__c, AMS_HorasConsumidas__c, AMS_HorasDisponibles__c, FormulaPorcentajeContratos__c FROM ServiceContract WHERE Id=:currentContractId];
        List<Case> caseList = [SELECT CaseNumber, Contact.Name, Subject, Description, Tiempo_Real__c, Status FROM Case WHERE ServiceContractId=:currentContractId];
        
        dataService.contractList = contractList;
        dataService.caseList = caseList;
        return dataService;
    }
    
    public class ServiceContractData {
        //@auraEnabled public String accountId {get;set;}
        //@auraEnabled public String currentContractId {get;set;}
        @auraEnabled public ServiceContract contractList {get;set;}
        @auraEnabled public List<Case> caseList {get;set;}
    }
}