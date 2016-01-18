//
//  IntroVCViewController.swift
//  bany
//
//  Created by Lee Janghyup on 1/15/16.
//  Copyright © 2016 jay. All rights reserved.
//

import UIKit
import Parse

class IntroVCViewController: UIViewController {

    @IBOutlet weak var gotItButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         NSUserDefaults.standardUserDefaults().setObject(PFUser.currentUser()?.objectId, forKey: "introPage")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gotItButton.resignFirstResponder()
                
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
