//
//  EditDetailTVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/19/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import  Parse

class EditDetailTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var priceTextfield: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var hardnessLabel: UILabel!
    @IBOutlet weak var assignmentLabel: UILabel!
    @IBOutlet weak var aboutClassLabel: UILabel!
    @IBOutlet weak var bookRQDLabel: UILabel!
    @IBOutlet weak var notRQDLabel: UILabel!
    @IBOutlet weak var YesRQDLabel: UILabel!
    @IBOutlet weak var bookRQDSwitch: UISwitch!

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var attendanceTextField: UITextField!
    @IBOutlet weak var hardnessTextFeld: UITextField!
    @IBOutlet weak var assignmentTextField: UITextField!
    @IBOutlet weak var aboutClassTextField: UITextField!
    
    
    @IBOutlet weak var emailSwitch: UISwitch!
    @IBOutlet weak var textSwitch: UISwitch!
    @IBOutlet weak var descriptionTextView: UITextView!
    var parentObjectID = String()
    var object : PFObject!
    @IBOutlet weak var saveButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopActivityIndicator()
        retrievingData()
        
        // Show sold label or not
        if (object!["category"] as! Int) == 0 {
            
            titleLabel.text = "Book title"
            titleTextField.placeholder = "Title of Your book"
            
            classLabel.text = "Class"
            tagTextField.placeholder = "ex) Acom203 or ISBN"
            
            
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
        if (object["category"] as! Int) == 1 {
            
            titleLabel.text = "Product"
            titleTextField.placeholder  = "Brand & Product. ex) Apple MacBook13"
            
            classLabel.text = "Model#"
            tagTextField.placeholder = "ex) MD212"
            
            
            
            
            
            attendanceLabel.text = "Condition"
            attendanceTextField.placeholder = "5 (Everyday) to 0(Never)"
            
            hardnessLabel.text = "Purchased"
            hardnessTextFeld.placeholder = "When did you buy? Ex) 2014"
            
            assignmentLabel.text = "Original price"
            assignmentTextField.placeholder = "$"
            
            bookRQDLabel.text = "New"
            notRQDLabel.text = "Used"
            YesRQDLabel.text = "New"
            
            aboutClassLabel.text = "More"
            aboutClassTextField.placeholder = "Someting more to say about this product?"
            
            
        }
        
        if (object["bookRQD"] as? String) == "Yes"{
            
            bookRQDSwitch.on = true
            
        }else{
            
            bookRQDSwitch.on = false
            
        }

        
        if let phoneNumber = (object["phone_number"] as? String) {
            
            textSwitch.on = true
        }else{
            
            textSwitch.on = false
        }
        
        if let phoneNumber = (object["email_address"] as? String) {
            
            emailSwitch.on = true
        }else{
            
            emailSwitch.on = false
            
        }
        
       

        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addBackPicButtonTapped(sender: AnyObject) {
        startActivityIndicator()
        
        photoCaptureButtonAction()
        stopActivityIndicator()
    }

    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let query = PFQuery(className:"Posts")
        query.getObjectInBackgroundWithId(object.objectId!) {
            (object, error) -> Void in
            if error != nil {
                print(error)
            } else {
                if let object = object {
                    let titleText = self.titleTextField.text
                    let tagText = self.tagTextField.text
                    let priceText = self.priceTextfield.text
                    let descriptionText = self.descriptionTextView.text

                    if (priceText!.isEmpty || descriptionText!.isEmpty ||  tagText!.isEmpty || titleText!.isEmpty) {
                        
                    
                    self.buttonEnabled(self.saveButton)
                    self.stopActivityIndicator()
                    self.alert("Invalid", message : "You must fill in the blank")
                    
                }else {
                    
                
                if !(titleText!.utf16.count <= 45 && titleText!.utf16.count >= 2 ) {
                    
                    
                    
                    self.buttonEnabled(self.saveButton)
                    self.stopActivityIndicator()
                    self.alert("Invalid", message : "Title must be  2 ~ 45 characters")
                    
                    
                    
                }else{
                    
                    
                    if !(tagText!.utf16.count <= 40 && tagText!.utf16.count >= 2 ) {
                        self.buttonEnabled(self.saveButton)
                        self.stopActivityIndicator()
                        self.alert("Invalid", message : "Tag must be 2 ~ 45 characters")
                        
                        
                        
                    }else {
                        
                        
                        if self.textSwitch.on == false && self.emailSwitch.on == false{
                            
                            self.buttonEnabled(self.saveButton)
                            self.stopActivityIndicator()
                            self.alert("Invalid", message : "You must choose at least one contact method")
                            
                            
                        }else{
                        
                            
                            if !(descriptionText.utf16.count <= 200 && descriptionText.utf16.count >= 2 ) {
                                
                                
                                
                                self.buttonEnabled(self.saveButton)
                                self.stopActivityIndicator()
                                self.alert("Invalid", message : "Description must be 2 ~ 200 characters")
                                
                            }else{
                                
                        
                        object["titleText"] = titleText
                        object["descriptionText"] =  descriptionText
                        object["priceText"] = priceText
                        object["tagText"] = tagText
                        
                                if (self.attendanceTextField.text)!.isEmpty{
                                    object["attendence"] = "-"
                                }else{
                                     object["attendence"] = self.attendanceTextField.text
                                }
                                
                                if (self.hardnessTextFeld.text)!.isEmpty{
                                    object["hardness"] = "-"
                                }else{
                                    object["hardness"] = self.hardnessTextFeld.text
                                }
                                
                                if (self.assignmentTextField.text)!.isEmpty{
                                    object["assignment"] = "-"
                                }else{
                                    object["assignment"] = self.assignmentTextField.text
                                }

                                if (self.aboutClassTextField.text)!.isEmpty{
                                    object["moreTosay"] = "-"
                                }else{
                                    object["moreTosay"] = self.aboutClassTextField.text
                                }
                                
                                if self.bookRQDSwitch.on == true{
                                    object["bookRQD"] = "Yes"
                                }else{
                                    object["bookRQD"] = "No"
                                }

                                if self.emailSwitch.on == true {
                                    
                                    object["email_address"] = PFUser.currentUser()?.objectForKey("email_address")
                                }
                                if self.textSwitch.on == true {
                                    object["phone_number"] = PFUser.currentUser()?.objectForKey("phone_number")
                                }

                                
                                
                        let scaledImageBack = self.scaleImageWith(self.backImageView.image!, newSize: CGSizeMake(300, 233))
                        
                        
                        let imageDataTwo = UIImagePNGRepresentation(scaledImageBack)
                        
                        
                        let parseBackFile = PFFile(name: "back_photo.png", data : imageDataTwo!)

                        
                        object["back_image"] = parseBackFile
                        
                        
                                
                                
                                
                                
                                
                        object.saveInBackgroundWithBlock({ (success, error) -> Void in
                            if error == nil {
                               self.alert("saved", message: "Your post has been edited")
                            }else {
                                self.alert("error", message: (error?.localizedDescription)!)
                                
                            }
                            
                        })
                        
                    }
                        }
                    
                    }}
                }
            }
        }
    
        }
    }



    @IBAction func deleteButtonTapped(sender: AnyObject) {
    
        
            let query = PFQuery(className: "Posts")
            query.getObjectInBackgroundWithId(self.object.objectId!) { (obj, err) -> Void in
                if err != nil {
                    //handle error
                } else {
                    
                    
                    let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: Selector("handleUploadTimeoutForDelete:"), userInfo: nil, repeats: false)
                    
                    
                    obj!.deleteInBackgroundWithBlock({ (success, error) -> Void in
                        if error == nil {
                            
                            let myAlert = UIAlertController(title: "Deleted", message: "your post has been deleted", preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {Void in self.performSegueWithIdentifier("editDetailTVCToMain", sender: self)})
                            myAlert.addAction(okAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            

                            
                            
                        }
                    })
                    
    
    }
   
        }
  
    }

    func retrievingData() {
        
        
        
        
        self.titleTextField.text = object!.valueForKey("titleText") as? String
        self.descriptionTextView.text = object!.valueForKey("descriptionText") as? String
        self.priceTextfield.text = object!.valueForKey("priceText") as? String
        self.tagTextField.text =  object!.valueForKey("tagText") as? String
        
        self.attendanceTextField.text =  object!.valueForKey("attendence") as? String
        self.hardnessTextFeld.text =  object!.valueForKey("hardness") as? String
        self.assignmentTextField.text =  object!.valueForKey("assignment") as? String
        self.aboutClassTextField.text =  object!.valueForKey("moreTosay") as? String
        
        
        
        let backPic = object!.valueForKey("back_image") as? PFFile
        
        backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil){
                
                self.backImageView.image = UIImage(data: imageData!)
                
                
            }
                
            else{
                self.backImageView.image = UIImage(named: "IconHome")
                
            }
            
            
            
            
            //post!.valueForKey("prefer_phoneNumber") as? String
            //post!.valueForKey("prefer_email") as? String
            
            
            
            
            let frontPic = self.object!.valueForKey("front_image") as? PFFile
            frontPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                
                
                if(imageData != nil)
                    
                {
                    
                    self.frontImageView.image = UIImage(data: imageData!)
                    
                    
                }else{
                    self.frontImageView.image = UIImage(named: "IconHome")
                    
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
    
        @IBAction func keyBoardDismissButton(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
        
    }
    func photoCaptureButtonAction() {
        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        if cameraDeviceAvailable && photoLibraryAvailable {
            let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let takePhotoAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartCameraController() })
            let choosePhotoAction = UIAlertAction(title: NSLocalizedString("Choose Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartPhotoLibraryPickerController() })
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
            
            actionController.addAction(takePhotoAction)
            actionController.addAction(choosePhotoAction)
            actionController.addAction(cancelAction)
            
            self.presentViewController(actionController, animated: true, completion: nil)
        }
    }
    func shouldStartCameraController() -> Bool {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
            
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            } else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
            }
        } else {
            return false
        }
        
        cameraUI.allowsEditing = false
        cameraUI.showsCameraControls = true
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    func shouldStartPhotoLibraryPickerController() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false
            && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
                return false
        }
        
        let cameraUI = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
        {
            cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            
            
        } else {
            return false
        }
        
        cameraUI.allowsEditing = false
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        backImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    
                    
                               func scaleImageWith(image : UIImage, newSize : CGSize) -> UIImage {
                        
                        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
                        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
                        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        
                        return newImage
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
    
    func handleUploadTimeoutForDelete(aTimer: NSTimer) {
        stopActivityIndicator()
        
        let alertController = UIAlertController(title: ("Try later"), message: ("Post could not be deleted, there is an Internet connection problem."), preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    @IBAction func emailSwitchOn(sender: AnyObject) {
        
        if let emailFromParse = (PFUser.currentUser()?.objectForKey("email_address") as? String){
            
        }else{
            
            //이메일 저장 시키는 텍스트 필드
            
            
            
            let emailAlert : UIAlertController = UIAlertController(title: "No email address ", message: "Allow your customer email you ", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            
            emailAlert.addTextFieldWithConfigurationHandler({ (textField : UITextField) -> Void in
                textField.placeholder = "Email address"
                textField.keyboardType = UIKeyboardType.EmailAddress
            })
            
            let okAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler: { Void in
                self.emailSwitch.on = false
                
                
                self.stopActivityIndicator()
                
            })
            emailAlert.addAction(okAction)
            
            
            emailAlert.addAction(UIAlertAction(title: "save", style: UIAlertActionStyle.Default, handler: { alertAction in
                let textFields : NSArray = emailAlert.textFields as! NSArray
                let emailNumberTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                
                
                if !(emailNumberTextField.text!.utf16.count > 10  ) {
                    // 3보다 크고 16보다 작은게 아니라면
                    
                    self.emailSwitch.on = false
                    
                    self.stopActivityIndicator()
                    
                    self.alert("Invalid", message : "Invalid email address")
                    
                    
                    
                }else{
                    
                    PFUser.currentUser()?.setObject(emailNumberTextField.text!, forKey: "email_address")
                    
                    PFUser.currentUser()?.saveInBackgroundWithBlock { (success, error) -> Void in
                        self.stopActivityIndicator()
                        
                        if (error != nil)
                        {
                            self.emailSwitch.on = false
                            
                            self.stopActivityIndicator()
                            
                            self.alert("error", message: (error?.localizedDescription)!)
                        }
                        
                        if(success) {
                            
                            self.emailSwitch.on = true
                            
                            self.stopActivityIndicator()
                            
                            
                            self.alert("Saved", message : "Email address has been saved")
                        }
                    }
                }
                
                }
                
                ))
            
            self.presentViewController(emailAlert, animated: true, completion: nil)
            
            self.stopActivityIndicator()
        }
        
    }
    
    @IBAction func textFieldOn(sender: AnyObject) {
        if let numberFromParse = (PFUser.currentUser()?.objectForKey("phone_number") as? String){
            
            
        }else{
            
            
            textSwitch.on = false
            // textSwitch.enabled = false
            //전화번호 저장 시키는 텍스트 필드
            
            
            
            let phoneAlert : UIAlertController = UIAlertController(title: "Phone number", message: "Allow your customer text you ", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler : { Void in
                self.textSwitch.on = false
                
                
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
                    
                    self.stopActivityIndicator()
                    
                    self.alert("Invalid", message : "PhoneNumber must be 10 digit")
                    
                    
                    
                    
                }else{
                    
                    PFUser.currentUser()?.setObject(phoneNumberTextField.text!, forKey: "phone_number")
                    
                    PFUser.currentUser()?.saveInBackgroundWithBlock { (success, error) -> Void in
                        self.stopActivityIndicator()
                        
                        if (error != nil)
                        {
                            
                            self.stopActivityIndicator()
                            self.alert("error", message: (error?.localizedDescription)!)
                        }
                        
                        if(success) {
                            
                            self.textSwitch.on = true
                            
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
    
    
    
    
    
    
    
}
