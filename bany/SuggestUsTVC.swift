//
//  SuggestUsTVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/31/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import MessageUI

class SuggestUsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var body: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (MFMailComposeViewController.canSendMail()) {
            
            let subjectText = "To Bany"
            let messageBody = body.text
            
            let toRecipients = ["morenicejay@gmail.com"]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(subjectText)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipients)
            self.presentViewController(mc, animated: true, completion: nil)
        }else{
                
                print("no email")
            }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
//    
//    @IBAction func sendEmail(sender: AnyObject) {
//        
//        if (MFMailComposeViewController.canSendMail()) {
//        
//        let subjectText = "From Albany student"
//        let messageBody = body.text
//        
//        let toRecipients = ["morenicejay@gmail.com"]
//        
//        let mc: MFMailComposeViewController = MFMailComposeViewController()
//        mc.mailComposeDelegate = self
//        mc.setSubject(subjectText)
//        mc.setMessageBody(messageBody, isHTML: false)
//        mc.setToRecipients(toRecipients)
//        self.presentViewController(mc, animated: true, completion: nil)
//            else{
//                
//                print("no email")
//            }
    
   
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
            case MFMailComposeResultCancelled.rawValue:
            NSLog("Mail Canceled")
            
        case MFMailComposeResultSaved.rawValue :
            NSLog("Mail saved")
            
        case MFMailComposeResultSent.rawValue:
            NSLog("mail sent")
        case MFMailComposeResultFailed.rawValue:
            
            NSLog("Mail Sent Failure")
            
        default: break
        }
        
        
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
