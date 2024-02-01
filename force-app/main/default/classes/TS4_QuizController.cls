public class TS4_QuizController {
    @AuraEnabled
    public static string getQuiz(String Idsub ){
        string urlQuiz = '';
        try{
            TS4_subunidad__c subunidad= [SELECT TS4_urlQuiz__c FROM TS4_subunidad__c WHERE Id=:Idsub ];
            urlQuiz=subunidad.TS4_urlQuiz__c;
        }catch(exception e){}
        return urlQuiz;
    }
}