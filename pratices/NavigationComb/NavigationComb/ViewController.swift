//
//  ViewController.swift
//  NavigationComb
//
//  Created by hengjie chen on 21/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var dictData: NSDictionary!
    var listData: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let plistPath = NSBundle.mainBundle().pathForResource("provinces_cities", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        let navigationController = self.parentViewController as! UINavigationController
        let selectProvinces = navigationController.tabBarItem.title!
        
        NSLog("%@", selectProvinces)
        

        self.listData = self.dictData[selectProvinces] as! NSArray
        self.navigationItem.title = selectProvinces


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

