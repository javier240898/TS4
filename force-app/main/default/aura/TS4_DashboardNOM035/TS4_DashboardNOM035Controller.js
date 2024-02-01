({
	doInit : function(component, event, helper) {
		var getData = component.get('c.getDataEncuesta');
        getData.setParams({'appEncuestaId': component.get('v.recordId')});
        getData.setCallback(this, function(response) {
            var listRespuestas = response.getReturnValue();
            helper.procesaDatos(component,listRespuestas);
            
        });
        $A.enqueueAction(getData);
	}
})