//
//  CommentVC.swift
//  bany
//
//  Created by Lee Janghyup on 10/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class CommentVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var commentArray : NSMutableArray = NSMutableArray()
    var objectArray = [String]()
    var userIdArray = [String]()
    var parentObjectID = String()
    var object : PFObject!
    var postsArray = []
    
    @IBOutlet weak var deleteButton: UIButton!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        
//        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 1000, 0)
       actInd.hidden = true
        
//        titleLabel.text = object.valueForKey("titleText") as? String
        
        queryComment()
       

        // Do any additional setup after loading the view.
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

    @IBAction func sendButton(sender: AnyObject) {
        startActivityIndicator()
        
        
        let comment = PFObject(className: "Comments")
        
        
        comment["uploader"] = PFUser.currentUser()?.objectId
        comment["comment"] =  "" + commentTextField.text!
        comment["parent"] = object.objectId
        if let nickName = PFUser.currentUser()?.objectForKey("nickName"){
                        comment["nickName"] = nickName
            
            
                    }else {
            
                    comment["nickName"] = PFUser.currentUser()?.username
        }
        
        if let profilePic = (PFUser.currentUser()!.objectForKey("profile_picture") as? PFFile){
            
        comment["profile_picture"] = profilePic
        }
        
        comment.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
            
            
            if error == nil {
                
                print("업로드 성공")
                
                self.commentArray = []
                                self.queryComment()
                                print(self.commentArray)
                                self.commentTextField.text = ""
                
                
                //저장 성공했다고 표시창
                //self.luxuryAlert( "your post uploaded" )
                self.alert("Error", message : "업로드성공")
                
                
                
            }else {
                
                self.alert("Error", message : (error?.localizedDescription)!)
            }
        })

        
        
    }



    func queryComment() {
        
        startActivityIndicator()
        
        commentArray = []
        let query = PFQuery(className: "Comments")
        
        query.orderByAscending("createdAt")
        query.whereKey("parent", equalTo: (object.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                
                for object : PFObject in objects! {
                    
                    self.commentArray.addObject(object)
                    
                }
                
                let array : Array = self.commentArray.reverseObjectEnumerator().allObjects
                
                
                self.commentArray = array as! NSMutableArray
                
                
            }
            self.commentTableView.reloadData()
        }
    }


    

   
    func alert(title : String, message : String) {
        
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
        
        
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
        
        commentTextField.resignFirstResponder()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CommentTVCE = tableView.dequeueReusableCellWithIdentifier("cellForComment", forIndexPath: indexPath) as! CommentTVCE
        
        
        
        let postObjects : PFObject = self.commentArray.objectAtIndex(indexPath.row) as! PFObject
        
        cell.comment.text = postObjects.objectForKey("comment") as? String

        cell.nickNameLabel!.text = "Id:  " + (postObjects.objectForKey("nickName") as! String) + "   "
        
        //시간
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM /dd HH:mm"
        cell.dateLabel.text = (dateFormatter.stringFromDate(postObjects.createdAt!))
        
        //프로파일이미지
        if let profileImages = (postObjects.objectForKey("profile_picture") as? PFFile){
            profileImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                let image = UIImage(data: imageData!)
                cell.profileImageView.image = image
                
            }
            
        }else{ cell.profileImageView.image = UIImage(named: "AvatarPlaceholder")
        }

        
        return cell
    }
    
//    @IBAction func commentDeleteButtonTapped(sender: AnyObject) {
//        
//        let button = sender as! UIButton
//        let view = button.superview!
//        let cell = view.superview as! CommentTVCE
//        //let indexPath = commentTableView.indexPathForCell(cell)
//    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize.height = 1000
        self.scrollView.contentSize.width = 0
    }
  


}


   