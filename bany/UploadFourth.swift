//
//  NewUploadDescription.swift
//  bany
//
//  Created by Lee Janghyup on 10/11/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UploadFourth: UITableViewController,UITextFieldDelegate{

    var reachability : Reachability?
    var internetConnection : Bool = false
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var textSwitch: UISwitch!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var uploadButton: UIButton!
    
    
    var attendence : String!
    var hardness : String!
    var assignment : String!
    var bookRQD : String!
    
    var moreToSay: String!
    var priceText = String()
    var category = Int()
    var titleText = String()
    var tagText = String()
    var photoFront = UIImage()
    var photoBack = UIImage()
    var email :String = String()
    var phoneNumber :String = String()
    var uploadPhotoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.stopActivityIndicator()
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
            buttonEnabled(uploadButton)
            
        }else{
            
           
                if #available(iOS 8.0, *) {
                    let myAlert = UIAlertController(title: "No network", message:
                        "Network is not working", preferredStyle:
                        UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style:
                        UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion:
                        nil)

                } else {
                    let a = UIAlertView(title: "No network", message: "Network is not working", delegate: nil, cancelButtonTitle: "Ok")
                    a.show()
                }
           
                        internetConnection = false
            buttonDisabeld(uploadButton)
        }
        
    }
    func connectionChanged() {
        
        if reachability!.isReachable() {
            
            internetConnection = true
            buttonEnabled(uploadButton)
            
            
        }else {
            if #available(iOS 8.0, *) {
                let myAlert = UIAlertController(title: "No network", message: "Network is not working", preferredStyle:
                    UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)

            } else {
                let a = UIAlertView(title: "No network", message: "Network is not working", delegate: nil, cancelButtonTitle: "Ok")
                a.show()            }
            
            internetConnection = false
            buttonDisabeld(uploadButton)
            
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @IBAction func emailSwitchOn(sender: AnyObject) {
       
        if let emailFromParse = (PFUser.currentUser()?.objectForKey("email_address") as? String){
            email = emailFromParse
            
        }else{
            
            //이메일 저장 시키는 텍스트 필드
            
            
            
            let emailAlert : UIAlertController = UIAlertController(title: "No email address ", message: "Allow your customer email you ", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            emailAlert.addTextFieldWithConfigurationHandler({ (textField : UITextField) -> Void in
                textField.placeholder = "Email address"
                textField.keyboardType = UIKeyboardType.EmailAddress
            })
            
            let okAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler: { Void in
                self.emailSwitch.on = false
                
                self.buttonEnabled(self.uploadButton)
                
                self.stopActivityIndicator()
                
            })
            emailAlert.addAction(okAction)
            
            
            emailAlert.addAction(UIAlertAction(title: "save", style: UIAlertActionStyle.Default, handler: { alertAction in
                let textFields : NSArray = emailAlert.textFields as! NSArray
                let emailNumberTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                
                if !(emailNumberTextField.text!.utf16.count > 10  ) {
                    // 3보다 크고 16보다 작은게 아니라면
                    
                    self.emailSwitch.on = false
                    self.buttonEnabled(self.uploadButton)
                    
                    self.stopActivityIndicator()

                    self.alert("Invalid", message : "Invalid email address")
                    
                    
                    
                }else{
                    
                    PFUser.currentUser()?.setObject(emailNumberTextField.text!, forKey: "email_address")
                    
                    PFUser.currentUser()?.saveInBackgroundWithBlock { (success, error) -> Void in
                        self.stopActivityIndicator()
                        
                        if (error != nil)
                        {
                            self.emailSwitch.on = false

                            self.buttonEnabled(self.uploadButton)
                            
                            self.stopActivityIndicator()

                            self.alert("error", message: (error?.localizedDescription)!)
                        }
                        
                        if(success) {
                            
                            self.emailSwitch.on = true
                            self.buttonEnabled(self.uploadButton)
                            
                            self.stopActivityIndicator()

                            
                            self.alert("Saved", message : "Email address has been saved")
                        }
                    }
                }
                
                }
                
                ))
            
            self.presentViewController(emailAlert, animated: true, completion: nil)
            self.buttonEnabled(self.uploadButton)
            
            self.stopActivityIndicator()
        }

    }
    
    @IBAction func textFieldOn(sender: AnyObject) {
        if let numberFromParse = (PFUser.currentUser()?.objectForKey("phone_number") as? String){
     
            phoneNumber = numberFromParse
            
        }else{
            
            
            textSwitch.on = false
           // textSwitch.enabled = false
            //전화번호 저장 시키는 텍스트 필드
           
            
            
            let phoneAlert : UIAlertController = UIAlertController(title: "Phone number", message: "Allow your customer text you ", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler : { Void in
                self.textSwitch.on = false
                
                self.buttonEnabled(self.uploadButton)
                
                self.stopActivityIndicator()
                
                })

            phoneAlert.addAction(okAction)

            
            phoneAlert.addTextFieldWithConfigurationHandler({ (textField : UITextField) -> Void in
                textField.placeholder = "phone number"
                textField.keyboardType = UIKeyboardType.PhonePad
            })
            
            phoneAlert.addAction(UIAlertAction(title: "save", style: UIAlertActionStyle.Default, handler: { alertAction in
                let textFields : NSArray = phoneAlert.textFields as! NSArray
                let phoneNumberTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                
                if !(phoneNumberTextField.text!.utf16.count == 10  ) {
                    // 3보다 크고 16보다 작은게 아니라면
                    
                    self.buttonEnabled(self.uploadButton)
                    
                    self.stopActivityIndicator()

               self.alert("Invalid", message : "PhoneNumber must be 10 digit")
                   
                    
                   
                    
                }else{

                PFUser.currentUser()?.setObject(phoneNumberTextField.text!, forKey: "phone_number")
                
                PFUser.currentUser()?.saveInBackgroundWithBlock { (success, error) -> Void in
                    self.stopActivityIndicator()
                    
                    if (error != nil)
                    {self.buttonEnabled(self.uploadButton)
                        
                        self.stopActivityIndicator()
                        self.alert("error", message: (error?.localizedDescription)!)
                    }
                    
                    if(success) {
                        
                        self.textSwitch.on = true
                        self.buttonEnabled(self.uploadButton)
                        
                        self.stopActivityIndicator()
                        
                        self.alert("Saved", message : "Phone number has been saved")

                        
                        
                    }
                    
                    
                }
                }
               
            }
        ))
            
            
            self.presentViewController(phoneAlert, animated: true, completion: nil)
            
        }
       
    }
    
    
    
    
    
    
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        startActivityIndicator()
        buttonDisabeld(uploadButton)
        
        let descriptionText = descriptionTextView.text
        
       
        if   descriptionText!.isEmpty{
            
            
            //유저에게 채워넣으라고 알럴트
            
            buttonEnabled(uploadButton)
            
            stopActivityIndicator()

            self.alert("Invalid", message : "You must fill in Description/Damage blank")
            
        }else {
            
                           //ㅇㅋ
                
                if !(descriptionText.utf16.count <= 200 && descriptionText.utf16.count >= 2 ) {
                    
                    
                    buttonEnabled(uploadButton)
                    
                    stopActivityIndicator()

                    alert("Invalid", message : "Description must be 2 ~ 200 characters")
                    
                    
                    
                    
                }else {
            
            
            
            
            if(!emailSwitch.on && !textSwitch.on){
                
                stopActivityIndicator()
                buttonEnabled(uploadButton)
                self.alert("invalid", message : "You must choose at least one contact method")
                
            }else{
                
                var searchText = (titleText + " " + tagText + " " + descriptionText).lowercaseString

                
                    //컨택 메소드 꼭 선택시키고 선택 할때 전화번호/이메일 맞는 지 확인시키기
                    
                    //스케일 조절
                    let scaledImageFront = self.scaleImageWith(photoFront, newSize: CGSizeMake(300, 233))
                
                    let scaledImageBack = self.scaleImageWith(photoBack, newSize: CGSizeMake(300, 233))
                
                let imageDataOne = UIImagePNGRepresentation(scaledImageFront)
                let imageDataTwo = UIImagePNGRepresentation(scaledImageBack)
                
                    let parseFrontFile = PFFile(name: "front_photo.png", data : imageDataOne!)
                let parseBackFile = PFFile(name: "back_photo.png", data : imageDataTwo!)
                
                    let post = PFObject(className: "Posts")
                    
                    
                    post["uploader"] = PFUser.currentUser()?.objectId
                    post["username"] = (PFUser.currentUser()!.username)!
                    post["titleText"] = titleText
                    post["priceText"] = priceText
                    post["tagText"] = tagText
                    post["front_image"] = parseFrontFile
                    post["back_image"] = parseBackFile
                    post["descriptionText"] = descriptionText
                
                    post["attendence"] = attendence
                    post["hardness"]  = hardness
                    post["assignment"]  = assignment
                    post["bookRQD"] = bookRQD
                
                    post["moreTosay"] = moreToSay

                
                    post["searchText"] = searchText
                
                
                
                
                if let nickName = PFUser.currentUser()?.objectForKey("nickName") {
                    post["nickName"] = nickName
                
                }
                    post["category"] = category
                    post["sold"] = false
                if emailSwitch.on == true {
                    
                    post["email_address"] = PFUser.currentUser()?.objectForKey("email_address")
                }
                if textSwitch.on == true {
                    post["phone_number"] = PFUser.currentUser()?.objectForKey("phone_number")
               }
               
                
                
                if let   profilePic = PFUser.currentUser()?.objectForKey("profile_picture"){
                    
                    post["profile_picture"] = profilePic
                }
               
               
                let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: Selector("handleUploadTimeout:"), userInfo: nil, repeats: false)
                
                
                post.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
                    
                        
                        if error == nil {
                            
                            self.buttonEnabled(self.uploadButton)
                            
                            self.stopActivityIndicator()

                            
                            //저장 성공했다고 표시창
                            //self.luxuryAlert( "your post uploaded" )
                            
                            
                            let myAlert = UIAlertController(title: "Post saved", message: "Your item is uploaded", preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {Void in self.performSegueWithIdentifier("uplaodToMain", sender: self)})
                            myAlert.addAction(okAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)

                            
                        }else {
                            
                            self.alert("Error", message : (error?.localizedDescription)!)
                        }
                })
                
                       }
        
            }
    
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
        

                        descriptionTextView.resignFirstResponder()
        
        
    }
    func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func luxuryAlert(userMessage:String) {
        
        let myAlert = UIAlertController(title: "Success", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
       
        
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            
            self.performSegueWithIdentifier("uploadToMain", sender: self)
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
        buttonName.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        buttonName.enabled = true
    }
    func buttonDisabeld(buttonName: UIButton){
        buttonName.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        buttonName.enabled = false
    }
    

    //
    //                let imageData = UIImagePNGRepresentation(UIImage(named: "AvatarPlaceholder")!)
    //                let profileImageFile = PFFile(name: "profileImage", data: imageData!)
    //                post["profile_picture"] = profileImageFile
    //
    
    
    
    @IBAction func keyBoardDismissButton(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func handleUploadTimeout(aTimer: NSTimer) {
        stopActivityIndicator()
        
        let alertController = UIAlertController(title: ("Try upload later"), message: ("Post could not be uploaded, there is an Internet connection problem."), preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }



    
}
