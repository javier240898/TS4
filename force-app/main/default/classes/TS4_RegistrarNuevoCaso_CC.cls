public without sharing class TS4_RegistrarNuevoCaso_CC {
    @auraEnabled
    public static NewRegisteredCase saveNewCase(NewCase infoCase, String contactId){
        NewRegisteredCase returnValues = new NewRegisteredCase();
        Case newCase = new Case();
        Contact infoContact = new Contact();
        try{
            infoContact = [SELECT Id, accountId FROM Contact WHERE Id =: contactId];
            newCase.AccountId = infoContact.accountId;
            newCase.ContactId = infoContact.Id;
            newCase.Subject = infoCase.Asunto;
            newCase.Description = infoCase.descReporte;
            newCase.Comentarios_Cliente__c = infoCase.comAdicionales;
            newCase.Origin = 'Plataforma Externa';
            newCase.Status = 'Nuevo';
            newCase.FechaApertura__c = dateTime.now();
            insert newCase;
            returnValues.status = true;
            returnValues.caseId = newCase.Id;
        }catch(Exception exc){
            returnValues.status = false;
        }
        return returnValues;
    }
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {   
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        return Id.valueOf(fileId);
    }
    
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        system.debug('parentId '+parentId);
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
        
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        
        insert oAttachment;
        
        return oAttachment.Id;
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        update a;
    }
    public class NewCase{
        @auraEnabled public string Asunto{get;set;}
        @auraEnabled public string descReporte{get;set;}
        @auraEnabled public string comAdicionales{get;set;}
    }
    public class NewRegisteredCase{
        @auraEnabled public Boolean status{get;set;}
        @auraEnabled public string caseId{get;set;}
    }
}