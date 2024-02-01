({
	handleSave : function(component, event, helper) {
		var allValid = component.find('formInscripcion').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (allValid) {
            helper.saveInscripcion(component);
        } else {}
	},
    addressLinkedin: function (component, event, helper) 
    {
        var url = 'https://www.linkedin.com/signup/cold-join';
        window.open(url);
    },
    addressSalesforce: function (component, event, helper) 
    {
        var url ='https://ts4.mx/';
        window.open(url);
    }
})