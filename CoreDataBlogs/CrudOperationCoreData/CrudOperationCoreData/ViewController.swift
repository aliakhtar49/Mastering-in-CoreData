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
    ConcurrencyNotification.init().addUser()
        ConcurrencyNotification.init().notificationThreadingStrategy()
        
    }
   
    
   
    

}

