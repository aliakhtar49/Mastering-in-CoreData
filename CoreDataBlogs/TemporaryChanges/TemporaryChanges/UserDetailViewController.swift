//
//  UserDetailViewController.swift
//  TemporaryChanges
//
//  Created by Ali Akhtar on 26/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import CoreData

class UserDetailViewController: UIViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    var user: User?
    let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back(sender:)))
//        
//        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        fetchUserDetailsFromDataBase()
        lastNameTextField.text = user?.lastName
        firstNameTextField.text = user?.firstname
    }
    func fetchUserDetailsFromDataBaseWithUndoManager() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.undoManager = UndoManager()
        
        managedObjectContext.undoManager?.beginUndoGrouping()
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let users = try! managedObjectContext.fetch(fetchRequest)
        
        user = users[0]
    }
    func fetchUserDetailsFromDataBase() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let users = try! managedObjectContext.fetch(fetchRequest)
        
        user = users[0]
    }
    
    func fetchUserDetailsFromDataBaseUsingChildContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let mainQueueManagedObjectContext = appDelegate.persistentContainer.viewContext
        childContext.parent = mainQueueManagedObjectContext
        
        childContext.performAndWait {
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            
            let users = try! childContext.fetch(fetchRequest)
            
            user = users[0]
        }
        
    }
    @objc func back(sender: UIBarButtonItem) {
      
        self.navigationController?.popViewController(animated: true)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let mainQueueManagedObjectContext = appDelegate.persistentContainer.viewContext
        mainQueueManagedObjectContext.undoManager?.endUndoGrouping()
        mainQueueManagedObjectContext.undoManager?.undo()
        
    }
 
    
 
    
  
    @IBAction func saveButtonTapped(_ sender: UIButton) {
      saveButtonActionWithChildContext()
    }
    func saveButtonActionWithChildContext() {
        
        try! childContext.save()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        try! managedObjectContext.save()
    }
    
    func saveButtonActionWithMainContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        try! managedObjectContext.save()
    
    }
   
    
}



extension UserDetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == lastNameTextField {
                user?.lastName = lastNameTextField.text
        }
        else{
           user?.firstname = firstNameTextField.text
        }
    }
 
}
