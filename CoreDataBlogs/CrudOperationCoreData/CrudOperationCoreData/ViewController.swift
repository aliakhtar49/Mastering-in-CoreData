//
//  ViewController.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 03/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Threading.init().addUser()
    Threading.init().parentChildContext()
        // Do any additional setup after loading the view, typically from a nib.
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
            
            
            //7 fetch Passport
            let fetchRequestPassport = NSFetchRequest<NSManagedObject>(entityName: "Passport")
            let passports = try? managedObjectContext.fetch(fetchRequestPassport)
            print("passports count \(String(describing: passports?.count))")
            
            
            //8 Commit to disk also
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

   
    
    
    
    func fetchTaskFromCoreDataWithObjectithEntityHavingRelationshipWithhOtherEntityOrientedWay() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            //4) Execute fetchh request
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            //5) Print Data Using Inverse relationship we can access any property
            for task in tasks {
                //6 Print Taks details
                print(task.details ?? "No Data found")
                
                //7 Print User Information by using Task objects
                print(task.ofUser?.firstName ?? "No User first Name")
                
                //7 Print User Passport Information by using Task objects
                print(task.ofUser?.passport?.number ?? "No User Passport")
                
                
            }
            
            
            //6 fetch Task
            let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "User")
            let users = try? managedObjectContext.fetch(fetchRequestUser)
            print("users count \(String(describing: users?.count))")
            
            
            //7 fetch Passport
            let fetchRequestPassport = NSFetchRequest<NSManagedObject>(entityName: "Passport")
            let passports = try? managedObjectContext.fetch(fetchRequestPassport)
            print("passports count \(String(describing: passports?.count))")
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
        todoObjectSecond.name = "First Item"
        todoObjectSecond.details = "First Item Description"
        todoObjectSecond.id = 1
        
        //5) Created a User Passport  object
        let userPassport = Passport(context: managedObjectContext)
        userPassport.expiryDate = NSDate()
        userPassport.number = "User Passport Number"
        
         //6) Created a User object
        let user = User(context: managedObjectContext)
        user.firstName = "User First Name"
        user.secondName = "User Second Name"
        user.userId = 123
       
        //7) Assign tasks to user
        user.taks = NSSet.init(array: [todoObjectOne,todoObjectSecond])
        
        //8) Assign passport to user obkects
        user.passport = userPassport
        
        //9) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func addTodoTaksWithObjectOrientedWay() {
        
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        //Create a todo list first  object
        let todoObject = Task(context: managedObjectContext)
        todoObject.name = "First Item"
        todoObject.details = "First Item Description"
        todoObject.id = 1
        
        //Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    

}

