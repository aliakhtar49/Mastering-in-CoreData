//
//  Passport+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 10/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension Passport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passport> {
        return NSFetchRequest<Passport>(entityName: "Passport")
    }

    @NSManaged public var expiryDate: NSDate?
    @NSManaged public var number: String?
    @NSManaged public var ofUser: User?

}
