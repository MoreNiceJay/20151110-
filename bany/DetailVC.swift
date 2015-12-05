//
//  DetailVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class DetailVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purchasedDateLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var tagTextLabel: UILabel!
        
    @IBOutlet weak var firstTagTextLabel: UILabel!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var soldSwitch: UISwitch!
    
    var checkingArray = [String]()
    
    var parentObjectID = String()
    
    var frontImage = UIImageView()
    var backImage = UIImageView()
    
    
    @IBOutlet weak var soldLabel: UILabel!
    var array = []
      var object : PFObject!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = UIScreen.mainScreen().bounds
         detailViewSetting()
        
        
        editButton.hidden = true
        soldLabel.hidden = true
        soldSwitch.hidden = true

        // Do any additional setup after loading the view.
        
        //scrollView.contentInset = UIEdgeInsetsMake(0, 0, 1000, 0)
        
        //유저가 맞으면 에딧 하게 해주기
        
        if object.valueForKey("uploader") as? String == PFUser.currentUser()?.objectId{
            self.editButton.hidden = false
            soldLabel.hidden = false
            soldSwitch.hidden = false
            
           //솔드 스위치
            if object.valueForKey("sold") as! Bool == true {
                self.soldLabel.textColor = UIColor.redColor()
                soldSwitch.on = true
                emailButton.hidden = true
                textButton.hidden = true
                
                //팔린걸로 표시된거 알림
                
            }else if object.valueForKey("sold") as! Bool == false{
                soldSwitch.on = false
                self.soldLabel.textColor = UIColor.grayColor()
                emailButton.hidden = false
                textButton.hidden = false
            }
            
        }
//        let checkForEdit = PFQuery(className: "Posts")
//        
//        print(parentObjectID)
//        checkForEdit.getObjectInBackgroundWithId(parentObjectID) {
//            (post: PFObject?, error: NSError?) -> Void in
//            if error == nil && post != nil {
//
//                
//                
//                if  (PFUser.currentUser()?.objectId == post!.valueForKey("uploader") as? String){
//                    self.editButton.hidden = false
//                
//                }
//            }
//        
//        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        }
        
    
        
        func detailViewSetting(){
        //제목
        
            
            self.titleLabel.text = object.objectForKey("titleText") as? String
            self.descriptionTextLabel.text = object.valueForKey("descriptionText") as? String
            self.priceLabel.text = "$" + (object.valueForKey("priceText") as? String)!
            self.purchasedDateLabel.text = object.valueForKey("purchasedDate") as? String
            
            self.firstTagTextLabel.text = (object!.valueForKey("tagText") as? String)!

            self.tagTextLabel.text =  (object!.valueForKey("tagText") as? String)!
            
            if let userNickNameCheck = object!.valueForKey("nickName") as? String {
                
                self.nickNameLabel.text = userNickNameCheck
                
            }else{
               self.nickNameLabel.text = object!.valueForKey("nickName") as? String
            }

            
            
            
            //시간
            
            
            let dateFormatter:NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM /dd /yyyy HH:mm"
            timeLabel.text = (dateFormatter.stringFromDate(object.createdAt!))
            
            let mainImage = object.objectForKey("front_image") as! PFFile
            
            
            mainImage.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                let image = UIImage(data: imageData!)
                self.frontImageView.image = image
                self.frontImage.image = image
            }
            
            
            let backImage = object.objectForKey("back_image") as! PFFile
            
            
            backImage.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                let image = UIImage(data: imageData!)
                self.backImageView.image = image
                self.backImage.image = image
            }

            
            
            // 프로필
            if let profileImages = (object.objectForKey("profile_picture") as? PFFile){
                profileImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                    let image = UIImage(data: imageData!)
                    self.profileImageView.image = image
                    
                }
            
            }else{ profileImageView.image = UIImage(named: "AvatarPlaceholder")
               
            }

                
                
                
                
                //post!.valueForKey("prefer_phoneNumber") as? String
                //post!.valueForKey("prefer_email") as? String
                
                
                
                
    

    
        
    
    }
    
    
    @IBAction func soldbutton(sender: AnyObject) {
        if soldSwitch.on == false {
            
            let query = PFQuery(className:"Posts")
            query.getObjectInBackgroundWithId(object.objectId!) {
                (post: PFObject?, error: NSError?) -> Void in
                if error != nil && post == nil {
                    
                    
                    
                }else if let post = post {
                    
                    post["sold"] = false
                     self.soldLabel.textColor = UIColor.grayColor()
                    //저장 알림
                    
                    self.emailButton.hidden = false
                    self.textButton.hidden = false
                    
                    post.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if error == nil{
                            
                            //에러 알림
                        }
                    })
                }
            }
        

            
        }else {
            let query = PFQuery(className:"Posts")
            query.getObjectInBackgroundWithId(object.objectId!) {
                (post: PFObject?, error: NSError?) -> Void in
                if error != nil && post == nil {
                    
                    
                    
                }else if let post = post {
                    
                    post["sold"] = true
                    self.soldLabel.textColor = UIColor.redColor()
                    self.emailButton.hidden = true
                    self.textButton.hidden = true                    //저장 알림
                    
                    post.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if error == nil{
                            
                            //에러 알림
                        }
                    })
                }
            }

        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.scrollView.frame = self.view.bounds
//        self.scrollView.contentSize.height = 1000
//        self.scrollView.contentSize.width = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func commentButtonTapped(sender: AnyObject) {
       
        
       performSegueWithIdentifier("detailToComment", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "front") {
            
            
            let destViewController : FrontImage = segue.destinationViewController as! FrontImage
            destViewController.frontImageView.image = frontImage.image
            
            
            
            
        }
        
        if (segue.identifier == "back") {
            
            let destViewController : BackImage = segue.destinationViewController as! BackImage
            destViewController.backImageView.image = backImage.image
            
            
        }

        if (segue.identifier == "editToDetail") {
            
            
            let destViewController : EditDetailTVC = segue.destinationViewController as! EditDetailTVC
           // destViewController.parentObjectID = parentObjectID
            
            destViewController.object = object
            
        }
        
    }

//    @IBAction func likeButtonTapped(sender: AnyObject){
//        
//        
//        
//        let query = PFObject(className:"Like")
//        
//        post["parent"] = self.object.objectId
//        post["uploader"] = PFUser.currentUser()?.objectId
//
//        query.saveInBackground()
//                
//                
//            }else if let post = post {
//                
//                post["parent"] = self.object.objectId
//                post["uploader"] = PFUser.currentUser()?.objectId
//                //저장 알림
//                
//                post.saveInBackgroundWithBlock({ (success, error) -> Void in
//                    if error == nil{
//                        (print("good"))
//                        //에러 알림
//                        
//                        self.alert("liked", message: "this post has been saved")
//                        self.likeButton.enabled = false
//                    }
//                })
//            }
//        }
//        
//        
//    
//    }
//
    
        
    
  

      


        
        
        
        
       
       

    
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func retrievingData() {
    let query = PFQuery(className:"Posts")
    query.getObjectInBackgroundWithId(parentObjectID) {
    (post: PFObject?, error: NSError?) -> Void in
    if error == nil && post != nil {
        
       
        
       
       self.titleLabel.text = post!.valueForKey("titleText") as? String
       self.descriptionTextLabel.text = post!.valueForKey("descriptionText") as? String
        self.priceLabel.text =  "$" + (post!.valueForKey("priceText") as? String)!
        self.purchasedDateLabel.text = post!.valueForKey("purchasedDate") as? String

        self.tagTextLabel.text =  post!.valueForKey("tagText") as? String
        self.nickNameLabel.text = post!.valueForKey("nickName") as? String
        
        
        //시간
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
      
        
        self.timeLabel.text = dateFormatter.stringFromDate(post!.createdAt!)
        
        
        
        let backPic = post!.valueForKey("back_image") as? PFFile
        
        backPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil){
                
                self.backImageView.image = UIImage(data: imageData!)
                self.backImage.image = UIImage(data: imageData!)
                
            }
                
            else{
                self.backImageView.image = UIImage(named: "PlaceholderPhoto")
                
                self.backImage.image = UIImage(named: "PlaceholderPhoto")
                
            }
            
            
            
            
            //post!.valueForKey("prefer_phoneNumber") as? String
            //post!.valueForKey("prefer_email") as? String

        
        
        
        let frontPic = post!.valueForKey("front_image") as? PFFile
                frontPic!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            
            
            if(imageData != nil)
                
            {
                
                self.frontImageView.image = UIImage(data: imageData!)
                self.frontImage.image = UIImage(data: imageData!)
                
    }else{
        self.frontImageView.image = UIImage(named: "PlaceholderPhoto")
                
                self.frontImage.image =
                    UIImage(named: "PlaceholderPhoto")

        }
       }
        }
       
        }
    
    
        }
        
    }

    @IBAction func emailButtonTapped(sender: AnyObject) {
        
        if object.valueForKey("sold") as! Bool == false{
        
        
        if let preferEmail = object.valueForKey("email_address") as? String {
            
            
        
        let mailAddress : NSURL = NSURL(string: "mailto://\(preferEmail)")!
        
        UIApplication.sharedApplication().openURL(mailAddress)

        }else{
            //없음 알럴트 주기
            self.alert("Text only", message: "Seller prefer to be contacted by text(SMS)")

            }
                
            
            
            }else{//팔렸다 하기
            self.alert("Sold", message: "This Item is already sold")
        }
    
    }

    
    @IBAction func textButtonTapped(sender: AnyObject) {
        if object.valueForKey("sold") as! Bool == false{
       
        if let preferPhone = (object.valueForKey("phone_number") as? String) {
        
            let textNumber : NSURL = NSURL(string: "sms://\(preferPhone)")!
            
            UIApplication.sharedApplication().openURL(textNumber)
            
        
        
        }else{
            
            self.alert("Email only", message: "Seller prefer to be contacted by email")
            //넘버 없다고 말해주기
        }
    }else { //팔렸다고 말해주기
            self.alert("Sold", message: "This Item is already sold")
    
    }

}
    
    
}
        

