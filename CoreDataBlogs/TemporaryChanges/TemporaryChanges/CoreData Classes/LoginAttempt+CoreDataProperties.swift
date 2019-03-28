//
//  LoginAttempt+CoreDataProperties.swift
//  TemporaryChanges
//
//  Created by Ali Akhtar on 26/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension LoginAttempt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginAttempt> {
        return NSFetchRequest<LoginAttempt>(entityName: "LoginAttempt")
    }

    @NSManaged public var count: Int64

}
