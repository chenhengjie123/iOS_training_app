//
//  ProductManagedObject.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 20/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation
import CoreData

@objc(ProductManagedObject)
class ProductManagedObject: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var brand: String
    @NSManaged var imagePath: String
    @NSManaged var price: String

}
