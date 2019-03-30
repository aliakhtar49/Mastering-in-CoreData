//
//  Threading.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 23/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Threading {
    func addFourUserToDemonstrateParentAndChild() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        for i in 1...4 {
            let user = User(context: mainQueueContext)
            user.firstName = "User \(i)"
        }
        
        //7) Save to persitsent store
        do {
            try mainQueueContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func logsUser(on context: NSManagedObjectContext, with text: String){
        
        context.performAndWait {
            let userFetchRequest = NSFetchRequest<User>(entityName: "User")
            
            let usersOfMainContext: [User] = try! context.fetch(userFetchRequest)
            print("\(text) \(usersOfMainContext.count)")
        }
      
    }
    
    func parentChildContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // 1) get main context
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        // 2) get private context
        let privateChildContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        //3 make main context as a parent of child (private context)
        privateChildContext.parent = mainQueueContext
        //4) logs number of users on main context
        logsUser(on: mainQueueContext, with: "Main Queue Users count =")
        //5) logs number of users on private context
        logsUser(on: privateChildContext, with: "Private Queue Users count =")
        //6 create 996 users on private context
        privateChildContext.performAndWait {
            for i in 5...1000 {
                let user = User(context: privateChildContext)
                user.firstName = "User \(i)"
            }
        }
        //7) logs number of users on main context
        logsUser(on: mainQueueContext, with: "\n\nMain Queue Users count =")
        //8) logs number of users on private context
        logsUser(on: privateChildContext, with: "Private Queue Users count =")
        
        //9) merge changes to main context as well
        privateChildContext.performAndWait { try! privateChildContext.save() }

        //10) after merge logs dat
        logsUser(on: mainQueueContext, with: "\n\nMain Queue Users count =")
        //11) logs number of users on private context
        logsUser(on: privateChildContext, with: "Private Queue Users count =")
    }
    
    
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
    func notificationThreadingStrategy() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        let privateQueueContext = appDelegate.persistentContainer.newBackgroundContext()
        
         NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: privateQueueContext)
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")

        privateQueueContext.performAndWait {
            let usersOfPrivateContext: [User] = try! privateQueueContext.fetch(userFetchRequest)
            for user in usersOfPrivateContext {
                print("user.firstName on Private Thread = \(user.firstName ?? "Default Value")\n\n")
               
                do {
                    user.firstName = "Updated ali"
                    try privateQueueContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
            mainQueueContext.performAndWait {
                let usersOfMainContext: [User] = try! mainQueueContext.fetch(userFetchRequest)
                for user in usersOfMainContext {
    
                   print("user.firstName on Main thread after save = \(user.firstName ?? "Default Value")")
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
    
    @objc func contextDidSave(_ notification: Notification) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        mainQueueContext.performAndWait {
            mainQueueContext.mergeChanges(fromContextDidSave: notification)
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
    
    
   
   
}
