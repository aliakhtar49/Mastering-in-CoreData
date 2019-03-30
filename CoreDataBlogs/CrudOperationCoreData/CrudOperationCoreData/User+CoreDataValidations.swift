////
////  User+CoreDataValidations.swift
////  CrudOperationCoreData
////
////  Created by Ali Akhtar on 20/03/2019.
////  Copyright © 2019 Ali Akhtar. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//
//extension User {
//    
//    var errorDomain: String {
//        get {
//            return "UserErrorDomain"
//        }
//    }
//    
//    enum UserErrorType: Int {
//        case InvalidUserSecondName
//        case InvalidUserFirstOrSecondName
//    }
//    
//   
//    public override func validateValue(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey key: String) throws {
//        
//        if key == "secondName" {
//            var error: NSError? = nil;
//            
//            if let first = value.pointee as? String {
//                if first == "" {
//                    let errorType = UserErrorType.InvalidUserSecondName
//                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User Second name cannot be empty." ] )
//                }
//                else if first.count > 12 {
//                    let errorType = UserErrorType.InvalidUserSecondName
//                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User Second name cannot be greater than 12 character." ] )
//                }
//                
//            } else {
//                let errorType = UserErrorType.InvalidUserSecondName
//                error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User Second name cannot be nil." ] )
//            }
//            
//            if let error = error {
//                throw error
//            }
//        }
//    }
//   
// 
//    override public func validateForInsert() throws {
//        try super.validateForInsert()
//        guard let firstName = firstName else  { throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User First Or  Second name cannot be greater than 12 character." ] ) }
//        
//        guard let secondName = secondName else  { throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User First Or  Second name cannot be greater than 12 character." ] ) }
//        
//        if (firstName.count > 12 || secondName.count > 12) {
//            throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The User First Or  Second name cannot be greater than 12 character." ] )
//        }
//        
//    }
//    public override func validateForUpdate() throws {
//        try super.validateForUpdate()
//    }
//}
