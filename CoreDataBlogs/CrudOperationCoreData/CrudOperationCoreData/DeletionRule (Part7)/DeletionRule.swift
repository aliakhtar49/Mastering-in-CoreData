//
//  DeletionRule.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 17/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct DeletionRule {
    
    func deleteUserWithObjectithEntityHavingRelationshipWithhOtherEntity() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            //4) Execute fetchh request
            let users = try managedObjectContext.fetch(fetchRequest)
            
            //5) delete User object
            for user in users {
               managedObjectContext.delete(user)
            }
            
            //6 fetch Task
            let fetchRequestTask = NSFetchRequest<Task>(entityName: "Task")
            let tasks = try! managedObjectContext.fetch(fetchRequestTask)
            for task in tasks {
                print("Task having user \(String(describing: task.ofUser?.firstName))")
            }
            
            //6 fetch Task
            let fetchRequestUser = NSFetchRequest<User>(entityName: "User")
            let usersAfterDelete = try? managedObjectContext.fetch(fetchRequestUser)
            print("usersAfterDelete count \(String(describing: usersAfterDelete?.count))")
            
            
            //7 Commit to disk also
            do {
                try managedObjectContext.save() // <- remember to put this :)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addTodoTaksWithEntityHavingRelationshipWithhOtherEntityObjectOrientedWay() {
        
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
        todoObjectSecond.id = 1

        
        //5) Created a User object
        let user = User(context: managedObjectContext)
        user.firstName = "User First Name"
        user.secondName = "User Second Name"
        user.userId = 123
        
        //6) Assign tasks to user
        user.taks = NSSet.init(array: [todoObjectOne,todoObjectSecond])
        
        //7) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func addOneTodoTaksWithEntityHavingRelationshipWithhOtherEntityObjectOrientedWay() {
        
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        //3) Created a first todo  object
        let todoObjectOne = Task(context: managedObjectContext)
        todoObjectOne.name = "First Item"
        todoObjectOne.details = "First Item Description"
        todoObjectOne.id = 1
        
        
        
        //4) Created a User object
        let user = User(context: managedObjectContext)
        user.firstName = "User First Name"
        user.secondName = "User Second Name"
        user.userId = 123
        
        //5) Assign tasks to user
        user.taks = NSSet.init(array: [todoObjectOne])
        
        //6) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func deleteTaskFirstFromCoreDataThenUserWithObjectithEntityHavingRelationshipWithhOtherEntity() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            //4) Execute fetchh request
            let users = try managedObjectContext.fetch(fetchRequest)
            
            //5) delete User object
            for user in users {
                for task in user.taks! {
                    managedObjectContext.delete(task as! NSManagedObject)
                }
                managedObjectContext.delete(user)
            }
            
            //6 fetch Task
            let fetchRequestTask = NSFetchRequest<NSManagedObject>(entityName: "Task")
            let tasks = try? managedObjectContext.fetch(fetchRequestTask)
            print("task count \(String(describing: tasks?.count))")
            
            //6 fetch Task
            let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "User")
            let usersAfterDelete = try? managedObjectContext.fetch(fetchRequestUser)
            print("usersAfterDelete count \(String(describing: usersAfterDelete?.count))")
            
            
            //7 Commit to disk also
            do {
                try managedObjectContext.save() // <- remember to put this :)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func fetchUserFromCoreDataWithObjectOrientedWay() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            //4) Execute fetchh request
            let users = try managedObjectContext.fetch(fetchRequest)
            
            //5) Print Data
            for user in users {
                print(user.firstName ?? "No Data found")
            }
            
        }
            
            
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchTaskFromCoreDataWithObjectOrientedWay() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            //4) Execute fetchh request
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            //5) Print Data
            for data in tasks {
                print(data.details ?? "No Data found")
            }
            
        }
            
            
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteTaskOnly() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            //4) Execute fetchh request
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            //5) delete User object
            for task in tasks {
                managedObjectContext.delete(task)
            }
            
            //6 Commit to disk also
            do {
                try managedObjectContext.save() // <- remember to put this :)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteTaskFromCoreDataWithObjectithEntityHavingRelationshipWithhOtherEntity() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            //4) Execute fetchh request
            let users = try managedObjectContext.fetch(fetchRequest)
            
            //5) delete User object
            for user in users {
                managedObjectContext.delete(user)
            }
            
            //6 fetch Task
            let fetchRequestTask = NSFetchRequest<NSManagedObject>(entityName: "Task")
            let tasks = try? managedObjectContext.fetch(fetchRequestTask)
            print("task count \(String(describing: tasks?.count))")
            
            //6 fetch Task
            let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "User")
            let usersAfterDelete = try? managedObjectContext.fetch(fetchRequestUser)
            print("usersAfterDelete count \(String(describing: usersAfterDelete?.count))")
            
        
            //7 Commit to disk also
            do {
                try managedObjectContext.save() // <- remember to put this :)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
