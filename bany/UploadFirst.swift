//
//  NewUploadTitle.swift
//  bany
//
//  Created by Lee Janghyup on 10/11/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class  UploadFirst: UITableViewController {

    var reachability : Reachability?
    var internetConnection : Bool = false
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var bookSwitch: UISwitch!
    @IBOutlet weak var iclickerSwitch: UISwitch!
    @IBOutlet weak var otherSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    var category : Int = 0
   
    @IBOutlet weak var classLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopActivityIndicator()
        
        do{ let reachability = try Reachability.reachabilityForInternetConnection()
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            
        }
        catch {}
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "connectionChanged", name: ReachabilityChangedNotification, object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if reachability?.isReachable() == true
        {
            internetConnection = true
            buttonEnabled(nextButton)
            
        }else{
            
            let myAlert = UIAlertController(title: "No network", message:
                "Network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style:
                UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion:
                nil)
            internetConnection = false
            buttonDisabeld(nextButton)
        }
        
    }
    func connectionChanged() {
        
        if reachability!.isReachable() {
            
            internetConnection = true
            buttonEnabled(nextButton)

            
        }else {
            let myAlert = UIAlertController(title: "No network", message: "Network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            internetConnection = false
            buttonDisabeld(nextButton)

            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    @IBAction func bookSwitchIsOn(sender: AnyObject) {
        if (bookSwitch.on == true)
        {
            category = 1
            iclickerSwitch.on = false
            otherSwitch.on = false
            titleLabel.text = "Book title"
            titleTextField.placeholder = "Title of Your book"

            classLabel.text = "Class/author"
            titleTextField.text = ""
            tagTextField.placeholder = "ex) Acom203 / Author"
            
        }
    }
    
    @IBAction func iclickerSwitchIsOn(sender: AnyObject) {
        if (iclickerSwitch.on == true)
        {
            category = 2
            bookSwitch.on = false
            otherSwitch.on = false
            titleTextField.text = "Iclicker"
            titleTextField.placeholder  = ""
            classLabel.text = "Battery"
            tagTextField.placeholder = "ex) No battery / Yes battery"
            titleLabel.text = "Iclicker"


            
        }
    }
    
    @IBAction func otherSwitchIsOn(sender: AnyObject) {
        
        if (otherSwitch.on == true)
        {
            category = 3
            bookSwitch.on = false
            iclickerSwitch.on = false
            titleLabel.text = "Product"
            classLabel.text = "Model #"
            titleTextField.text = ""
            titleTextField.placeholder  = "Brand & Product "
            tagTextField.placeholder = "ex) A1347"
        }
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        
        startActivityIndicator()
        buttonDisabeld(nextButton)
        
        let titleText = titleTextField.text
        let tagText = tagTextField.text
        let priceText = priceTextField.text
       
        
        
        
        if(!bookSwitch.on && !iclickerSwitch.on && !otherSwitch.on){
            buttonEnabled(nextButton)
            
            stopActivityIndicator()

           
            
            self.alert("Invalid", message : "You must choose a category")
        }else{
        if titleText!.isEmpty || tagText!.isEmpty || priceText!.isEmpty{
            
            
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
            
            //유저에게 채워넣으라고 알럴트
            self.alert("Invalid", message : "You must fill in the blank")
            
            
            
        }else {
            
            if !(titleText!.utf16.count <= 45 && titleText!.utf16.count >= 2 ) {
                // 3보다 크고 16보다 작은게 아니라면
                buttonEnabled(nextButton)
                
                stopActivityIndicator()

                alert("Invalid", message : "Title must be  2 ~ 45 characters")
                
            }else{
                //ㅇㅋ
                
                if !(tagText!.utf16.count <= 40 && tagText!.utf16.count >= 2 ) {
                    
                    
                    buttonEnabled(nextButton)
                    
                    stopActivityIndicator()
                    alert("Invalid", message : "Tag must be 2 ~ 45 characters")
                
                    
                    
                    }else{
                        //굿투고

                    buttonEnabled(nextButton)
                    
                    stopActivityIndicator()

                self.performSegueWithIdentifier("uploadFirstToUploadSecond", sender: self)
           
            }
            
                
                
        }
 
            }
        }
    }

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "uploadFirstToUploadSecond") {
            
            
            let destViewController : UploadSecond = segue.destinationViewController as! UploadSecond
            destViewController.category = category
            destViewController.titleText = titleTextField.text!
            destViewController.tagText = tagTextField.text!
            destViewController.priceText = priceTextField.text!
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
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        titleTextField.resignFirstResponder()
        tagTextField.resignFirstResponder()
       priceTextField.resignFirstResponder()
        
    }
    
    
    func luxuryAlert(userMessage:String) {
        
        let myAlert = UIAlertController(title: "Success", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            
            self.performSegueWithIdentifier("uploadSuccess", sender: self)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
            func buttonEnabled(buttonName: UIButton){
                
                buttonName.enabled = true
            }
            func buttonDisabeld(buttonName: UIButton){
                
                buttonName.enabled = false
            }

    @IBAction func keyBoardDismissButton(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        
        return true
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


    
}

