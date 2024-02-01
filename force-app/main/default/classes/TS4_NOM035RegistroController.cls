/**
 * @File Name          : TS4_NOM035RegistroController.apx
 * @Description        : Controlador ejecutado desde el componente TS4_NOM035Registro para el
  						 registro de un Prospecto. 
 * @Author             : mmauro@ts4.mx
 * @Group              : 
 * @Last Modified By   : 
 * @Last Modified On   : 
 * @Modification Log   : 
 * Ver       Date            Author      		         Modification
 * 1.0    21/09/2020    Maria de los Angeles Mauro E.   Initial Version
**/
public class TS4_NOM035RegistroController 
{
    @auraEnabled
    public static boolean guardaInscripcion (Suscriptor infoSuscriptor){
        List<Lead> existeLead;
        try
        {
            existeLead = [SELECT ID FROM Lead WHERE Email =: infoSuscriptor.Email];
        }
        catch(Exception er)
        {
            System.debug('TS4NOM035RegistroController:ERROR '+ er.getMessage());
        }
        integer ListaProspectossize=existeLead.size();
        if(ListaProspectossize<=0)
        {
            Lead nuevoLead = new Lead();
            nuevoLead.FirstName = infoSuscriptor.Nombre;
            nuevoLead.LastName = infoSuscriptor.Apellido;
            nuevoLead.Email = infoSuscriptor.Email;
            nuevoLead.Phone = infoSuscriptor.Telefono;
            nuevoLead.Company = infoSuscriptor.Compania;
            insert nuevoLead;
            return true;
        }
        else
        {
            system.debug('Ya existe el Lead');
            return false;
        }
    }
    public class Suscriptor
    {
        @auraEnabled public string Nombre{get;set;}
        @auraEnabled public string Apellido{get;set;}
        @auraEnabled public string Email{get;set;}
        @auraEnabled public string Telefono{get;set;}
        @auraEnabled public string Compania{get;set;}
    }
}