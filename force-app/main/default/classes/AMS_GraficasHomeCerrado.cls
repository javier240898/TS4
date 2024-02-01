public without sharing class AMS_GraficasHomeCerrado {
    @AuraEnabled
    public static String getCase(String contractID){
 
       List<case> lstopp = [SELECT Id, Status FROM case WHERE Status != 'Cerrado' AND ServiceContractId=:contractID];
        Map<String,Integer> mapLeadSource = new Map<String,Integer>();
 
        for(case l : lstopp)
        {
            if(mapLeadSource.containsKey(l.Status ))
            {
                mapLeadSource.put(l.Status, mapLeadSource.get(l.Status)+1) ;
            }else{
                mapLeadSource.put(l.Status, 1) ;
            }
        }
        system.debug('map values--'+mapLeadSource);
        list<RadarData> radarData1 = new list<RadarData>();
 
        for(String key : mapLeadSource.keySet())
        {
           RadarData rdw = new RadarData();
            rdw.name=key;
            rdw.y=mapLeadSource.get(key);
            radarData1.add(rdw);
        }
        system.debug('rdw---'+radarData1);
        return System.json.serialize(radarData1);
        //return null;
    }
 
    /**
     * Wrapper class to serialize as JSON as return Value
     * */
    class RadarData
    {
       @AuraEnabled
       public String name;
       @AuraEnabled
       public integer y;
 
    }
}