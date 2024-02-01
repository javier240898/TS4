public class AMS_UpdateTasksSFSchedule implements Schedulable{
    public void execute(SchedulableContext ctx) {
        AMS_UpdateTasksSF updateTask = new AMS_UpdateTasksSF();
        database.executeBatch(updateTask,1);
    
    }
}