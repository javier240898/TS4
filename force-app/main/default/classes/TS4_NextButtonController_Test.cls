@isTest
public without sharing class TS4_NextButtonController_Test {
    @testSetup static void setup() {
        TS4_subunidad__c subunidad = new TS4_subunidad__c();
        subunidad.TS4_IndiceSubunidad__c=1;
        insert subunidad;
        
        TS4_subunidad__c subunidad2 = new TS4_subunidad__c();
        subunidad2.TS4_IndiceSubunidad__c=2;
        insert subunidad2;
        
        TS4_subunidad__c subunidad3 = new TS4_subunidad__c();
        subunidad3.TS4_IndiceSubunidad__c=3;
        insert subunidad3;
    }
   
    public static testMethod void getUnidades (){
        //try{
            String pagina = '';
            TS4_subunidad__c subunidad = [SELECT Id,TS4_IndiceSubunidad__c from TS4_subunidad__c limit 1];
            List<TS4_subunidad__c> subunidadNext = [SELECT id from TS4_subunidad__c where TS4_IndiceSubunidad__c =: 
                                              subunidad.TS4_IndiceSubunidad__c+1 limit 1];
      
        pagina = subunidadNext[0].id;

        TS4_NextButtonController.getUnidades(pagina);
            
        /*}catch(Exception e){
   			System.debug('List exception fired');         
        }   */    
    }

}