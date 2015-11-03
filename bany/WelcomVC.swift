//
//  WelcomVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/4/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class WelcomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("objectId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackground()
        
        performSegueWithIdentifier("welcomeToLogOut", sender: self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    } */
@IBAction func welcomeUnwindToSegue (segue : UIStoryboardSegue) {

    

}
}
