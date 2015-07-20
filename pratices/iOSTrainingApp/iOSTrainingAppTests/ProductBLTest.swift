//
//  ProductBLTest.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 18/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import Foundation
import XCTest

class ProductBLTest: XCTestCase {
    
    var productBL: ProductBL!
    override func setUp() {
        super.setUp()
        self.productBL = ProductBL()
    }
    
    override func tearDown() {
        self.productBL = nil
        super.tearDown()
    }
    
    // test create product
    func testCreateProduct() {
        let product: Product = Product(id: NSNumber(int: 9999), name: "testProduct", brand: "testBrand", price: "testPrice", imagePath: "testImagePath")
        let productListBeforeAdd: AnyObject = self.productBL.findAll().copy()
        let productListAfterAdd = self.productBL.createProduct(product)
        
        XCTAssertEqual(productListAfterAdd.count, productListBeforeAdd.count + 1, "Added product failed. Product count did not plus 1")
        // TODO: verify added product info and id
    }
}
