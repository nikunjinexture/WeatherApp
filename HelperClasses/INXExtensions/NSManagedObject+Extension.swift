//
//  NSManagedObject+Extension.swift
//  Pods
//
//  Created by test on 12/28/17.
//  Copyright © 2018 Helapay. All rights reserved.
//

import Foundation
import CoreData


// MARK: - NSManagedObject Extension -
extension NSManagedObject{
    
    // Class method that transforms NSObjects from Dictionaries into NSManagedObjects. the method creates an NSObject which is then populated
    class func createNewObject<T:NSManagedObject>(_ context: NSManagedObjectContext)-> T {
        let name = self.classForCoder().description().pathExtension!
        let newObject =  NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! T
        return newObject
    }
}
