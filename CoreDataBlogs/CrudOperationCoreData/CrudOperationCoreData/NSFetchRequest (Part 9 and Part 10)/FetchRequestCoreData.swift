//
//  FetchRequestCoreData.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 20/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct FetchRequestCoreData {
    
    
    func fetchUsingBatchWithLimitAndOffset() {
      
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        var fetchOffset = 0
        userFetchRequest.fetchOffset = fetchOffset
        userFetchRequest.fetchLimit = 1000
        do {
            //4) Execute fetch request
    
            var users: [User] = try managedObjectContext.fetch(userFetchRequest)
            //5 print
            print("Users count \(users.count)")
            
            while users.count > 0 {
                fetchOffset = fetchOffset + users.count
                userFetchRequest.fetchOffset = fetchOffset
                users = try managedObjectContext.fetch(userFetchRequest)
                //5 print
                print("Users count \(users.count)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchUsingBatchSize() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        userFetchRequest.returnsObjectsAsFaults = false
        
        userFetchRequest.fetchBatchSize = 1000;
        
        do {
            //4) Execute fetch request
            let startTime = CFAbsoluteTimeGetCurrent()
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
             print("fething ten thousands of objects time \(CFAbsoluteTimeGetCurrent() - startTime)")
            
            //5 print
           //  print("Users count \(users.count)")
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func insertTenThousandsUserObject(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        
        for i in 0..<10000 {
           
            //2) Created a User object
            let user = User(context: managedObjectContext)
            user.secondName = "Scond Name \(i)"
            user.userId = Int64(i)
            user.firstName = "First Name \(i)"
        }
        
        
        //3) Save to persitsent store
        do {
            let startTime = CFAbsoluteTimeGetCurrent()
            try managedObjectContext.save()
            print("Saving ten thousands of objects time \(CFAbsoluteTimeGetCurrent() - startTime)")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchLimit() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        userFetchRequest.fetchLimit = 1;
        userFetchRequest.returnsObjectsAsFaults = false
        
        do {
            //4) Execute fetch request
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for user in users {
                
                print("Object return \(user)")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func propertiesToFetchRelationship() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<NSDictionary>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.propertiesToFetch = ["taks"]
        userFetchRequest.resultType = .dictionaryResultType
        
        do {
            //4) Execute fetch request
            let users: [NSDictionary] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for user in users {
                
                print("Object return \(user)")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func propertiesToFetch() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<NSDictionary>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.propertiesToFetch = ["firstName"]
        userFetchRequest.resultType = .dictionaryResultType
        
        do {
            //4) Execute fetch request
            let users: [NSDictionary] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for user in users {
                
                print("Object return \(user)")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func propertiesToFetchWithManagedObjectResultType() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.propertiesToFetch = ["firstName"]
        userFetchRequest.resultType = .managedObjectResultType
        
        do {
            //4) Execute fetch request
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
                print("Object return Faulty \(users[0])\n\n")
                print("Partial return Faulty \(users[0].firstName!)\n\n")
                print("Still Fault is not Fired  \(users[0])\n\n")
                print("Firing fault \(users[0].secondName!)\n\n")
                print("Fault is Fired  \(users[0])\n\n")
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetcRequestResultObjectId() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<NSManagedObjectID>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.resultType = .managedObjectIDResultType
        
        do {
            //4) Execute fetch request
            let objectIds: [NSManagedObjectID] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for objectId in objectIds {
                print(objectId)
                print("\n\n\n")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetcRequestResultCount() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<NSNumber>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.resultType = .countResultType
        
        do {
            //4) Execute fetch request
            let counts: [NSNumber] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for count in counts {
                print(count)
                print("\n\n\n")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetcRequestResultTypeDictionary() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<NSDictionary>(entityName: "User")
        
        //4 Define result type
        userFetchRequest.resultType = .dictionaryResultType
        
        do {
            //4) Execute fetch request
            let users: [NSDictionary] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for user in users {
                print("User First name \(String(describing: user["firstName"] ?? "Default Value"))")
                print("User Second name \(String(describing: user["secondName"] ?? "Default Value"))")
                print("\n\n\n")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetcRequestFaultObjects() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //1) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //2 returnsObjectsAsFaults = true to get objects as faulty by default it's vvalue is also true
        userFetchRequest.returnsObjectsAsFaults = true
        
        do {
            //3) Execute fetch request
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            print("Printing fault data")
            
            //4 print before fault fired
            for user in users { print("Object return \(user)") }
            
            //5 access any one property to fire fault
            for user in users  { _ = user.firstName }
            print("\n\n\n\n\n Printing After Fired fault ")
            
            //6 print after fault fired
            for user in users { print("Object return \(user)") }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetcRequestResultTypeMangedObject() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")

        //4 Define result type
        userFetchRequest.resultType = .managedObjectResultType

        do {
            //4) Execute fetch request
            let users: [User] = try managedObjectContext.fetch(userFetchRequest)
            
            //5 print
            for user in users {
                let firstName = user.firstName
                print("Object return \(user)")
            }
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func fetchUserFromCoreData() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        do {
            //4) Execute fetchh request
            let users = try managedObjectContext.fetch(userFetchRequest)
            
            //5 Print Users count
            print("Users Count \(users.count)")
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchUserFromCoreDataWithSortDescriptor() {
        //1) Reference to context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //2) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
     
        //3) add two sort descriptors
        let sortByFirstName = NSSortDescriptor.init(key: "firstName", ascending: true)
        let sortBySecondName = NSSortDescriptor.init(key: "secondName", ascending: true)
        
        
        //4) filter using this predicate
        userFetchRequest.sortDescriptors = [sortByFirstName,sortBySecondName]
        
        do {
            //5) Execute fetchh request
            let users = try managedObjectContext.fetch(userFetchRequest)
            
            //6 Print Users count
            for user in users {
                print("User First Name \(String(describing: user.firstName ?? "Default value"))"  )
                print("User Second Name \(String(describing: user.secondName ?? "Default value"))")
                print("\n\n\n")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func fetchUserFromCoreDataWithPredicate() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //4) filter using this predicate
        userFetchRequest.predicate = NSPredicate(format: "firstName == %@", "ali")
        
        do {
            //5) Execute fetchh request
            let users = try managedObjectContext.fetch(userFetchRequest)
            
            //6 Print Users count
            print("Users Count \(users.count)")
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func addTwoUsers() {
        
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //2) Created a User object
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
    
    func addThreeUsers() {
        
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //2) Created a User object
        let user = User(context: managedObjectContext)
        user.secondName = "Vijay"
        user.firstName = "Kumar"
        
        //2) Created a User object
        let secondUser = User(context: managedObjectContext)
        secondUser.secondName = "Subhan"
        secondUser.firstName = "Ali"
        
        //3) Created a User object
        let thirdUser = User(context: managedObjectContext)
        thirdUser.secondName = "Akhtar"
        thirdUser.firstName = "Ali"
        
        //7) Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
