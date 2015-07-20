//
//  Product.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 20/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation

class Product {
    
    var id:NSNumber
    var name: String
    var brand: String
    var imagePath: String
    var price: String
    
    init(id: NSNumber, name: String, brand: String, price: String, imagePath: String) {
        self.id = id
        self.name = name
        self.brand = brand
        self.price = price
        self.imagePath = imagePath
    }
    
}