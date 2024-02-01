({
    getUrl: function(component)
    { 
        var action = component.get('c.getQuiz');
        action.setParams({
            "Idsub": component.get('v.recordId')
        });
        action.setCallback(this, function(respuesta){
            var data = respuesta.getReturnValue();
            
            component.set('v.urlForm',data);
        });
        $A.enqueueAction(action); 
    }
})