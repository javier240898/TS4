({
    helperDocumentos: function(component, event, helper) {
        var tramiteId = component.get("v.recordId");
        var action = component.get('c.initDocument');
        action.setParams({
            "tramite": tramiteId
        });
        action.setCallback(this, function(respuesta){
            var resp = respuesta.getReturnValue();
            console.log(resp);
            component.set('v.documents',  resp[0].Id );
            component.set('v.titledocuments',  resp[0].Title );
        });
        $A.enqueueAction(action);
    },
})