({
    doInit :function(component, event, helper) {
        console.debug('doInit::');
        helper.getWebinars(component);
    },
    onChangeWebinar: function (component, event, helper) {
        let webinarSelected = component.find('selectWebinar').get('v.value');
        component.set('v.Suscriptor.Webinar',webinarSelected);
    },
    handleSave : function(component, event, helper) {
        var allValid = component.find('formInscripcion').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (allValid) {
            helper.saveInscripcion(component);
        } else {}
	}
})