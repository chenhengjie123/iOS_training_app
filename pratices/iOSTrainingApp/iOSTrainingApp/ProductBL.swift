//
//  ProductBL.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 18/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation

class ProductBL {
    
    func createProduct(model: Product) -> NSMutableArray {
        var dao:ProductDAO = ProductDAO.sharedInstance
        
        // set id
        model.id = NSNumber(int: dao.getLatestId().integerValue + 1)
        
        dao.create(model)
        return dao.findAll()
    }
    
    func remove(model: Product) -> NSMutableArray {
        var dao:ProductDAO = ProductDAO.sharedInstance
        dao.remove(model)
        return dao.findAll()
    }
    
    func findAll() -> NSMutableArray {
        var dao:ProductDAO = ProductDAO.sharedInstance
        return dao.findAll()
    }
    
    func findByName(name: String) -> NSArray {
        var dao:ProductDAO = ProductDAO.sharedInstance
        return dao.findByName(name)
    }
    
}