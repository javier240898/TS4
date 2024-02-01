/******************************************************************* 
Name: AMS_Mock
Copyright © 2021 Salesforce
======================================================
Purpose:
Class test to AMS_ClickupIntegration.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      dmarcos@ts4.mx   10/06/2022    INITIAL     DEV CSR: 
******************************************************************/
@isTest
global class  AMS_Mock implements HttpCalloutMock{
     protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Blob bodyAsBlob;
    protected Map<String, String> responseHeaders;
    
    /******************************************************************* 
Purpose:Create a object to AMS_ClickupIntegration_Test
Parameters: Integer code, String status, String body, Map<String, String> responseHeaders
Returns: 
Throws :
Information about changes (versions)
********************************************************************/
    public AMS_Mock(Integer code, String status, String body, Map<String, String> responseHeaders){
        this.code = code;
        this.status = status;
        this.bodyAsString = body;
        this.bodyAsBlob = null;
        this.responseHeaders = responseHeaders;
    }
    
    /******************************************************************* 
Purpose:Mock to simulate the response of the service
Parameters: Integer code, String status, String body, Map<String, String> responseHeaders
Returns: 
Throws :
Information about changes (versions)
********************************************************************/
    public AMS_Mock(Integer code, String status, Blob body, Map<String, String> responseHeaders){
        this.code = code;
        this.status = status;
        this.bodyAsBlob = body;
        this.bodyAsString = null;
        this.responseHeaders = responseHeaders;
    }
    public HTTPResponse respond(HTTPRequest req){
        HttpResponse resp = new HttpResponse();
        resp.setStatusCode(code);
        resp.setStatus(status);
        resp.setHeader('Content-Type', 'application/json');
        if (bodyAsBlob != null){
            resp.setBodyAsBlob(bodyAsBlob);
        } 
        else{
            resp.setBody(bodyAsString);
        }
        
        if (responseHeaders != null){
            for (String key : responseHeaders.keySet()){
                resp.setHeader(key, responseHeaders.get(key));
            }
        }

        return resp;
    }
}