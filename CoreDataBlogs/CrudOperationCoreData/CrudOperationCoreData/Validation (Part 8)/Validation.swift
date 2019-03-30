//
//  Validation.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 19/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct Validation {
    
    func addUserRegex() {
        func addUserExceedMaxCount() {
            
            //1) get reference to app delegate singleton instance
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //2) We need context from container Entity needs context to create objects
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            
            //2) Created a User object
            let user = User(context: managedObjectContext)
            user.secondName = "Text Contain More Than 12 characters"
            
            
            //7) Save to persitsent store
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        

        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
                let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
                do {
                    //4) Execute fetchh request
                    let users = try managedObjectContext.fetch(fetchRequest)
        
                    //5) delete User object
                    print("Users count \(users.count)")
                }
                catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                }
      
            
        
        //2) Created a User object
        let user = User(context: managedObjectContext)
        user.firstName = "Abc"
        user.userId = 123
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func addUser() {
        
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //2) Created a User object
        let user = User(context: managedObjectContext)
        user.secondName = "Use"
        
        print("User First Name \(String(describing: user.firstName))")
        user.userId = 123
        user.firstName = "first name exceed 12 charcters likmit"
        
       
        //7) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addThreeTodoTaks() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) Created a first todo  object
        let todoObjectOne = Task(context: managedObjectContext)
        todoObjectOne.name = "First Item"
        todoObjectOne.details = "First Item Description"
        todoObjectOne.id = 1
        
        //4) Created a second todo  object
        let todoObjectSecond = Task(context: managedObjectContext)
        todoObjectSecond.name = "Seond Item"
        todoObjectSecond.details = "Seond Item Description"
        todoObjectSecond.id = 2
        
        //5) Created a second todo  object
        let todoObjectThird = Task(context: managedObjectContext)
        todoObjectThird.name = "Third Item"
        todoObjectThird.details = "Third Item Description"
        todoObjectThird.id = 3
        
        
        //5) Created a User object
        let user = User(context: managedObjectContext)
        user.firstName = "First"
        user.secondName = "User Second Name"
        user.userId = 123
        
        //6) Assign tasks to user
        user.taks = NSSet.init(array: [todoObjectOne,todoObjectSecond,todoObjectThird])
        
        //7) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
//    func printUserFirstName() {
//
//        //1) get reference to app delegate singleton instance
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        //2) We need context from container Entity needs context to create objects
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<User>(entityName: "User")
//
//        do {
//            //4) Execute fetchh request
//            let users = try managedObjectContext.fetch(fetchRequest)
//
//            //5) delete User object
//            for user in users {
//                print("User first Name \()")
//            }
//
//        }
//        catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
}
