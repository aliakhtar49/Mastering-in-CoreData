//
//  UndoManager.swift
//  TemporaryChanges
//
//  Created by Ali Akhtar on 27/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct UndoManagerCoredata {
    
    
    func nestedUndoGroup() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.undoManager = UndoManager()
        
        managedObjectContext.undoManager?.beginUndoGrouping()
        let user1 = User(context: managedObjectContext)
        user1.firstname = "user1"
        managedObjectContext.undoManager?.endUndoGrouping()
        
        managedObjectContext.undoManager?.beginUndoGrouping()
        let user2 = User(context: managedObjectContext)
        user2.firstname = "user2"
        managedObjectContext.undoManager?.endUndoGrouping()
        
         logsUser(on: managedObjectContext, with: "Before undo last group first name=");  print("\n")
        managedObjectContext.undoManager?.undoNestedGroup()
        
        logsUser(on: managedObjectContext, with: "First undo nested goup first name=");  print("\n")
        managedObjectContext.undoManager?.undoNestedGroup()
        
        logsUser(on: managedObjectContext, with: "Second undo Nested first name=");  print("\n")

    }
    
    
    func logsUser(on context: NSManagedObjectContext, with text: String){
        
        context.performAndWait {
            let userFetchRequest = NSFetchRequest<User>(entityName: "User")
            
            let users: [User] = try! context.fetch(userFetchRequest)
            
            for user in users {
                print("\(text) \(String(describing: user.firstname ?? "Default value" ))")
            }
        }
        
    }
    func logsUserFirstAndUserReference(on context: NSManagedObjectContext, with text: String){
        
        context.performAndWait {
            let userFetchRequest = NSFetchRequest<User>(entityName: "User")
            
            let starTime = CFAbsoluteTimeGetCurrent()
            let users: [User] = try! context.fetch(userFetchRequest)
            print(CFAbsoluteTimeGetCurrent() - starTime)
            
            for user in users {
                
                print("User reference=\(user)  \(text) \(String(describing: user.firstname ?? "Default value" ))")
            }
        }
        
    }
    
    func addUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        let user = User(context: mainQueueContext)
        user.firstname = "User1"
        
        //7) Save to persitsent store
        do {
            try mainQueueContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func simpleContextRollback(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let user1 = User(context: managedObjectContext)
        user1.firstname = "user2"
        let user2 = User(context: managedObjectContext)
        user2.firstname = "user3"
        
        logsUser(on: managedObjectContext, with: "Before Reset User first Name =");  print("\n")
        managedObjectContext.reset()
        logsUser(on: managedObjectContext, with: "After Reset User first Name =");  print("\n")
        
    }
    func simpleContextReset(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let user = User(context: managedObjectContext)
        user.firstname = "User1"
        print("User referenced \(user)")
        try! managedObjectContext.save()
        
        
        let user1 = User(context: managedObjectContext)
        user1.firstname = "user2"
        let user2 = User(context: managedObjectContext)
        user2.firstname = "user3"
        
        managedObjectContext.reset()
        
        let usersAll: [User] = try! managedObjectContext.fetch(userFetchRequest)
        
        print("User referenced \(usersAll[0])")
    }
    
    
    func simpleUndoManager(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        managedObjectContext.undoManager = UndoManager()
        
        managedObjectContext.undoManager?.beginUndoGrouping()
        
        let user1 = User(context: managedObjectContext)
        user1.firstname = "user1"
        let user2 = User(context: managedObjectContext)
        user2.firstname = "user2"
        
        managedObjectContext.undoManager?.endUndoGrouping()
        logsUser(on: managedObjectContext, with: "Before undo User first name=");  print("\n")
        
        managedObjectContext.undoManager?.undo()
        logsUser(on: managedObjectContext, with: "After undo User first name=");  print("\n")
        
        managedObjectContext.undoManager?.redo()
        logsUser(on: managedObjectContext, with: "After redo User first name=")
        
    }
}
