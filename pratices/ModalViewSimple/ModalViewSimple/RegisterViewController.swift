//
//  RegisterViewController.swift
//  ModalViewSimple
//
//  Created by hengjie chen on 21/7/15.
//  Copyright (c) 2015 hengjie chen. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func save(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            NSLog("Clicked save button")
            
            NSNotificationCenter.defaultCenter().postNotificationName("RegisterCompletionNotification", object: nil, userInfo: NSDictionary(object: "testusername", forKey: "username") as [NSObject : AnyObject])
        })
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
            NSLog("Clicked cancel button")
        })
    }

}
