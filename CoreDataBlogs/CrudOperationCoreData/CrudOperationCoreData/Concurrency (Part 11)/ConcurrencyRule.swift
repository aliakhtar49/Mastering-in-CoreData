//
//  ConcurrencyRule.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 30/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct ConcurrencyRule {
    func addTwoUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        DispatchQueue.global(qos: .background).async {
            
            print("Background Thread")
            print("Executing Background Thread")
            
            
            print("\(Thread.current)\n\n")
            
            //2) Created a User object
            managedObjectContext.perform {
                
                
                print("\(Thread.current)")
                print("Switch Main Thread")
                
                
                let user = User(context: managedObjectContext)
                user.secondName = "User One Seond name"
                user.firstName = "ali"
                
                //2) Created a User object
                let secondUser = User(context: managedObjectContext)
                secondUser.secondName = "User Second Seond name"
                secondUser.firstName = "Not ali"
                
                //7) Save to persitsent store
                do {
                    try managedObjectContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            }
        }
        
    }
    func addTwoUsersWithoutPerformBlock() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        DispatchQueue.global(qos: .background).async {
            
            print("Background Thread")
            print("Executing Background Thread")
            
            
            print("\(Thread.current)\n\n")
            
                
                
                print("\(Thread.current)")
                print("Switch Main Thread")
                
                
                let user = User(context: managedObjectContext)
                user.secondName = "User One Seond name"
                user.firstName = "ali"
                
                //2) Created a User object
                let secondUser = User(context: managedObjectContext)
                secondUser.secondName = "User Second Seond name"
                secondUser.firstName = "Not ali"
                
                //7) Save to persitsent store
                do {
                    try managedObjectContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            
        }
        
    }
    func mangedObjectAccessOnDifferentContext() {
        
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        let privateQueueContext = appDelegate.persistentContainer.newBackgroundContext()
        
        //2) Created a User object
        
        let user = User(context: mainQueueContext)
        user.secondName = "User One Seond name"
        user.firstName = "ali"
        
        
        //2) Created a User object
        let task = Task(context: privateQueueContext)
        task.name = "Task Name"
        
        user.taks = [task]
        
        //7) Save to persitsent store
        do {
            try mainQueueContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
