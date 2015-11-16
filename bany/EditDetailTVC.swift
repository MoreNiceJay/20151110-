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

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var purchasedDateTextField: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var tagTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    var parentObjectID = String()
    var object : PFObject!
    @IBOutlet weak var saveButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
stopActivityIndicator()
        retrievingData()

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
                    
                    let tagText = self.tagTextfield.text
                    
                    let priceText = self.priceTextfield.text
                    
                    let purchasedDate = self.purchasedDateTextField.text
                    
                    let descriptionText = self.descriptionTextView.text
                    
                  
                    if (priceText!.isEmpty || descriptionText!.isEmpty || purchasedDate!.isEmpty || tagText!.isEmpty || titleText!.isEmpty) {
                        
                    
                    self.buttonEnabled(self.saveButton)
                    
                    
                    
                    self.stopActivityIndicator()
                    
                    self.alert("Invalid", message : "you must fill in the blank")
                    
                    
                    
                }else {
                    
                
                if !(titleText!.utf16.count <= 45 && titleText!.utf16.count >= 2 ) {
                    
                    
                    
                    self.buttonEnabled(self.saveButton)
                    
                    
                    
                    self.stopActivityIndicator()
                    
                    
                    
                    self.alert("Invalid", message : "title must be  2 ~ 45 characters")
                    
                    
                    
                    
                    
                    
                    
                }else{
                    
                    
                    
                    if !(tagText!.utf16.count <= 40 && tagText!.utf16.count >= 2 ) {
                        
                        
                        
                        self.buttonEnabled(self.saveButton)
                        
                        
                        
                        self.stopActivityIndicator()
                        
                        
                        
                        self.alert("Invalid", message : "tag must be 2 ~ 45 characters")
                        
                        
                        
                        
                        
                    }else {
                        
                        
                        
                        
                        
                        if !(purchasedDate!.utf16.count > 3 && purchasedDate!.utf16.count < 13 ) {
                            
                            self.buttonEnabled(self.saveButton)
                            
                            
                            
                            self.stopActivityIndicator()
                            
                            
                            
                            self.alert("Invalid", message : "Date must be 4 - 12 digit")
                            
                            
                            
                        }else{
                            
                            
                            
                            if !(descriptionText.utf16.count <= 200 && descriptionText.utf16.count >= 2 ) {
                                
                                
                                
                                self.buttonEnabled(self.saveButton)
                                
                                
                                
                                self.stopActivityIndicator()
                                
                                
                                
                                self.alert("Invalid", message : "Description must be 2 ~ 200 characters")
                                
                                
                                
                            }else{
                                
                        
                        object["titleText"] = titleText
                        object["descriptionText"] =  descriptionText
                        
                        object["priceText"] = priceText
                        
                        object["purchasedDate"] = purchasedDate
                        
                                                
                        object["tagText"] = tagText
                        
                        let scaledImageBack = self.scaleImageWith(self.backImageView.image!, newSize: CGSizeMake(300, 233))
                        
                        
                        let imageDataTwo = UIImagePNGRepresentation(scaledImageBack)
                        
                        
                        let parseBackFile = PFFile(name: "back_photo.png", data : imageDataTwo!)

                        
                        object["back_image"] = parseBackFile
                        
                        
                                
                                
                                
                                
                                
                        object.saveInBackgroundWithBlock({ (success, error) -> Void in
                            if error == nil {
                               self.alert("saved", message: "your post has been edited")
                            }else {
                                self.alert("error", message: (error?.localizedDescription)!)
                                
                            }
                            
                        })
                        
                    }
                        }
                    }
                    }
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
        self.purchasedDateTextField.text = object!.valueForKey("purchasedDate") as? String
        
        self.tagTextfield.text =  object!.valueForKey("tagText") as? String
        
        
        
        
        let backPic = object!.valueForKey("back_image") as? PFFile
        
        backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil){
                
                self.backImageView.image = UIImage(data: imageData!)
                
                
            }
                
            else{
                self.backImageView.image = UIImage(named: "ic_person")
                
            }
            
            
            
            
            //post!.valueForKey("prefer_phoneNumber") as? String
            //post!.valueForKey("prefer_email") as? String
            
            
            
            
            let frontPic = self.object!.valueForKey("front_image") as? PFFile
            frontPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                
                
                if(imageData != nil)
                    
                {
                    
                    self.frontImageView.image = UIImage(data: imageData!)
                    
                    
                }else{
                    self.frontImageView.image = UIImage(named: "AvatarPlaceholder")
                    
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
        
        
        titleTextField.resignFirstResponder()
        priceTextfield.resignFirstResponder()
        tagTextfield.resignFirstResponder()
        purchasedDateTextField.resignFirstResponder()
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
        titleTextField.resignFirstResponder()
        
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


    
    
    
}
