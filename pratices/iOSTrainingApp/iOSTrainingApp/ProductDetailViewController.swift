//
//  ProductDetailViewController.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 21/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCount: UITextField!
    
    var bl = ProductBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let productListController = self.parentViewController as! UITableViewController
//        let selectedProductId = UITableViewController
        let products = bl.findAll()
        let product = products.lastObject as! Product
        
        let imagePath = NSString(format: "%@.jpg", product.imagePath)
        self.productImage.image = UIImage(named: imagePath as String)
        self.productDescription.text = NSString(format: "%@", product.brand) as! String
        self.productPrice.text = NSString(format: "￥ %@", product.price) as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            NSLog("%@","Clicked back button in product detail view")
        })
    }

}
