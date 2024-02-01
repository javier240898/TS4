/**
 * @File Name          : TS4_InscripcionWebinar.cls
 * @Description        : Controlador ejecutado desde el componente TS4_InscripcionWebinar 
 * @Author             : sreyna@ts4.mx
 * @Group              : 
 * @Last Modified By   :rjimenez@ts4.mx
 * @Last Modified On   : 14/04/2020 
 * @Modification Log   : 
 * Ver       Date            Author      		         Modification
 * 1.0       01/04/2020         Salvador Reyna           Initial Version
**/
public without sharing class TS4_InscripcionWebinar {

    @AuraEnabled
    public static List<String> getWebinars(){
            List<String> webinars = new List<String>();
            try{
                for(TS4_SetUpCampaign__mdt setup : [SELECT DeveloperName, CampaignName__c,WebinarName__c, Active__c FROM 
                                                    TS4_SetUpCampaign__mdt WHERE Active__c = true]){
                    webinars.add(setup.WebinarName__c);
                }
            }catch(Exception ex){
                webinars.add('NO HAY WEBINARS ACTIVOS');
                System.debug('TS4_InscripcionWebinar::getWebinars::Error::'+ ex.getMessage() + ',' + ex.getMessage());
            }
            return webinars;
        }
    
        @auraEnabled
        public static boolean guardaInscripcion (Suscriptor infoSuscriptor){
            try{
                CampaignMember registroCampana = new CampaignMember();
                Lead existeLead;
                Contact existeContacto;
                CampaignMember existeMiembro;
                try{
                    existeLead = [SELECT ID FROM Lead WHERE Email =: infoSuscriptor.Email LIMIT 1];
                }catch(Exception er){}
                try{
                    existeContacto = [SELECT ID FROM Contact WHERE Email =: infoSuscriptor.Email LIMIT 1];
                }catch(Exception er){}
                try{
                    existeMiembro = [SELECT ID FROM CampaignMember 
                                     WHERE (Lead.Email =: infoSuscriptor.Email OR Contact.Email =: infoSuscriptor.Email) 
                                     AND Name =: infoSuscriptor.Webinar LIMIT 1];
                }catch(Exception er){}
                    
                if(existeMiembro != null){
                    return true;
                }
             
                Campaign campana = [SELECT Id FROM Campaign WHERE Name =: infoSuscriptor.Webinar AND IsActive = true];
                
                
                registroCampana.CampaignId =campana.Id;
                if(existeLead != null){
                    registroCampana.LeadId = existeLead.Id;
                }
                
                if(existeContacto != null && existeLead == null){
                    registroCampana.ContactId = existeContacto.Id;
                }
                
                if(existeContacto == null && existeLead == null){
                    Lead nuevoLead = new Lead();
                    nuevoLead.FirstName = infoSuscriptor.Nombre;
                    nuevoLead.LastName = infoSuscriptor.Apellido;
                    nuevoLead.Email = infoSuscriptor.Email;
                    nuevoLead.Company = infoSuscriptor.Compania;
                    nuevoLead.Phone = infoSuscriptor.Telefono;
                    insert nuevoLead;
                    registroCampana.LeadId = nuevoLead.id;
                }
                
                insert registroCampana;
                return true;
            }catch(Exception er){
                System.debug(er.getCause()+er.getMessage());
                return false;
            }
        }
        
        public class Suscriptor{
            @auraEnabled public string Nombre{get;set;}
            @auraEnabled public string Apellido{get;set;}
            @auraEnabled public string Email{get;set;}
            @auraEnabled public string Compania{get;set;}
            @auraEnabled public string Telefono{get;set;}
            @auraEnabled public string Webinar{get;set;}
        }
    }