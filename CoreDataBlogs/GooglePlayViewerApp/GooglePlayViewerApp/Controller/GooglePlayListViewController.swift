//
//  GooglePlayListViewController.swift
//  GooglePlayViewerApp
//
//  Created by Ali Akhtar on 25/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import CoreData

class GooglePlayListViewController: UIViewController {

    var data = [GooglePlay]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
       
    }

    func populateData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        
        let googlePlayFetchRequest = NSFetchRequest<GooglePlay>(entityName: "GooglePlay")
        
        data = try! mainQueueContext.fetch(googlePlayFetchRequest)
        
    }
}

extension GooglePlayListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
        }
        let googlePlay = data[indexPath.row]
        cell.textLabel?.text = googlePlay.app
        return cell
    }
    
    
    
}

