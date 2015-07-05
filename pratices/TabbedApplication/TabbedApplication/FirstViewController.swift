//
//  FirstViewController.swift
//  TabbedApplication
//
//  Created by hengjie chen on 2/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("%@", "viewDidLoad")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("%@", "viewWillAppear:")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("%@", "viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("%@", "viewDidDisappear:")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("%@", "viewDidDisappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        NSLog("%@", "didReceiveMemoryWarning")
    }

//    not available after iOS 6
//    override func viewDidUnload() {
//        super.viewDidUnload()
//        NSLog("%@", "viewDidUnload")
//    }


}

