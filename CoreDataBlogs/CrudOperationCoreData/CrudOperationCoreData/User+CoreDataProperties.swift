//
//  User+CoreDataProperties.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 13/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var secondName: String?
    @NSManaged public var userId: Int64
    @NSManaged public var passport: Passport?
    @NSManaged public var taks: NSSet?

}

// MARK: Generated accessors for taks
extension User {

    @objc(addTaksObject:)
    @NSManaged public func addToTaks(_ value: Task)

    @objc(removeTaksObject:)
    @NSManaged public func removeFromTaks(_ value: Task)

    @objc(addTaks:)
    @NSManaged public func addToTaks(_ values: NSSet)

    @objc(removeTaks:)
    @NSManaged public func removeFromTaks(_ values: NSSet)

}


