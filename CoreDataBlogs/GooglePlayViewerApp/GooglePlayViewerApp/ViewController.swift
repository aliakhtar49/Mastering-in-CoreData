//
//  ViewController.swift
//  GooglePlayViewerApp
//
//  Created by Ali Akhtar on 25/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    @IBAction func exportButtonTapped(_ sender: UIBarButtonItem) {
         loadGooglePlayStoreAppsFromCSVWithConcurrency()
    }
    func logsGoogle(on context: NSManagedObjectContext, with text: String){
        
        context.performAndWait {
            let googlePlayFetchRequest = NSFetchRequest<GooglePlay>(entityName: "GooglePlay")
            
            let usersOfMainContext: [GooglePlay] = try! context.fetch(googlePlayFetchRequest)
            print("\(text) \(usersOfMainContext.count)")
        }
        
    }
    func loadGooglePlayStoreAppsFromCSVWithConcurrency() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let mainQueueContext = appDelegate.persistentContainer.viewContext
        let privateQueueContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateQueueContext.parent = mainQueueContext

        privateQueueContext.perform {
            var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
            data = self.cleanRows(file: data ?? "d")
            let csvRows = self.csv(data: data ?? "d")
            
            for i in 1 ..< (csvRows.count - 1 ) {
                let googlePlay = GooglePlay(context: privateQueueContext)
                googlePlay.app = csvRows[i][0]
                googlePlay.category = csvRows[i][1]
                googlePlay.rating = csvRows[i][2]
                googlePlay.reviews = Int64(csvRows[i][3]) ?? 123
                googlePlay.size = csvRows[i][4]
                googlePlay.type = csvRows[i][5]
                googlePlay.price = csvRows[i][6]
                googlePlay.contentRating = csvRows[i][7]
                googlePlay.genres = csvRows[i][8]
                googlePlay.currentVer = csvRows[i][9]
                googlePlay.androidVer = csvRows[i][10]
                
                //Note:Juts to increase time (date formatter should not contain in this way huge performance task)
                let end = "2017-11-12"
                let dateFormat = "yyyy-MM-dd"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                let endDate = dateFormatter.date(from: end)
                googlePlay.lastUpdated = endDate! as NSDate
            }
            let startTime = CFAbsoluteTimeGetCurrent()
            try! privateQueueContext.save()
            print("Main Thread Block Time \(CFAbsoluteTimeGetCurrent() - startTime)")
        }
    }
    func loadGooglePlayStoreAppsFromCSV() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let privateQueueContext = appDelegate.persistentContainer.newBackgroundContext()
      
        
        privateQueueContext.performAndWait{
            var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
            data = self.cleanRows(file: data ?? "d")
            let csvRows = self.csv(data: data ?? "d")
            
            for i in 1 ..< (csvRows.count - 1 ) {
                let googlePlay = GooglePlay(context: privateQueueContext)
                googlePlay.app = csvRows[i][0]
                googlePlay.category = csvRows[i][1]
                googlePlay.rating = csvRows[i][2]
                googlePlay.reviews = Int64(csvRows[i][3]) ?? 123
                googlePlay.size = csvRows[i][4]
                googlePlay.type = csvRows[i][5]
                googlePlay.price = csvRows[i][6]
                googlePlay.contentRating = csvRows[i][7]
                googlePlay.genres = csvRows[i][8]
                googlePlay.currentVer = csvRows[i][9]
                googlePlay.androidVer = csvRows[i][10]
                
                //Note:Juts to increase time (date formatter should not contain in this way huge performance task)
                let end = "2017-11-12"
                let dateFormat = "yyyy-MM-dd"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                let endDate = dateFormatter.date(from: end)
                googlePlay.lastUpdated = endDate! as NSDate
            }
            let startTime = CFAbsoluteTimeGetCurrent()
            try! privateQueueContext.save()
            print("Main Thread Block Time \(CFAbsoluteTimeGetCurrent() - startTime)")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    //Utility method
    
    
    //don't try to refactor this
  
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }

    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
}

