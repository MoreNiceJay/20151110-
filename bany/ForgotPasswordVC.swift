//
//  PasswordFindVC.swift
//  bany
//
//  Created by Lee Janghyup on 9/27/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        actInd.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        startActivityIndicator()
        buttonDisabeld(sendButton)
        
        let emailAddress = emailTextField.text
        
        
        if (emailAddress!.isEmpty)
        {
            self.alert("Error", message : "Email address is not valid" )
            self.stopActivityIndicator()
            self.buttonEnabled(self.sendButton)
            
            return
            
        }
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress!, block: { (success, error) -> Void in
            if(error != nil)
                
            {//노굿
                
                self.alert("Error", message : (error!.localizedDescription))
                self.stopActivityIndicator()
                self.buttonEnabled(self.sendButton)
                
                
            }else {
                //success
                self.alert("Success", message : "message was sent to \(emailAddress)")
                self.stopActivityIndicator()
                self.buttonEnabled(self.sendButton)
                
            }
            
        })
    }

    func startActivityIndicator() {
        self.actInd.hidden = false
        self.actInd.startAnimating()
        
    }
    
    func stopActivityIndicator() {
        self.actInd.hidden = true
        self.actInd.stopAnimating()
    }
    
    func buttonEnabled(buttonName: UIButton){
        
        buttonName.enabled = true
    }
    func buttonDisabeld(buttonName: UIButton){
        
        buttonName.enabled = false
    }
    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailTextField.resignFirstResponder()
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        
        return true
        
    }

    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}
