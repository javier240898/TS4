({
    guardarCaso : function(component, event, helper) {
        var allValid = component.find('formCase').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (allValid) {
            helper.saveNewCaseHelper(component, event);
        }
	},
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No hay archivos seleccionados...';
        if (event.getSource().get("v.files").length > 0) {
            console.log('event.getSource().get("v.files")[0] ',event.getSource().get("v.files")[0]);
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
             "recordId": component.get("v.recordId")
        });
        editRecordEvent.fire();
    },
    cancelarCasoModal: function(component, event, helper) {
        var cerrarModalCase = component.getEvent('cerrarModal');
        cerrarModalCase.fire();
    }
})