public without sharing class AMS_HomeController {
    
    @auraEnabled
    public static HomeData InfoHomeGet(String contactId){
        HomeData datosHome = new HomeData();
        datosHome.redirect = false;
        if(userTokenActive(contactId) == true){
            Contact identAccount = [SELECT AccountId FROM Contact WHERE Id=:contactId];
            datosHome.accountId = identAccount.AccountId;
            
            ServiceContract currentContract = [Select ID from ServiceContract Where AccountId=:datosHome.accountId and AMS_Estatus__c ='Activo' Limit 1];
            List<ServiceContract> currentContractHistory = [SELECT Id, AccountId, Name, StartDate, EndDate, AMS_Estatus__c FROM ServiceContract WHERE AccountId=:datosHome.accountId];

            datosHome.currentContractId = currentContract.Id;
            datosHome.currentContractHistory = currentContractHistory;
        }else{
            datosHome.redirect = true;
        }
        
        return datosHome;
    }
    
    public static boolean userTokenActive(String contactId){
        Contact contactInfo = [SELECT AMS_FechaHrInicioSesion__c  FROM Contact WHERE id=:contactId];
        Boolean respuesta = false;
        if(contactInfo.AMS_FechaHrInicioSesion__c != null){
            DateTime lastConnection = contactInfo.AMS_FechaHrInicioSesion__c ;
            
            if(lastConnection.addMinutes(5) > DateTime.now() ){
                Contact contactLastConnection = new Contact();
                contactLastConnection.Id=contactId;
                contactLastConnection.AMS_FechaHrInicioSesion__c  = DateTime.now();
                update contactLastConnection;
                respuesta = true;
            }  
        }else{
            respuesta = true;
        }
        return respuesta;
    }
    
    public class HomeData{
        @auraEnabled public String accountId {get;set;}
        @auraEnabled public String currentContractId {get;set;}
        @auraEnabled public List<ServiceContract> currentContractHistory {get;set;}
        @auraEnabled public Boolean redirect {get;set;}        
    }
}