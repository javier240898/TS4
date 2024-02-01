({
    getReports : function(component) {
        var action = component.get('c.getReportes');
        var idAppEncuesta = component.get('v.recordId');
        action.setParams({'idRegistro': idAppEncuesta});
        action.setCallback(this, function(response){
            var state = response.getState();
            component.set("v.data", response.getReturnValue());
        });
        $A.enqueueAction(action);
    }
 })