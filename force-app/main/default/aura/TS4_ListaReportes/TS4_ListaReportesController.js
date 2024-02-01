({
    doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Nombre', fielName: 'Name', type:'text'},
            {label: 'Descripcion', fielName: 'Descripcion', type:'text'},
            {label: 'URL', fielName: 'URL__c', type:'url'}
            
        ]);
        helper.getReports(component);
        
    },
    
    
    GoReport : function (component, event, helper) {
        var url = event.getSource().get("v.value");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        
        
    }
})