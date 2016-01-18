//
//  FirstViewController.swift
//  bany
//
//  Created by Lee Janghyup on 9/23/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class LoginVC: UIViewController, UITextFieldDelegate {
   
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.utf16.count < 7 || password?.utf16.count < 6) {
        }
        
        
        
        self.actInd.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookSignUp(sender: AnyObject) {
        buttonDisabeld(loginButton)
        startActivityIndicator()
        buttonDisabeld(facebookButton)
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"], block: { (user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
            //displayㄴ an alert message
                
                self.alert("error", message : (error?.localizedDescription)!)
                self.buttonEnabled(self.loginButton)
                self.buttonEnabled(self.facebookButton)
                self.stopActivityIndicator()

                
                return
            }
            
            
            if (self.autoLoginSwitch.on == true){
            NSUserDefaults.standardUserDefaults().setObject(PFUser.currentUser()?.objectId, forKey: "objectId")
            }
            
                        NSUserDefaults.standardUserDefaults().synchronize()
            
            print("Current user token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current user id = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            if(FBSDKAccessToken.currentAccessToken() != nil)
            {
                self.buttonEnabled(self.loginButton)
                self.buttonEnabled(self.facebookButton)

                //인트로페이지
                let introPage : String? = NSUserDefaults.standardUserDefaults().stringForKey("introPage")
                
                
                if(introPage == nil)
                {
                    
                    let mainStroyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let IntroVC: IntroVCViewController = mainStroyBoard.instantiateViewControllerWithIdentifier("IntroVCViewController") as! IntroVCViewController
                    
                    let welcomeNav = UINavigationController(rootViewController : IntroVC)
                    
                    let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = IntroVC
                }else{

                self.performSegueWithIdentifier("loginToMain", sender: self)
                
                    self.stopActivityIndicator()}

                //다른페이지로 확실히 이동
                //let loginNext = self.storyboard?.instantiateViewControllerWithIdentifier("LoginNextVC") as! LoginNextVC
                
                //let loginNextNav = UINavigationController(rootViewController: loginNext)
                
                //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                //appDelegate.window?.rootViewController = loginNext
            
            }
            
        })
        
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        buttonDisabeld(facebookButton)
        buttonDisabeld(loginButton)
        startActivityIndicator()
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.utf16.count < 7 || password?.utf16.count < 6) {
           
           
            self.alert("Invalid", message : "Invalid email address")
            buttonEnabled(loginButton)
            buttonEnabled(facebookButton)
            self.stopActivityIndicator()
            
            self.passwordField.text = ""
        } else {
            
            let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: Selector("handleUploadTimeout:"), userInfo: nil, repeats: false)
            
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                
                if((user) != nil) {
                     print(user)
                    self.stopActivityIndicator()
                    self.buttonEnabled(self.loginButton)
                       self.buttonEnabled(self.facebookButton)
                    
                    //인트로페이지
                    let introPage : String? = NSUserDefaults.standardUserDefaults().stringForKey("introPage")
                    
                    
                    if(introPage == nil)
                    {
                        
                        NSUserDefaults.standardUserDefaults().setObject(PFUser.currentUser()?.objectId, forKey: "objectId")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        
                        let mainStroyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let IntroVC: IntroVCViewController = mainStroyBoard.instantiateViewControllerWithIdentifier("IntroVCViewController") as! IntroVCViewController
                        
                        let welcomeNav = UINavigationController(rootViewController : IntroVC)
                        
                        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = IntroVC
                    }else{

                        NSUserDefaults.standardUserDefaults().setObject(PFUser.currentUser()?.objectId, forKey: "objectId")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        self.passwordField.text = ""
                    
                    self.performSegueWithIdentifier("loginToMain", sender: self)
                        self.alert("Success", message : "Logged In")
                    }
                    
                    
                    
                  
                    
                    
                    
                }else {
                    
                    self.alert("login failed", message : (error?.localizedDescription)!)
                    self.stopActivityIndicator()
                    self.buttonEnabled(self.facebookButton)
                    self.buttonEnabled(self.loginButton)
                    self.passwordField.text = ""
                    
                }
                
            })
            
            
        }
    
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
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        
        return true
        
    }
    
    
    @IBAction func loginUnwindToSegue (segue : UIStoryboardSegue) {
        
        
    }
    func handleUploadTimeout(aTimer: NSTimer) {
        stopActivityIndicator()
        
        let alertController = UIAlertController(title: ("Try later"), message: ("There is an Internet connection problem."), preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("Try later", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    

}

