//
//  ViewController.swift
//  TemporaryChanges
//
//  Created by Ali Akhtar on 26/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UndoManagerCoredata.init().simpleContextRollback()
        initializeUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserDetailsFromDataBase()
        setUpUI()
    }
    
    func initializeUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let users = try! managedObjectContext.fetch(fetchRequest)
        
        if users.count == 0 {
            
            let newUser = User(context: managedObjectContext)
            newUser.firstname = "Ali"
            newUser.lastName = "Akhtar"
            newUser.id = 1
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
  
  
    
    func setUpUI(){
        userLabel.text = user?.firstname
    }
    
    func fetchUserDetailsFromDataBase() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let users = try! managedObjectContext.fetch(fetchRequest)
        
        user = users[0]
    }
    


    @IBAction func detailsButtonTapped(_ sender: UIButton) {
       incrementLoginAttempt()
    }
    func incrementLoginAttempt() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<LoginAttempt>(entityName: "LoginAttempt")
        let loginAttempts = try! managedObjectContext.fetch(fetchRequest)
        
        if loginAttempts.count == 0 {
            let login = LoginAttempt(context: managedObjectContext)
            login.count = 1
        }else {
            let loginAttemptObject = loginAttempts[0]
            loginAttemptObject.count = loginAttemptObject.count + 1
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

