public without sharing class TS4_NextButtonController {
    @auraEnabled
    public static  String getUnidades(String url)
    {
        String pagina = '';
        TS4_subunidad__c subunidad=[SELECT id,TS4_IndiceSubunidad__c FROM TS4_subunidad__c where Id =: url];
        TS4_subunidad__c subunidadNext=[SELECT id FROM TS4_subunidad__c where TS4_IndiceSubunidad__c =: 
                                        subunidad.TS4_IndiceSubunidad__c+1 limit 1];    
        pagina = subunidadNext.id;
       
        return pagina;            
    }
    
}