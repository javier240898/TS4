/****************************************************************************************************************
Name: TS4_DocumentsController.apxc
Copyright © 2021 Salesforce 
====================================================================================================================
Purpose: Class containing methods for the TS4_DocumentsController component VisorDocument.cmp

====================================================================================================================
History:
This document the visor in opp, project, lead, factura 
Creation
VERSION  AUTHOR     DATE          LINES     DETAIL           DESCRIPTION.
1.0      ereyna    20/01/2022    15-48     initDocument.    VisorDocument

********************************************************************************************************************/
public without sharing class TS4_DocumentsController {
    /******************************************************************* 
Purpose: Method that obtains the documents attached to the process.
Parameters: String tramite.
Returns: documentos.
Throws :
Information about changes (versions)
********************************************************************/ 
    @AuraEnabled
    public static List<ContentDocument> initDocument(String tramite){
        List<ContentDocument> documentos = new List<ContentDocument>();
        List<Lead> leadlist = [SELECT Id FROM Lead WHERE ID =:tramite];
        if(leadlist.size() >0){
            documentos= [SELECT Id, Title,Description FROM ContentDocument WHERE Description ='rutalead'];
        }
        else{
            List<Opportunity> opplist = [SELECT Id FROM Opportunity WHERE ID =:tramite];
            if(opplist.size() >0){
                documentos= [SELECT Id, Title,Description FROM ContentDocument WHERE Description ='rutaopp'];            
            }
            else{
                List<Factura__c> factlist = [SELECT Id FROM Factura__c WHERE ID =:tramite];
                if(factlist.size() >0){
                    documentos= [SELECT Id, Title,Description FROM ContentDocument WHERE Description ='rutafac'];                        
                }
                else{
                    List<Campaign> camplist = [SELECT Id FROM Campaign WHERE ID =:tramite];
                    if(camplist.size() >0){
                        documentos= [SELECT Id, Title,Description FROM ContentDocument WHERE Description ='rutacamp'];                                    
                    }  
                }
            }
        }
        return documentos;
    }
}