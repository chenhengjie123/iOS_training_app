//
//  ProductDAO.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 18/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation
import CoreData

class ProductDAO: CoreDataDAO {
    
    // singleton
    class var sharedInstance: ProductDAO {
        struct Static {
            static var instance: ProductDAO?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            
            Static.instance = ProductDAO()
            
            if (Static.instance?.findAll().count == 0) {
                // add test data
                Static.instance?.create(Product(id: NSNumber(int: 1), name: "MX4", brand: "Meizu", price: "1799", imagePath: "MX4"))
                Static.instance?.create(Product(id: NSNumber(int: 1), name: "MX3", brand: "Meizu", price: "1399", imagePath: "MX3"))
                Static.instance?.create(Product(id: NSNumber(int: 1), name: "MX2", brand: "Meizu", price: "799", imagePath: "MX2"))
            }
            
        }
        return Static.instance!
    }
    
    
    func create(model: Product) -> Int {
        
        var cxt = self.managedObjectContext!
        
        let product = NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext:cxt) as! NSManagedObject
        
        
        product.setValue(model.id, forKey: "id")
        product.setValue(model.name, forKey: "name")
        product.setValue(model.brand, forKey: "brand")
        product.setValue(model.price, forKey: "price")
        product.setValue(model.imagePath, forKey: "imagePath")
        
        var error: NSError? = nil
        if cxt.hasChanges && !cxt.save(&error) {
            NSLog("Create failed \(error), \(error!.userInfo)")
            return -1
        }
        return 0
    }
    
    func remove(model: Product) -> Int {
        
        var cxt = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "id =  %@", model.id)
        
        var error: NSError? = nil
        var listData = cxt.executeFetchRequest(fetchRequest, error: &error) as NSArray!
        
        if listData.count > 0 {
            
            var product = listData.lastObject as! NSManagedObject  //as改为as!
            
            cxt.deleteObject(product)
            
            error = nil
            if cxt.hasChanges && !cxt.save(&error) {
                NSLog("Delete failed: \(error), \(error!.userInfo)")
                return -1
            }
        }
        
        return 0
    }
    
    func modify(model: Product) -> Int {
        
        var cxt = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "id =  %@", model.id)
        
        var error: NSError? = nil
        var listData = cxt.executeFetchRequest(fetchRequest, error: &error) as NSArray!
        
        if listData.count > 0 {
            
            var product = listData.lastObject as! NSManagedObject
            
            product.setValue(model.name, forKey: "name")
            product.setValue(model.brand, forKey: "brand")
            product.setValue(model.price, forKey: "price")
            product.setValue(model.imagePath, forKey: "imagePath")
            
            if cxt.hasChanges && !cxt.save(&error) {
                NSLog("Modify failed: \(error), \(error!.userInfo)")
                return -1
            }
        }
        
        return 0
    }
    
    //查询所有数据方法
    func findAll() -> NSMutableArray {
        
        var cxt = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        var sortDescriptor = NSSortDescriptor(key:"id", ascending:true)
        var sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        var error: NSError? = nil
        var listData = cxt.executeFetchRequest(fetchRequest, error: &error) as NSArray!
        
        var resListData = NSMutableArray()
        
        for item in listData {
            
            
            var mo = item as! NSManagedObject
            
            var id = mo.valueForKey("id") as! NSNumber!
            var name = mo.valueForKey("name") as! String!
            var brand = mo.valueForKey("brand") as! String!
            var price = mo.valueForKey("price") as! String!
            var imagePath = mo.valueForKey("imagePath") as! String!
            
            
            var product = Product(id: id, name: name, brand: brand, price: price, imagePath: imagePath)
            
            resListData.addObject(product)
            
        }
        
        return resListData
    }
    
    func findById(model: Product) -> Product? {
        
        var cxt = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "id =  %@", model.id)
        
        var error: NSError? = nil
        var listData = cxt.executeFetchRequest(fetchRequest, error: &error) as NSArray!
        
        if listData.count > 0 {
            var mo = listData.lastObject as! NSManagedObject
            
            var id = mo.valueForKey("id") as! NSNumber!
            var name = mo.valueForKey("name") as! String!
            var brand = mo.valueForKey("brand") as! String!
            var price = mo.valueForKey("price") as! String!
            var imagePath = mo.valueForKey("imagePath") as! String!
            
            var product = Product(id: id, name: name, brand: brand, price: price, imagePath: imagePath)
            
            return product
        }
        
        return nil
    }
    
    func findByName(name: String) -> NSArray {
        var cxt = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Product", inManagedObjectContext: cxt)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", name)
        
        var error: NSError? = nil
        var listData = cxt.executeFetchRequest(fetchRequest, error: &error) as NSArray!
        
        var resListData = NSMutableArray()
        
        for item in listData {
            
            
            var mo = item as! NSManagedObject
            
            var id = mo.valueForKey("id") as! NSNumber!
            var name = mo.valueForKey("name") as! String!
            var brand = mo.valueForKey("brand") as! String!
            var price = mo.valueForKey("price") as! String!
            var imagePath = mo.valueForKey("imagePath") as! String!
            
            
            var product = Product(id: id, name: name, brand: brand, price: price, imagePath: imagePath)
            
            resListData.addObject(product)
            
        }
        
        return resListData
    }
    
    
    func getLatestId() -> NSNumber {
        let products = self.findAll()
        let latestProduct = products.lastObject as! Product
        NSLog("Latest product id is %@", latestProduct.id.integerValue)
        return latestProduct.id
    }

}