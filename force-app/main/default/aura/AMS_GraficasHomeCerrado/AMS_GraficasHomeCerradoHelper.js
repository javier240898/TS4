({
    doInit : function(component, event, helper)
    {
        var contractID = component.get('v.contractID');
        var action = component.get("c.getCase");
        action.setParams({'contractID' : contractID});
        action.setCallback(this, function(response) {
            var state = response.getState();
            //alert(state);
            if (state === "SUCCESS") {
                var dataObj1= response.getReturnValue();
                //jsonData = dataObj;
                console.log('===='+dataObj1);
                component.set("v.data",dataObj1);
                helper.piechart(component,event,helper);
            }
        });
        $A.enqueueAction(action);
    },
    
    piechart : function(component,event,helper) {
        var jsonData = component.get("v.data");
        console.log('jsonData', jsonData);
        var dataObj1 = JSON.parse(jsonData);
        console.log('data', dataObj1);
 
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                renderTo: component.find("chart").getElement(),
                type: 'pie'
            },
            title: {
                text: 'Casos ordenados por Estatus, excluyendo Cerrados'
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
                data:dataObj1
            }]
            
        });
        
    },
})