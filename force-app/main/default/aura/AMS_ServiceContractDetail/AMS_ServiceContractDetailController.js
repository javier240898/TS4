({
    executeDetail : function(component, event, helper) {
        component.set("v.mostrarGraficas", false);
        component.set("v.leyendaButtom", 'Mostrar Gráficas de Casos');
        helper.GetInfoDetail(component, event, helper);
    },
    
    executeDetail2 : function(component, event, helper) {
        component.set("v.mostrarGraficas", false);
        component.set("v.leyendaButtom", 'Mostrar Gráficas de Casos');
        helper.GetInfoDetail(component, event, helper);
    },
    
    showGraphic : function(component, event, helper) {
        var valorBoton = component.get('v.mostrarGraficas');
        if(valorBoton== false || valorBoton=='false'){
            component.set("v.mostrarGraficas", true);
            component.set("v.leyendaButtom", 'Cerrar Gráficas de Casos');
        } else if(valorBoton== true || valorBoton=='true'){
            component.set("v.mostrarGraficas", false);
            component.set("v.leyendaButtom", 'Mostrar Gráficas de Casos');
        }
    }
})