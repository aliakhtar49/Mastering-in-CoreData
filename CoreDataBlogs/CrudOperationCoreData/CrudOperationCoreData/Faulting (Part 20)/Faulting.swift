//
//  Faulting.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 22/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct Faulting{
    
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
    
}
