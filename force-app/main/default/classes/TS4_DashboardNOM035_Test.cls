@isTest
public class TS4_DashboardNOM035_Test {

    @testSetup public static void start(){
        Account cuenta = new Account();
        cuenta.Name = 'TS4 Test';
        insert cuenta;
        
        Contact contacto = new Contact();
        contacto.AccountId = cuenta.id;
        contacto.FirstName = 'Janeth';
        contacto.LastName = 'Bautista';
        insert contacto;
        
        TS4_appSurvey__c appEncuesta = new TS4_appSurvey__c();
        appEncuesta.Name  = 'Encuesta Test';
        appEncuesta.TS4_referenceGuide__c = 'Guía de Referencia I;Guía de Referencia II';
        appEncuesta.TS4_account__c = cuenta.Id; 
        appEncuesta.TS4_applicationPlace__c = 'Sala de junta';
        insert appEncuesta;
        
        TS4_surveyApplicationContact__c contactoAppEncuesta = new TS4_surveyApplicationContact__c();
        contactoAppEncuesta.TS4_appEncuesta__c = appEncuesta.Id;
        contactoAppEncuesta.TS4_contact__c = contacto.Id;
        insert contactoAppEncuesta;
        
        TS4_referenceGuide__c guiaReferencia = new TS4_referenceGuide__c();
        guiaReferencia.Name = 'Guia test';
        guiaReferencia.TS4_referenceGuides__c = 'Guía de Referencia I'; 
        insert guiaReferencia;
        
        List<TS4_guideSection__c> seccionGuiaList = new List<TS4_guideSection__c>();
        TS4_guideSection__c  seccionGuia = new TS4_guideSection__c();
        seccionGuia.Name = 'Seccion Test'; 
        seccionGuia.TS4_referenceGuide__c = guiaReferencia.id;
        seccionGuiaList.add(seccionGuia);
        insert seccionGuiaList;
        
        TS4_question__c  pregunta = new TS4_question__c();
        pregunta.TS4_questionContent__c = '¿cual es la pregunta de prueba?';
        insert pregunta;
        
        List<TS4_setOption__c > setOpcionesList = new List<TS4_setOption__c>();
        TS4_setOption__c   setOpciones = new TS4_setOption__c();
        setOpciones.Name  = 'Respuestas básicas';
        setOpcionesList.add(setOpciones);
        insert setOpcionesList;
        
        TS4_optionType__c  opciones = new TS4_optionType__c();
        opciones.TS4_weighing__c = 4;
        opciones.TS4_optionTitle__c = 'Siempre';
        opciones.TS4_setOptions__c = setOpciones.Id;
        insert opciones;
        
        List<TS4_response__c> respuestaList = new List<TS4_response__c>();
        TS4_response__c respuesta = new TS4_response__c();
        respuesta.TS4_question__c = pregunta.Id;
        respuesta.TS4_option__c  = opciones.Id;
        respuesta.TS4_contactSurveyApplication__c = contactoAppEncuesta.Id;
        respuestaList.add(respuesta);
        insert respuestaList;
        
    }
    
    public static testMethod void obtenerDatosAppEncuestaTest(){
        TS4_appSurvey__c app = [Select Id from TS4_appSurvey__c Limit 1];
        TS4_DashboardNOM035.getDataEncuesta(app.Id);
    }
}