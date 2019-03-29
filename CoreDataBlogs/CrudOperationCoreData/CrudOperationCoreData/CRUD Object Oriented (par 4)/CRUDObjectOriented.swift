//
//  CRUDObjectOriented.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 28/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CRUDObjectOriented {
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
    func deleteTaskFromCoreDataWithObjectOrientedWay() {
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
            for task in tasks {
               managedObjectContext.delete(task)
            }
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
            
            
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
}
