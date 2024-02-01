({
    afterScriptsLoaded: function(component, event, helper)
    {
        console.log('entra afterScriptsLoaded');
        
        helper.doInit(component,event,helper);
    }    
    
})