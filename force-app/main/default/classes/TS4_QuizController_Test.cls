@isTest
public class TS4_QuizController_Test {
    @testSetup static void setup() {
        
        TS4_subunidad__c subunidad = new TS4_subunidad__c();
        subunidad.TS4_urlQuiz__c = 'TS4 Strategy Test';
       // subunidad.TS4_urlQuiz__c = urlQuiz;
        insert subunidad;
        
       

        
    }
     public static testMethod void getQuiz(){
            TS4_subunidad__c subunidad = [SELECT ID FROM TS4_subunidad__c LIMIT 1];
         	TS4_QuizController.getQuiz(subunidad.Id);
        }

}