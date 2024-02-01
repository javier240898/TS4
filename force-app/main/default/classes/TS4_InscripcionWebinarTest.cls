@isTest
public class TS4_InscripcionWebinarTest {
	
    @testSetup
    public static void setup(){
        Campaign campanaHO = new Campaign();
        campanaHO.Name='Webinar HomeOffice';
        insert campanaHO;
        
        Lead leadExistente = new Lead();
        leadExistente.LastName = 'Reyna';
        leadExistente.Email = 'sreyna@ts4.mx';
        leadExistente.Company = 'TS4';
        insert leadExistente;
    }
    
    public static testMethod void saveInscripcionExistente(){
        TS4_InscripcionWebinar.Suscriptor inscripcion= new TS4_InscripcionWebinar.Suscriptor();
        inscripcion.Nombre ='Salvador';
        inscripcion.Apellido ='Reyna';
        inscripcion.Email ='sreyna@ts4.mx';
        inscripcion.Compania ='TS4';
        inscripcion.Telefono ='5551040002';
        TS4_InscripcionWebinar.guardaInscripcion(inscripcion);
    }
    
    public static testMethod void saveInscripcionNOExistente(){
        TS4_InscripcionWebinar.Suscriptor inscripcion= new TS4_InscripcionWebinar.Suscriptor();
        inscripcion.Nombre ='Salvador';
        inscripcion.Apellido ='Reyna';
        inscripcion.Email ='ereyna@ts4.mx';
        inscripcion.Compania ='TS4';
        inscripcion.Telefono ='5551040002';
        TS4_InscripcionWebinar.guardaInscripcion(inscripcion);
        TS4_InscripcionWebinar.guardaInscripcion(inscripcion);
    }
}