//
//  ViewController.swift
//  iOSTrainingApp
//
//  Created by hengjie chen on 6/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var listProducts : NSArray!
    var listFilterProducts : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.searchBar.delegate = self
        
        self.searchBar.showsScopeBar = false
        self.searchBar.sizeToFit()
        
        let plistPath = NSBundle.mainBundle().pathForResource("Products", ofType: "plist")
        self.listProducts = NSArray(contentsOfFile: plistPath!)
        
        self.filterContentForSearchText("")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFilterProducts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ProductCellIdentifier"
        
        var cell:ProductCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ProductCell
//        if (cell == nil){
//            cell = ProductCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
//        }
        
        let row = indexPath.row
        let rowDict = self.listFilterProducts[row] as! NSDictionary
        
        cell.productBrand.text = rowDict["brand"] as? String
        cell.productName.text = rowDict["name"] as? String
        let price = NSString(format: "￥ %@", rowDict["price"] as! String)
        cell.productPrice.text =  price as String
        
        let imagePath = NSString(format: "%@.jpg", rowDict["image"] as! String)
        cell.productImage.image = UIImage(named: imagePath as String)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    // UISearchBarDelegate
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.searchBar.sizeToFit()
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.sizeToFit()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.filterContentForSearchText("")
        self.searchBar.resignFirstResponder()
        self.searchBar.sizeToFit()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText)
        self.tableView.reloadData()
    }

    func filterContentForSearchText(searchText: NSString){
        if(searchText.length == 0){
            self.listFilterProducts = NSMutableArray(array:self.listProducts)
            return
        }
        
        var tempArray : NSArray!
        
        let namePredicate = NSPredicate(format:"SELF.name contains[c] %@", searchText)
        tempArray = self.listProducts.filteredArrayUsingPredicate(namePredicate)
        self.listFilterProducts = NSMutableArray(array: tempArray)
    }

}

