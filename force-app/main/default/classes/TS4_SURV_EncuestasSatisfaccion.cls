public without sharing class TS4_SURV_EncuestasSatisfaccion {
    @Auraenabled
    public static List<TS4_setOption__c> obtenerSetOpciones(){
        return [select Name ,id , (select TS4_weighing__c, TS4_optionTitle__c  from Opciones__r order by TS4_optionOrder__c  asc)from TS4_setOption__c]; 
    }
    
    @Auraenabled
    public static  TS4_EncuestaWrapper obtenerDatosAppEncuesta(String idAppEncuestaContacto){
        TS4_surveyApplicationContact__c encuestacontacto = [select TS4_contact__c, TS4_URLLogotipo__c , TS4_EncuestaContestada__c, TS4_contact__r.Name, TS4_appEncuesta__r.TS4_referenceGuide__c, TS4_appEncuesta__r.TS4_endDate__c, TS4_appEncuesta__r.TS4_Gratitude__c, TS4_appEncuesta__r.TS4_Welcome__c  from TS4_surveyApplicationContact__c  where id =: idAppEncuestaContacto];
        TS4_EncuestaWrapper returnEncuesta= new TS4_EncuestaWrapper();
        returnEncuesta.contactoEncuesta = encuestacontacto;
        returnEncuesta.contacto = encuestacontacto.TS4_contact__r;
        returnEncuesta.encuesta = encuestacontacto.TS4_appEncuesta__r;
        returnEncuesta.guias = new List<TS4_GuiaWrapper >();   
        List <string> guiasEncuesta = encuestacontacto.TS4_appEncuesta__r.TS4_referenceGuide__c.split(';');
        List <TS4_referenceGuide__c> guiasBD = [select id,Name, TS4_guideHeader__c from TS4_referenceGuide__c where TS4_referenceGuides__c IN: guiasEncuesta order by Name asc]; 
        List <TS4_guideSection__c> seccionesbd =[select id, Name, TS4_referenceGuide__c, TS4_sectionDependet__c, TS4_DependentSeccion__c ,(select TS4_TipoDato__c, TS4_setOptions__c, TS4_questionDependent__c, TS4_questionContent__c, TS4_question_num__c, optionDependent__c from Preguntas__r order  by TS4_question_num__c asc) from TS4_guideSection__c order by TS4_sectionOrder__c asc];
        for(TS4_referenceGuide__c guia: guiasBD){
            TS4_GuiaWrapper guiaWraper = new TS4_GuiaWrapper();
            guiaWraper.guia = guia;
            guiaWraper.secciones = new List<TS4_guideSection__c>();
            for(TS4_guideSection__c seccion: seccionesbd){
                if(guia.id == seccion.TS4_referenceGuide__c){
                    guiaWraper.secciones.add(seccion);
                }
            }
            returnEncuesta.guias.add(guiaWraper);
        }
        return returnEncuesta;
    }
    
    public class TS4_EncuestaWrapper{
        @Auraenabled public TS4_appSurvey__c encuesta { get; set;}
        @Auraenabled public Contact contacto { get; set;}  
        @Auraenabled public List<TS4_GuiaWrapper > guias { get; set;}
        @Auraenabled public TS4_surveyApplicationContact__c contactoEncuesta { get; set;}
    }
    
    public class TS4_GuiaWrapper{
        @Auraenabled public TS4_referenceGuide__c guia { get; set;}
        @Auraenabled public List<TS4_guideSection__c> secciones { get; set;}  
    }
    @Auraenabled
    public static List<TS4_response__c> guardaDatosEncuesta(List<TS4_response__c> listaRespuestas, boolean encuestaContestada){
        upsert listaRespuestas;
        TS4_surveyApplicationContact__c contactoApp = new TS4_surveyApplicationContact__c();
        contactoApp.Id = listaRespuestas[0].TS4_contactSurveyApplication__c;
        contactoApp.TS4_EncuestaContestada__c = encuestaContestada;
        update contactoApp;
        return listaRespuestas;   
    }
    
    @Auraenabled
    public static List<TS4_response__c> obtenerRespuestas(String idContactoEncuesta){
        return [select TS4_RespuestaTexto__c, TS4_option__c , TS4_question__c, Id from TS4_response__c where TS4_contactSurveyApplication__c =:idContactoEncuesta];
    }
    
}