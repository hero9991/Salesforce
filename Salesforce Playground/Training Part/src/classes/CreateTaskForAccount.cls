/**
 * Created by a000 on 01.03.2021.
 */
public with sharing class CreateTaskForAccount {
    @InvocableMethod
    public static void createTask(List<Account> lstAccounts) {
        List<Task> lstTask = new List<Task>();

        for(Account acc : lstAccounts) {
            if (acc.Tasks.size() > 3) {
                User activeUser = [SELECT Id FROM User WHERE IsActive = :true LIMIT 1];
                for (Task taskItem : acc.Tasks) {
                    taskItem.OwnerId = activeUser.Id;
                }
            }else {
                Task newTask = new Task(Subject = 'Negotiations with' + acc.Name,
                        WhatId = acc.Id);
                lstTask.add(newTask);
            }
        }

        insert lstTask;
    }
}