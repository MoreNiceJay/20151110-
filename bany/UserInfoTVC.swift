//
//  LoginNextVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class UserInfoTVC: UITableViewController, MFMailComposeViewControllerDelegate{


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
            self.profileImageView.image = UIImage(named: "ic_person")
            
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
        
        if  indexPath.section == 3 && indexPath.row == 0 {
            
            let mailComposeViewContoller = configuredMailComposerViewController()
            
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewContoller, animated: true, completion: nil)
            }else {
                self.showSendMailErrorAlert()
            }
            
        }
    }
    
    func configuredMailComposerViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["morenicejay@gmail.com"])
        mailComposerVC.setSubject("Feedback")
        mailComposerVC.setMessageBody("Feedback about bany : ", isHTML: false)
        
        return mailComposerVC
        
    }
    
    func showSendMailErrorAlert() {
        let myAlert = UIAlertController(title: "Could not send email", message: "Try again later", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
            
        case MFMailComposeResultSent.rawValue :
            print("mail sent")
        case MFMailComposeResultCancelled.rawValue :
            print("canceld")
        case MFMailComposeResultSaved.rawValue :
            print("saved")
        case MFMailComposeResultFailed.rawValue :
            print("failed")
        
        default :
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
    
    


