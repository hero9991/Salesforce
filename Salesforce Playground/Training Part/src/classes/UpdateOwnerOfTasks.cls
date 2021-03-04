/**
 * Created by a000 on 04.03.2021.
 */

public with sharing class UpdateOwnerOfTasks {
    @InvocableMethod
    public static void createTask(List<Account> lstAccounts) {
        List<Task> lstTask = [SELECT OwnerId, WhatId FROM Task];
        List<Task> lstUpdatedTask = new List<Task>();
        Integer i = 0;
        User activeUser = [SELECT Id FROM User WHERE IsActive = :true LIMIT 1];
        for(Account acc : lstAccounts) {
            for (Task taskItem : lstTask) {
                if (taskItem.WhatId == acc.Id){
                    i++;
                    lstUpdatedTask.add(new Task(Id = taskItem.Id, OwnerId = activeUser.Id));
                }
            }
        }
        if(i > 3){
            System.debug('done');
            update lstUpdatedTask;
        }

    }
}