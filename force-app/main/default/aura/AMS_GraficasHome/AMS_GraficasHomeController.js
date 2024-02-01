({
    doInit : function(component, event, helper) {
        
    },
    
    afterScriptsLoaded: function(component, event, helper)
    {
        helper.doInit(component,event,helper);
    },
    
})