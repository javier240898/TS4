({
    doInit : function(component, event, helper)
    {
        var contractID = component.get('v.contractID');
        var action = component.get("c.getOpportunityJSON");
        action.setParams({'contractID' : contractID});
        console.log('Contrato: ' + contractID);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var dataObj= response.getReturnValue();
                component.set("v.data",dataObj);
                helper.piechart(component,event,helper);
            }
        });
        $A.enqueueAction(action);        
    },
    
    newdoInit : function(component, event, helper)
    {
        console.log('newdoint');
        var contractID = component.get('v.contractID');
        var action = component.get("c.getOpportunityJSON");
        action.setParams({'contractID' : contractID});
        console.log('Contrato: ' + contractID);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var dataObj= response.getReturnValue();
                component.set("v.data",dataObj);
                helper.piechart(component,event,helper);
            }
        });
        $A.enqueueAction(action);        
    },

    piechart : function(component,event,helper) {
        var jsonData = component.get("v.data");
        console.log('jsonData', jsonData);
        var dataObj = JSON.parse(jsonData);
        console.log('data', dataObj);
 
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                renderTo: component.find("chart").getElement(),
                type: 'pie'
            },
            title: {
                text: 'Casos ordenados por Estatus'
            },
            subtitle: {
                //text: component.get("v.chartSubTitle")
            },
            xAxis: {
                categories: component.get("v.xAxisCategories"),
                crosshair: true
            },
            yAxis: {
                min: 0,
                title:
                {
                    text: component.get("v.yAxisParameter")
                }
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.y} ',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name:'StageName',
                data:dataObj
            }]
            
        });
        
    },
})