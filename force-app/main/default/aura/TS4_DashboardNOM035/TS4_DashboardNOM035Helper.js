({
	procesaDatos : function(component, listRespuestas) {
		let listDominios = [];
        let listCategorias = [];
        let mapDominios = [];
        let mapCategorias = [];
        let listDominiosmuyaltos=[];
        let listDominiosAltos=[];
        let listDominiosMedios=[];
        let listDominiosBajos=[];
        let listDominiosNulos=[];
        let listCategoriasmuyalto = [];
        let listCategoriasAlto = [];
        let listCategoriasMedio = [];
        let listCategoriasBajo = [];
        let listCategoriasNulo = [];
        
        

       
        
        let generalSumaPonderacion = 0;
        for(var i = 0; i<listRespuestas.length; i++){
            generalSumaPonderacion += listRespuestas[i].TS4_Ponderacion__c;
            if(!listDominios.includes(listRespuestas[i].TS4_question__r.TS4_DomainTypes__c )){
                listDominios.push(listRespuestas[i].TS4_question__r.TS4_DomainTypes__c );
                let dominio = {};
                dominio.Nombre = listRespuestas[i].TS4_question__r.TS4_DomainTypes__c;
                dominio.SumaPonderaciones = 0;
                mapDominios.push(dominio);
            }
            
            if(!listCategorias.includes(listRespuestas[i].TS4_question__r.TS4_categoryType__c )){
                listCategorias.push(listRespuestas[i].TS4_question__r.TS4_categoryType__c );
                let categoria = {};
                categoria.Nombre = listRespuestas[i].TS4_question__r.TS4_categoryType__c;
                categoria.SumaPonderaciones = 0;
                mapCategorias.push(categoria);
            }
            
        }
        
        let guiaReferencia = listRespuestas[0].TS4_question__r.TS4_guideSection__r.TS4_referenceGuide__r.TS4_referenceGuides__c;
        for(var i = 0; i<listRespuestas.length; i++){
            for(var dom = 0; dom<mapDominios.length; dom++){
                if(mapDominios[dom].Nombre == listRespuestas[i].TS4_question__r.TS4_DomainTypes__c){
                    mapDominios[dom].SumaPonderaciones += listRespuestas[i].TS4_Ponderacion__c ;
                    
                }
                
                if(guiaReferencia.includes('III') == true){
                    
                    if(mapDominios[dom].Nombre =='Condiciones en el ambiente de trabajo'){
                        
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/condiciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/6.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=9;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=20;
                      
                    }
                    if(mapDominios[dom].Nombre =='Violencia Laboral'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/violencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/2.png';
                        mapDominios[dom].blueScale=7;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=13;
                        mapDominios[dom].orangeScale=16;
                        mapDominios[dom].redScale=32;
                       
                    }
                    if(mapDominios[dom].Nombre =='Carga de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/carga_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/3.png';
                        mapDominios[dom].blueScale=12;
                        mapDominios[dom].greenScale=16;
                        mapDominios[dom].yellowScale=20;
                        mapDominios[dom].orangeScale=24;
                        mapDominios[dom].redScale=52;
                        
                    }
                    if(mapDominios[dom].Nombre =='Jornada de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/jornada_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/7.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                       
                    }
                    if(mapDominios[dom].Nombre =='Falta de control sobre el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/falta_de_control.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/4.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=28;
                        
                    }
                    if(mapDominios[dom].Nombre =='Interferencia en la relación trabajo-familia'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/interferencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/8.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                    }
                    if(mapDominios[dom].Nombre =='Liderazgo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/liderazgo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/5.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=11;
                        mapDominios[dom].redScale=20;
                        
                    }
                    if(mapDominios[dom].Nombre =='Relaciones en el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/relaciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/9.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=24;
                        
                    }
                    if(mapDominios[dom].Nombre =='Reconocimiento del desempeño'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/reconocimiento.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/r.png';
                        mapDominios[dom].blueScale=6;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=14;
                        mapDominios[dom].orangeScale=18;
                        mapDominios[dom].redScale=24;
                       
                    }
                    if(mapDominios[dom].Nombre =='Insuficiente sentido de pertenencia e inestabilidad'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/insuficiente_sentido.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/i.png';
                        mapDominios[dom].blueScale=4;
                        mapDominios[dom].greenScale=6;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=10;
                        mapDominios[dom].redScale=16;
                      
                    }
                }else{
                   
                    if(mapDominios[dom].Nombre =='Violencia Laboral'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/violencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/2.png';
                        mapDominios[dom].blueScale=7;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=13;
                        mapDominios[dom].orangeScale=16;
                        mapDominios[dom].redScale=32;
                        
                    }
                    if(mapDominios[dom].Nombre =='Condiciones en el ambiente de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/condiciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/6.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=7;
                        mapDominios[dom].orangeScale=9;
                        mapDominios[dom].redScale=12;
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Carga de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/carga_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/3.png';
                        mapDominios[dom].blueScale=12;
                        mapDominios[dom].greenScale=16;
                        mapDominios[dom].yellowScale=20;
                        mapDominios[dom].orangeScale=24;
                        mapDominios[dom].redScale=52;
                       
                    }
                    
                    if(mapDominios[dom].Nombre =='Jornada de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/jornada_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/7.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Falta de control sobre el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/falta_de_control.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/4.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=28;
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Interferencia en la relación trabajo-familia'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/interferencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/8.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Liderazgo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/liderazgo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/5.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=11;
                        mapDominios[dom].redScale=20;
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Relaciones en el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/relaciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/9.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=24;
                        
                    }
                }
                
                
            }
        
            
            for(var cat = 0; cat<listCategorias.length; cat++){
                if(mapCategorias[cat].Nombre == listRespuestas[i].TS4_question__r.TS4_categoryType__c){
                    mapCategorias[cat].SumaPonderaciones += listRespuestas[i].TS4_Ponderacion__c ;
                    //console.log(mapCategorias[cat].Nombre,mapCategorias[cat].SumaPonderaciones);
                }
                
                
                if(guiaReferencia.includes('III') == true){
                    if(mapCategorias[cat].Nombre =='Entorno Organizacional'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/entorno_organizacional.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/e.png';
                        mapCategorias[cat].blueScale=10;
                        mapCategorias[cat].greenScale=14;
                        mapCategorias[cat].yellowScale=18;
                        mapCategorias[cat].orangeScale=23;
                        mapCategorias[cat].redScale=40;
                        
                         
                    }
                    if(mapCategorias[cat].Nombre =='Factores propios de la actividad'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/factores.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/11.png';
                        mapCategorias[cat].blueScale=15;
                        mapCategorias[cat].greenScale=30;
                        mapCategorias[cat].yellowScale=45;
                        mapCategorias[cat].orangeScale=60;
                        mapCategorias[cat].redScale=100;
                                           }
                    if(mapCategorias[cat].Nombre =='Liderazgo y relaciones en el trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/Liderazgo_y_relaciones_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/10.png';
                        mapCategorias[cat].blueScale=14;
                        mapCategorias[cat].greenScale=29;
                        mapCategorias[cat].yellowScale=42;
                        mapCategorias[cat].orangeScale=58;
                        mapCategorias[cat].redScale=104;
                        
                        
                    }
                    if(mapCategorias[cat].Nombre =='Ambiente de trabajo'){
                       	mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/ambiente_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/12.png';
						mapCategorias[cat].blueScale=5;
                        mapCategorias[cat].greenScale=9;
                        mapCategorias[cat].yellowScale=11;
                        mapCategorias[cat].orangeScale=14;
                        mapCategorias[cat].redScale=20;
                        
                    }
                    if(mapCategorias[cat].Nombre =='Organización del tiempo de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/organizacion_del_tiempo_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/13.png';
                        mapCategorias[cat].blueScale=5;
                        mapCategorias[cat].greenScale=7;
                        mapCategorias[cat].yellowScale=10;
                        mapCategorias[cat].orangeScale=13;
                        mapCategorias[cat].redScale=24;
                        
                    }
                }else{
                    if(mapCategorias[cat].Nombre =='Factores propios de la actividad'){
                            mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/factores.png';
                            //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/11.png';
                            mapCategorias[cat].blueScale=10;
                            mapCategorias[cat].greenScale=20;
                            mapCategorias[cat].yellowScale=30;
                            mapCategorias[cat].orangeScale=40;
                            mapCategorias[cat].redScale=80;
                            
                           }
                    
                    if(mapCategorias[cat].Nombre =='Liderazgo y relaciones en el trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/Liderazgo_y_relaciones_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/10.png';
                        mapCategorias[cat].blueScale=10;
                        mapCategorias[cat].greenScale=18;
                        mapCategorias[cat].yellowScale=28;
                        mapCategorias[cat].orangeScale=38;
                        mapCategorias[cat].redScale=76;
                        
                        
                    }
                    
                    if(mapCategorias[cat].Nombre =='Ambiente de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/ambiente_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/12.png';
                        mapCategorias[cat].blueScale=3;
                        mapCategorias[cat].greenScale=5;
                        mapCategorias[cat].yellowScale=7;
                        mapCategorias[cat].orangeScale=9;
                        mapCategorias[cat].redScale=12;
                        
                        
                    }
                    
                    if(mapCategorias[cat].Nombre =='Organización del tiempo de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/organizacion_del_tiempo_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/13.png';
                        mapCategorias[cat].blueScale=4;
                        mapCategorias[cat].greenScale=6;
                        mapCategorias[cat].yellowScale=9;
                        mapCategorias[cat].orangeScale=12;
                        mapCategorias[cat].redScale=16;
                       
                    }
                }                    
            }
        }
        
        let dividendo = listRespuestas[0].TS4_contactSurveyApplication__r.TS4_appEncuesta__r.TS4_SumaContactosAplicacion__c;
        
        let generalScale = {};
        generalScale.Nombre = 'Riesgos Psicosociales';
        generalScale.Puntuacion = Math.ceil(generalSumaPonderacion / dividendo);
        if(guiaReferencia.includes('III') == true){
            
            generalScale.blueScale=50;
            generalScale.greenScale=75;
            generalScale.yellowScale=99;
            generalScale.orangeScale=140;
            generalScale.redScale=288;
            //generalScale.escalaObtenida= generalScale<=50? "blue": generalScale.escalaObtenida= generalScale<=75 ? "green": generalScale.escalaObtenida= generalScale<=99 ? "yellow": generalScale.escalaObtenida= generalScale<=140 ? "orange": generalScale.escalaObtenida= generalScale<=288 ? "red";
            if(generalScale.Puntuacion<=50){
                generalScale.escalaObtenida="blue";
            }else if(generalScale.Puntuacion<=75){
                generalScale.escalaObtenida="green";
            }else if(generalScale.Puntuacion<=99){
                generalScale.escalaObtenida="yellow";
            }else if(generalScale.Puntuacion<=140){
                generalScale.escalaObtenida="orange";
            }else if(generalScale.Puntuacion<=288){
               generalScale.escalaObtenida="red";
            }
            
            
        }
        else{
            generalScale.blueScale=20;
            generalScale.greenScale=45;
            generalScale.yellowScale=70;
            generalScale.orangeScale=90;
            generalScale.redScale=184;

            
            if(generalScale.Puntuacion<=20){
                generalScale.escalaObtenida="blue";
            }else if(generalScale.Puntuacion<=45){
               generalScalelistgreenScale.escalaObtenida="green";
            }else if(generalScale.Puntuacion<=70){
                generalScale.escalaObtenida="yellow";
            }else if(generalScale.Puntuacion<=90){
                generalScale.escalaObtenida="orange";
            }else if(generalScale.Puntuacion<=184){
                generalScale.escalaObtenida="red";
            }
            
        }
        
        for(var dom = 0; dom<mapDominios.length; dom++){
            mapDominios[dom].Puntuacion = Math.ceil(mapDominios[dom].SumaPonderaciones/ dividendo);
            //console.log(mapDominios[dom].Nombre,mapDominios[dom].Puntuacion);
            if(guiaReferencia.includes('III') == true){
                    //console.log("GUIA III");
                    if(mapDominios[dom].Nombre =='Condiciones en el ambiente de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/condiciones_de_trabajo.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=9;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=20;
                     	
                         if(mapDominios[dom].Puntuacion<=5-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=9-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=20-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                       
        
                    }
                    if(mapDominios[dom].Nombre =='Violencia Laboral'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/violencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/2.png';
                        mapDominios[dom].blueScale=7;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=13;
                        mapDominios[dom].orangeScale=16;
                        mapDominios[dom].redScale=32;
                        
                        if(mapDominios[dom].Puntuacion<=7-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=10-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=13-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=16-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=32-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }

                    }
                    if(mapDominios[dom].Nombre =='Carga de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/carga_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/3.png';
                        mapDominios[dom].blueScale=12;
                        mapDominios[dom].greenScale=16;
                        mapDominios[dom].yellowScale=20;
                        mapDominios[dom].orangeScale=24;
                        mapDominios[dom].redScale=52;
                        
                       if(mapDominios[dom].Puntuacion<=12-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=16-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=20-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=24-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=52-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    if(mapDominios[dom].Nombre =='Jornada de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/jornada_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/7.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                       if(mapDominios[dom].Puntuacion<=1-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=2-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=4-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=6-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    if(mapDominios[dom].Nombre =='Falta de control sobre el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/falta_de_control.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/4.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=28;
                        
                        if(mapDominios[dom].Puntuacion<=5){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=28){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                        
                    }
                    if(mapDominios[dom].Nombre =='Interferencia en la relación trabajo-familia'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/interferencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/8.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                        if(mapDominios[dom].Puntuacion<=1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=2){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=4){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=6){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    if(mapDominios[dom].Nombre =='Liderazgo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/liderazgo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/5.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=11;
                        mapDominios[dom].redScale=20;
                        
                        if(mapDominios[dom].Puntuacion<=3){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=5){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=20){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    if(mapDominios[dom].Nombre =='Relaciones en el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/relaciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/9.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=24;
                        
                        if(mapDominios[dom].Puntuacion<=5-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=24-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    if(mapDominios[dom].Nombre =='Reconocimiento del desempeño'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/reconocimiento.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/r.png';
                        mapDominios[dom].blueScale=6;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=14;
                        mapDominios[dom].orangeScale=18;
                        mapDominios[dom].redScale=24;
                        
                         if(mapDominios[dom].Puntuacion<=6-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=10-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=18-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=24-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }

                    }
                    if(mapDominios[dom].Nombre =='Insuficiente sentido de pertenencia e inestabilidad'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/insuficiente_sentido.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/i.png';
                        mapDominios[dom].blueScale=4;
                        mapDominios[dom].greenScale=6;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=10;
                        mapDominios[dom].redScale=16;
                        
                        if(mapDominios[dom].Puntuacion<=4-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=6-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=10-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=16-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }

                    }
                }else{
                    
                    if(mapDominios[dom].Nombre =='Violencia Laboral'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/violencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/2.png';
                        mapDominios[dom].blueScale=7;
                        mapDominios[dom].greenScale=10;
                        mapDominios[dom].yellowScale=13;
                        mapDominios[dom].orangeScale=16;
                        mapDominios[dom].redScale=32;
                        
                        if(mapDominios[dom].Puntuacion<=7-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=10-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=13-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=16-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=32-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                        
                    }
                    if(mapDominios[dom].Nombre =='Condiciones en el ambiente de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/condiciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/6.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=7;
                        mapDominios[dom].orangeScale=9;
                        mapDominios[dom].redScale=12;
                        
                       if(mapDominios[dom].Puntuacion<=3){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=5){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=7){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=9){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=12){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    
                    if(mapDominios[dom].Nombre =='Carga de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/carga_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/3.png';
                        mapDominios[dom].blueScale=12;
                        mapDominios[dom].greenScale=16;
                        mapDominios[dom].yellowScale=20;
                        mapDominios[dom].orangeScale=24;
                        mapDominios[dom].redScale=52;
                        
                        if(mapDominios[dom].Puntuacion<=12-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=16-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=20-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=24-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=52-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                        
                    }
                    
                    if(mapDominios[dom].Nombre =='Jornada de trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/jornada_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/7.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                       if(mapDominios[dom].Puntuacion<=1-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=2-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=4-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=6-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    
                    if(mapDominios[dom].Nombre =='Falta de control sobre el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/falta_de_control.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/4.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=28;
                        
                        if(mapDominios[dom].Puntuacion<=5){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=28){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    
                   	if(mapDominios[dom].Nombre =='Interferencia en la relación trabajo-familia'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/interferencia.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/8.png';
                        mapDominios[dom].blueScale=1;
                        mapDominios[dom].greenScale=2;
                        mapDominios[dom].yellowScale=4;
                        mapDominios[dom].orangeScale=6;
                        mapDominios[dom].redScale=8;
                        
                        if(mapDominios[dom].Puntuacion<=1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=2){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=4){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=6){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    
                    if(mapDominios[dom].Nombre =='Liderazgo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/liderazgo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/5.png';
                        mapDominios[dom].blueScale=3;
                        mapDominios[dom].greenScale=5;
                        mapDominios[dom].yellowScale=8;
                        mapDominios[dom].orangeScale=11;
                        mapDominios[dom].redScale=20;
                        
                        if(mapDominios[dom].Puntuacion<=3){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=5){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=20){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                    
                    if(mapDominios[dom].Nombre =='Relaciones en el trabajo'){
                        mapDominios[dom].IconoItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/relaciones_de_trabajo.png';
                        //mapDominios[dom].IconoBox=$A.get('$Resource.IconsBox') + '/iconsbox/9.png';
                        mapDominios[dom].blueScale=5;
                        mapDominios[dom].greenScale=8;
                        mapDominios[dom].yellowScale=11;
                        mapDominios[dom].orangeScale=14;
                        mapDominios[dom].redScale=24;
                        
                         if(mapDominios[dom].Puntuacion<=5-1){
                            listDominiosNulos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=8-1){
                            listDominiosBajos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=11-1){
                            listDominiosMedios.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=14-1){
                            listDominiosAltos.push(mapDominios[dom])
                        }else if(mapDominios[dom].Puntuacion<=24-1){
                            listDominiosmuyaltos.push(mapDominios[dom])
                        }
                    }
                }
            
        }
        
        for(var cat = 0; cat<mapCategorias.length; cat++){
            mapCategorias[cat].Puntuacion = Math.ceil(mapCategorias[cat].SumaPonderaciones/ dividendo);
            console.log(mapCategorias[cat].Nombre,mapCategorias[cat].Puntuacion);
            
            if(guiaReferencia.includes('III') == true){
                    if(mapCategorias[cat].Nombre =='Entorno Organizacional'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/entorno_organizacional.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/e.png';
                        mapCategorias[cat].blueScale=10;
                        mapCategorias[cat].greenScale=14;
                        mapCategorias[cat].yellowScale=18;
                        mapCategorias[cat].orangeScale=23;
                        mapCategorias[cat].redScale=40;
                      
                        
                        if(mapCategorias[cat].Puntuacion<=10){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=14){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=18){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=23){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=40){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                        
                         
                    }
                    if(mapCategorias[cat].Nombre =='Factores propios de la actividad'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/factores.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/11.png';
                        mapCategorias[cat].blueScale=15;
                        mapCategorias[cat].greenScale=30;
                        mapCategorias[cat].yellowScale=45;
                        mapCategorias[cat].orangeScale=60;
                        mapCategorias[cat].redScale=100;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=15){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=30){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=45){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=60){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=100){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                    }
                    if(mapCategorias[cat].Nombre =='Liderazgo y relaciones en el trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/Liderazgo_y_relaciones_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/10.png';
                        mapCategorias[cat].blueScale=14;
                        mapCategorias[cat].greenScale=29;
                        mapCategorias[cat].yellowScale=42;
                        mapCategorias[cat].orangeScale=58;
                        mapCategorias[cat].redScale=104;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=14){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=29){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=42){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=58){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=104){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }

                        
                    }
                    if(mapCategorias[cat].Nombre =='Ambiente de trabajo'){
                       	mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/ambiente_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/12.png';
						mapCategorias[cat].blueScale=5;
                        mapCategorias[cat].greenScale=9;
                        mapCategorias[cat].yellowScale=11;
                        mapCategorias[cat].orangeScale=14;
                        mapCategorias[cat].redScale=20;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=5){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=9){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=11){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=14){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=20){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                        
                    }
                    if(mapCategorias[cat].Nombre =='Organización del tiempo de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/organizacion_del_tiempo_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/13.png';
                        mapCategorias[cat].blueScale=5;
                        mapCategorias[cat].greenScale=7;
                        mapCategorias[cat].yellowScale=10;
                        mapCategorias[cat].orangeScale=13;
                        mapCategorias[cat].redScale=24;
                        
                        if(mapCategorias[cat].Puntuacion<=5){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=7){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=10){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=13){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=24){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                        
                    }
                }else{
                    if(mapCategorias[cat].Nombre =='Factores propios de la actividad'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/factores.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/11.png';
                        mapCategorias[cat].blueScale=10;
                        mapCategorias[cat].greenScale=20;
                        mapCategorias[cat].yellowScale=30;
                        mapCategorias[cat].orangeScale=40;
                        mapCategorias[cat].redScale=80;
                     		
                        
                        if(mapCategorias[cat].Puntuacion<=10){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=20){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=30){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=40){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=80){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                            
                    }		
                    
                    if(mapCategorias[cat].Nombre =='Liderazgo y relaciones en el trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/Liderazgo_y_relaciones_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/10.png';
                        mapCategorias[cat].blueScale=10;
                        mapCategorias[cat].greenScale=18;
                        mapCategorias[cat].yellowScale=28;
                        mapCategorias[cat].orangeScale=38;
                        mapCategorias[cat].redScale=76;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=10){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=18){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=28){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=38){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=176){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                        
                    }
                    
                    if(mapCategorias[cat].Nombre =='Ambiente de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/ambiente_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/12.png';
                        mapCategorias[cat].blueScale=3;
                        mapCategorias[cat].greenScale=5;
                        mapCategorias[cat].yellowScale=7;
                        mapCategorias[cat].orangeScale=9;
                        mapCategorias[cat].redScale=12;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=3){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=5){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=7){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=9){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=12){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                        
                        
                    }
                    
                    if(mapCategorias[cat].Nombre =='Organización del tiempo de trabajo'){
                        mapCategorias[cat].IconoCatItem=$A.get('$Resource.IconosNOM') + '/IconosNOM/organizacion_del_tiempo_de_trabajo.png';
                        //mapCategorias[cat].IconoBoxCat=$A.get('$Resource.IconsBox') + '/iconsbox/13.png';
                        mapCategorias[cat].blueScale=4;
                        mapCategorias[cat].greenScale=6;
                        mapCategorias[cat].yellowScale=9;
                        mapCategorias[cat].orangeScale=12;
                        mapCategorias[cat].redScale=16;
                        
                        
                        if(mapCategorias[cat].Puntuacion<=4){
                            listCategoriasNulo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=6){
                            listCategoriasBajo.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=9){
                            listCategoriasMedio.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=12){
                            listCategoriasAlto.push(mapCategorias[cat])
                        }else if(mapCategorias[cat].Puntuacion<=16){
                            listCategoriasmuyalto.push(mapCategorias[cat])
                        }
                       
                    }
                }
         
        }
        
        component.set('v.general',generalScale);
        component.set('v.dominios',mapDominios);
        component.set('v.categorias',mapCategorias);
        component.set('v.dominiosmuyalto',listDominiosmuyaltos);
        component.set('v.dominiosalto',listDominiosAltos);
        component.set('v.dominiosmedio',listDominiosMedios);
        component.set('v.dominiosbajo',listDominiosBajos);
        component.set('v.dominiosnulos',listDominiosNulos);
        component.set('v.categoriasmuyalto',listCategoriasmuyalto);
        component.set('v.categoriasalto',listCategoriasAlto); 
        component.set('v.categoriasmedio',listCategoriasMedio); 
        component.set('v.categoriasbajo',listCategoriasBajo);
        component.set('v.categoriasnulo',listCategoriasNulo); 
        
        
	}
})