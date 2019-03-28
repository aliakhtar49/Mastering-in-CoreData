//
//  Task+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 10/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var ofUser: User?

}
