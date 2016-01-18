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
    @IBOutlet weak var otherSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var attendanceTextField: UITextField!
    
    @IBOutlet weak var hardnessLabel: UILabel!
    
    @IBOutlet weak var hardnessTextFeld: UITextField!
    @IBOutlet weak var assignmentLabel: UILabel!
    
    @IBOutlet weak var assignmentTextField: UITextField!
    
    @IBOutlet weak var YesRQDLabel: UILabel!
    @IBOutlet weak var notRQDLabel: UILabel!
    @IBOutlet weak var bookRQDSwitch: UISwitch!
    @IBOutlet weak var aboutClassLabel: UILabel!
    @IBOutlet weak var bookRQDLabel: UILabel!
    @IBOutlet weak var aboutClassTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    var category : Int = 0
    var RQD : String = "yes"
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
            category = 0
            otherSwitch.on = false
           
            titleLabel.text = "Book title"
            titleTextField.placeholder = "Title of Your book"
            
            classLabel.text = "Class"
            tagTextField.placeholder = "ex) Acom203 "
            
            
            attendanceLabel.text = "Attendence"
            attendanceTextField.placeholder = "5 (Everyday) to 0(Never)"
            
            hardnessLabel.text = "Hardness"
            hardnessTextFeld.placeholder = "5 (Hard) to 0 (Easy)"
            
            assignmentLabel.text = "Assignement"
            assignmentTextField.placeholder = "5 (Lots) to 0 (None)"
            
            bookRQDLabel.text = "Book RQD"
            notRQDLabel.text = "Not Required"
            YesRQDLabel.text = "Required"
            
            aboutClassLabel.text = "More"
            aboutClassTextField.placeholder = "Someting more to say about this class?"
            
        }
    }
    
    @IBAction func otherSwitchIsOn(sender: AnyObject) {
        if (otherSwitch.on == true)
        {
            category = 1
            bookSwitch.on = false
            
            titleLabel.text = "Product"
            titleTextField.placeholder  = "Brand & Product. ex) Apple MacBook13"

            classLabel.text = "Model#"
            tagTextField.placeholder = "ex) MD212"
            
            
            
            
            
            attendanceLabel.text = "Condition"
            attendanceTextField.placeholder = "5 (Everyday) to 0(Never)"
            
            hardnessLabel.text = "Purchased Year"
            hardnessTextFeld.placeholder = "Ex) 2014"
            
            assignmentLabel.text = "Original price"
            assignmentTextField.placeholder = "$"
            
            bookRQDLabel.text = "New"
            notRQDLabel.text = "Used"
            YesRQDLabel.text = "New"
            
            aboutClassLabel.text = "More"
            aboutClassTextField.placeholder = "Someting more to say about this product?"
            

            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        
        startActivityIndicator()
        buttonDisabeld(nextButton)
        
        if bookRQDSwitch.on == true {
            RQD = "Yes"
        }else{
            RQD = "No"
        }
        
        let titleText = titleTextField.text
        let tagText = tagTextField.text
        let priceText = priceTextField.text
        
        
        let attendenceText = attendanceTextField.text
        let hardnessText = hardnessTextFeld.text
        let assignmentText = assignmentTextField.text
        let moreText = aboutClassTextField.text
        
        
        
        if(!bookSwitch.on && !otherSwitch.on ){
            buttonEnabled(nextButton)
            
            stopActivityIndicator()

           
            
            self.alert("Invalid", message : "You must choose a category")
        }else{
        if titleText!.isEmpty || tagText!.isEmpty || priceText!.isEmpty || attendenceText!.isEmpty || hardnessText!.isEmpty || assignmentText!.isEmpty {
            
            
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
            
            //유저에게 채워넣으라고 알럴트
            self.alert("Invalid", message : "You must fill in the blank")
            
            
            
        }else {
            
            if  !(moreText!.utf16.count <= 30  ) {
                // 3보다 크고 16보다 작은게 아니라면
                buttonEnabled(nextButton)
                
                stopActivityIndicator()
                
                alert("Invalid", message : "\("More") must be  less than 30 characters")
            }else if moreText!.isEmpty {
            
                
                aboutClassTextField.text = ""
            }
            
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
            destViewController.attendence = attendanceTextField.text!
            destViewController.hardness  = hardnessTextFeld.text!
            destViewController.assignment  = assignmentTextField.text!
            destViewController.bookRQD = RQD
            
            destViewController.moreToSay = aboutClassTextField.text
            
            
            
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

