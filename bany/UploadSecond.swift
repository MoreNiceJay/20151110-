//
//  NewUploadPhoto.swift
//  bany
//
//  Created by Lee Janghyup on 10/11/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class UploadSecond : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var priceText = String()
    var category = Int()
    var titleText = String()
    var tagText = String()
    @IBOutlet weak var picturButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var photoFront: UIImageView!
    
          @IBOutlet weak var actInd: UIActivityIndicatorView!
      override func viewDidLoad() {
        super.viewDidLoad()
        

        actInd.hidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addPicButtonTapped(sender: AnyObject) {
        startActivityIndicator()
        
        photoCaptureButtonAction()
        stopActivityIndicator()
        
        
        
        
        
    }
    
    @IBAction func nextButtonButton(sender: AnyObject) {
        startActivityIndicator()
        buttonDisabeld(nextButton)

        if photoFront.image == UIImage(named: "PlaceholderPhoto") {
            
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
            alert("No Image", message: "Have a rear image of your product")
            
            
            
        }else {
            buttonEnabled(nextButton)
            
            stopActivityIndicator()
performSegueWithIdentifier("uploadSecondToUploadThrid", sender: self)
        }
        
        
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let photoOne = photoFront.image
        
        if (segue.identifier == "uploadSecondToUploadThrid") {
            
            
            let destViewController : UploadThird = segue.destinationViewController as! UploadThird
            destViewController.category = category
            destViewController.titleText = titleText
            destViewController.tagText = tagText
            destViewController.photoFront   = photoOne!
            destViewController.priceText = priceText
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        photoFront.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func startActivityIndicator() {
        self.actInd.hidden = false
        self.actInd.startAnimating()
        
    }
    
    func stopActivityIndicator() {
        self.actInd.hidden = true
        self.actInd.stopAnimating()
    }
    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if (segue.identifier == "mainUpload") {
//            let destViewController : UploadVC = segue.destinationViewController as! UploadVC
//            destViewController.uploadPhotoImageView = uploadPhotoImageView
//        }
//    }
    
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
    func buttonEnabled(buttonName: UIButton){
        
        buttonName.enabled = true
    }
    func buttonDisabeld(buttonName: UIButton){
        
        buttonName.enabled = false
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    

    
}
