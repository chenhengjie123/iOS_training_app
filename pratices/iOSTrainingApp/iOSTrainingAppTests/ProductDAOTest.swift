//
//  ProductDAOTest.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 18/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation
import XCTest
import SceneKit

class ProductDAOTest: XCTestCase {
    
    var productDao: ProductDAO!
    override func setUp() {
        super.setUp()
        self.productDao = ProductDAO.sharedInstance
    }
    
    override func tearDown() {
        self.productDao = nil
        super.tearDown()
    }
    
    // test case 1: create product
    func testCreate() {
        let product: Product = Product(id: NSNumber(int: 9999), name: "testProduct", brand: "testBrand", price: "testPrice", imagePath: "testImagePath")
        let originalCount = self.productDao.findAll().count
        self.productDao.create(product)
        
        XCTAssertEqual(self.productDao.findAll().count, originalCount+1, "Create product fail. Product count did not plus 1")
        var addedProduct = self.productDao.findById(product)
        XCTAssertEqual(addedProduct!.id, product.id, "Create product fail. Product id do not match")
        XCTAssertEqual(addedProduct!.name, product.name, "Create product fail. Product name do not match")
        XCTAssertEqual(addedProduct!.brand, product.brand, "Create product fail. Product brand do not match")
        XCTAssertEqual(addedProduct!.price, product.price, "Create product fail. Product price do not match")
        XCTAssertEqual(addedProduct!.imagePath, product.imagePath, "Create product fail. Product imagePath do not match")
    }
}
