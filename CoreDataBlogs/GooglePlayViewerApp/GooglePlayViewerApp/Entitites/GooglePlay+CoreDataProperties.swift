//
//  GooglePlay+CoreDataProperties.swift
//  GooglePlayViewerApp
//
//  Created by Ali Akhtar on 25/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//
//

import Foundation
import CoreData


extension GooglePlay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GooglePlay> {
        return NSFetchRequest<GooglePlay>(entityName: "GooglePlay")
    }

    @NSManaged public var app: String?
    @NSManaged public var category: String?
    @NSManaged public var rating: String?
    @NSManaged public var reviews: Int64
    @NSManaged public var size: String?
    @NSManaged public var installs: String?
    @NSManaged public var type: String?
    @NSManaged public var price: String?
    @NSManaged public var contentRating: String?
    @NSManaged public var androidVer: String?
    @NSManaged public var genres: String?
    @NSManaged public var lastUpdated: NSDate?
    @NSManaged public var currentVer: String?

}
