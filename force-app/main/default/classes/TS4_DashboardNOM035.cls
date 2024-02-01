public without sharing  class TS4_DashboardNOM035 {
    
    @auraEnabled
    public static List<TS4_response__c> getDataEncuesta(Id appEncuestaId){
        TS4_appSurvey__c appEncuesta = [SELECT Id, TS4_referenceGuide__c FROM TS4_appSurvey__c WHERE ID=:appEncuestaId];
        
        String guiaReferencia = 'Guía de Referencia II';
        if(appEncuesta.TS4_referenceGuide__c.contains('III')){
            guiaReferencia = 'Guía de Referencia III';
        }
        
        return [SELECT Id, TS4_Ponderacion__c, TS4_option__c, TS4_value__c, TS4_contactSurveyApplication__c, 
                TS4_question__c, TS4_question__r.TS4_categoryType__c, TS4_question__r.TS4_DomainTypes__c,
                TS4_contactSurveyApplication__r.TS4_appEncuesta__r.TS4_SumaContactosAplicacion__c,
                TS4_question__r.TS4_guideSection__r.TS4_referenceGuide__r.TS4_referenceGuides__c
                FROM TS4_response__c 
                WHERE TS4_question__r.TS4_guideSection__r.TS4_referenceGuide__r.TS4_referenceGuides__c =:guiaReferencia 
                AND TS4_contactSurveyApplication__r.TS4_appEncuesta__c =:appEncuestaId
                AND TS4_question__r.TS4_categoryType__c != null
                AND TS4_question__r.TS4_DomainTypes__c != null];
    }
}