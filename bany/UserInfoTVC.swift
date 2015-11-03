//
//  LoginNextVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UserInfoTVC: UITableViewController {


    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            //닉네임
        if let nickname = (PFUser.currentUser()?.objectForKey("nickName") as? String){
            self.nickNameLabel.text = nickname
            
            
        }else{
           self.nickNameLabel.text =   PFUser.currentUser()?.objectForKey("username") as? String
        }
        
        
        
        
        //profile Pic
        if let profilePictureObject = (PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile){
            
            
            
            profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                
                
                if(imageData != nil)
                    
                {
                    
                    self.profileImageView.image = UIImage(data: imageData!)
                }        }
        }else{
            self.profileImageView.image = UIImage(named: "AvatarPlaceholder")
            
        }
        
        
        self.circularImage(profileImageView)
        
          }

    
    

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
   {
    return true
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("objectId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackground()
        
    performSegueWithIdentifier("logoutToLogin", sender: self)
        
        
            
            
            
            
            //유저에게 메세지 보내기
            
           // var myAlert = UIAlertController(title: "Logged out", message: "Logged out", preferredStyle: UIAlertControllerStyle.Alert)
            
           // let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
           // myAlert.addAction(okAction)
            
           // self.presentViewController(myAlert, animated: true, completion: nil)
      
    }

    
       func circularImage(image : UIImageView){
    image.layer.cornerRadius = image.frame.size.width / 2
    image.clipsToBounds = true
    image.layer.borderColor = UIColor.whiteColor().CGColor
    image.layer.borderWidth = 3
    }
    @IBAction func userInfoUnwindToSegue (segue : UIStoryboardSegue) {
        
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    

  }
