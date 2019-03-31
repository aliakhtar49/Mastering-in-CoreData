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
    
    
   
   
  
    
    
   
   
}
