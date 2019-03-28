//
//  User+CoreDataProperties.swift
//  TemporaryChanges
//
//  Created by Ali Akhtar on 26/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?

}
