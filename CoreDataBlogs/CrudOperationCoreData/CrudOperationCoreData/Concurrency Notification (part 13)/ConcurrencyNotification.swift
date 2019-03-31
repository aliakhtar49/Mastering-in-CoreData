//
//  ConcurrencyNotification.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 31/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ConcurrencyNotification {
    func notificationInsertFired() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextWillSave(_:)), name: Notification.Name.NSManagedObjectContextWillSave, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: mainQueueContext)
        
        mainQueueContext.performAndWait {
            let newUser = User(context: mainQueueContext)
            newUser.secondName = "User One Seond name"
            newUser.firstName = "ali"
            do {
                try mainQueueContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    @objc func contextObjectsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> , inserts.count > 0 {
            print("--- INSERTS ---")
            print(inserts)
            print("+++++++++++++++")
        }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> , updates.count > 0 {
            print("--- UPDATES ---")
            for update in updates {
                print(update.changedValues())
            }
            print("+++++++++++++++")
        }
        
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject> , deletes.count > 0 {
            print("--- DELETES ---")
            print(deletes)
            print("+++++++++++++++")
        }
    }
    
    @objc func contextWillSave(_ notification: Notification) {
        
    }
//    @objc func contextDidSave(_ notification: Notification) {
//
//    }
 
    func notificationUpdateFired() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextWillSave(_:)), name: Notification.Name.NSManagedObjectContextWillSave, object: mainQueueContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: mainQueueContext)
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        mainQueueContext.performAndWait {
            
            let usersOfMainContext: [User] = try! mainQueueContext.fetch(userFetchRequest)
            usersOfMainContext[0].secondName = "Updated User One Seond name"
            usersOfMainContext[0].firstName = "Updated ali"
            do {
                try mainQueueContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    func addUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        let user = User(context: mainQueueContext)
        user.firstName = "ali"
        user.secondName = "Akhtar"
        user.userId = 1
        
        //7) Save to persitsent store
        do {
            try mainQueueContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func notificationThreadingStrategy() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
        let privateQueueContext = appDelegate.persistentContainer.newBackgroundContext()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: privateQueueContext)
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        privateQueueContext.performAndWait  {
            let usersOfPrivateContext: [User] = try! privateQueueContext.fetch(userFetchRequest)
            let user = usersOfPrivateContext[0]
            user.firstName = "Updated ali"
            do {
                try privateQueueContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
             let users: [User] = try! privateQueueContext.fetch(userFetchRequest)
            print("user.firstName on Private thread after save = \(users[0].firstName ?? "Default Value")")

        }
    }
    @objc func contextDidSave(_ notification: Notification) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        mainQueueContext.perform {
            mainQueueContext.mergeChanges(fromContextDidSave: notification)
            
                let userFetchRequest = NSFetchRequest<User>(entityName: "User")
                let usersOfMainContext: [User] = try! mainQueueContext.fetch(userFetchRequest)
                for user in usersOfMainContext {
                    print("user.firstName on Main thread after save = \(user.firstName ?? "Default Value")")
                }
        }
    }
}
