public with sharing class TS4_ListaReportesController {
    
    @AuraEnabled
    public static list<TS4_Reportes__c> getReportes(String idRegistro){
        List<TS4_Reportes__c> ListReportes = new List<TS4_Reportes__c>();
        List<TS4_Reportes__c> Reportes= [SELECT Id, Name, Descripcion__c , URL__c  FROM TS4_Reportes__c];
        for(TS4_Reportes__c reports : Reportes){
            reports.URL__c = reports.URL__c + IdRegistro;
            ListReportes.add(reports);
        }
        return ListReportes;
    }
}