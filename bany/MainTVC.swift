//
//  MainVCTableViewController.swift
//  bany
//
//  Created by Lee Janghyup on 9/25/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MainTVC: UITableViewController {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    
    var limit = 10
    var skip = 0
   
   var postsArray = [PFObject]()
    
    var objectTwo : PFObject!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.fetchAllObjectsFromParse()
   
        
    }
    
    override func reloadInputViews() {
        
        super.reloadInputViews()
        
        print("end reload")
    }
    
    
    
    func fetchAllObjectsFromParse() {
        
        //empty postArray
        postsArray = []
        
        //bring data from parse
        let query = PFQuery(className: "Posts")
        query.limit = limit
        
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                for object in objects! {
                    
                    self.postsArray.append(object)
                                    }

                    if (objects!.count == self.limit){
                        
                        let query = PFQuery(className: "Posts")
                        self.skip += self.limit
                        query.skip = self.skip
                        query.limit = self.limit
                        print(self.limit)
                       print(self.skip)
                        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            if error == nil && objects != nil {
                                for object in objects! {
                                    self.postsArray.append(object)
                                    print(objects?.count)
                                }
                            }
                        })
                        
                        
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableView.reloadData()
                        })
                    }
                
            }else{
                print(error?.localizedDescription)
                
                
            }
        }
    }
    
    
//    @IBAction func segmentTapped(sender: AnyObject) {
//    
//        // Empty postArray
//        postsArray = []
//      
//        // get post's data by categories
//        switch categorySegment.selectedSegmentIndex {
//        case 0 :
//            bringAllDatafromParse()
//        case 1 :
//            bringCategoryDataFromParse(1)
//            
//        case 2 :
//            bringCategoryDataFromParse(2)
//            
//        case 3 :
//            bringCategoryDataFromParse(3)
//            
//        default :
//            bringAllDatafromParse()
//       }
//        self.tableView.reloadData()
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postsArray.count
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTVCE
        //let postObjects = self.postsArray.objectAtIndex(indexPath.row) as! PFObject
        let postObjects = self.postsArray[indexPath.row]
        
        // IndexPath for comment button on tableView
        cell.didRequestToShowComment = { (cell) in
            let indexPath = tableView.indexPathForCell(cell)
            let objectToSend = self.postsArray[indexPath!.row] as? PFObject
            // Show your Comment view controller here, and set object to send here
            self.objectTwo = objectToSend!
            self.performSegueWithIdentifier("mainToComment", sender: self)
        }
       
        
        // Show sold label or not
        cell.soldLabel.hidden = !(postObjects.objectForKey("sold") as! Bool)
        
        
        // title Label of post
        cell.titleLabel.text = postObjects.objectForKey("titleText") as? String

        
        // nick name of user
         cell.nickNameLabel.text = postObjects.objectForKey("username") as? String
        
        if (postObjects.objectForKey("nickName") as? String) != nil {
            
            cell.nickNameLabel.text = postObjects.objectForKey("nickName") as? String
        }
        
        // time label for posts
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM /dd /yy"
        cell.timeLabel.text = (dateFormatter.stringFromDate(postObjects.createdAt!))
        
       
        // price label
        let price = (postObjects.objectForKey("priceText") as! String)
                cell.priceLable.text = "   $\(price)"
        
       
        // main Image for post
        let mainImages = postObjects.objectForKey("front_image") as! PFFile
        mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            let image = UIImage(data: imageData!)
            cell.mainPhoto.image = image
        }
        
        
        //profile picture for user
        cell.profilePhoto.image = UIImage(named: "AvatarPlaceholder")
        
        if let profileImages = (postObjects.objectForKey("profile_picture") as? PFFile){
                    profileImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                        let image = UIImage(data: imageData!)
                        cell.profilePhoto.image = image
            }
        }
        circularImage(cell.profilePhoto)
        
        
        
        return cell
    }
//    func fetchAllObjects() {
//    
//       // PFObject.unpinAllObjectsInBackgroundWithBlock(nil)
//        //postsArray = []
//        
//        //bring data from parse
//        let query = PFQuery(className: "Posts")
//        //query.limit = 1000
//        query.orderByDescending("createdAt")
//          query.cachePolicy = .NetworkOnly
//        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
//            if error == nil && objects != nil{
//                
//
//                   PFObject.pinAllInBackground(objects, block: nil)
//                    self.fetchAllObjectsFromLocalDataStore()
//                
//                self.tableView.reloadData()
//            }else{
//                print(error?.userInfo)
//            }
//         
//            
//        }
//        
//        
//        
//        
//
//
//
//    }
  
    
    func bringCategoryDataFromParse(category : Int) {
    
            }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // send object to commentViewController
        if (segue.identifier == "mainToComment") {
            let destViewController : CommentVC = segue.destinationViewController as! CommentVC
            destViewController.object = objectTwo
        }
        
        // send object to DetailViewController
        if (segue.identifier == "mainToDetail") {
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
                destViewController.object = (postsArray[(selectedRowIndex?.row)!] as? PFObject)

        }
    }
    
    func circularImage(image : UIImageView) {
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds  = true
        image.layer.borderColor  = UIColor.blackColor().CGColor
        image.layer.borderWidth = 1
    }
}



//    @IBAction func commentButtonTapped(sender: AnyObject) {
//        
//        let button = sender as! UIButton
//        let view = button.superview!
//        let cell = view.superview as! MainTVCE
//        let indexPath = tableView.indexPathForCell(cell)
//        parentObjectID = postsArray[(indexPath?.row)!].objectId!!
//        
//        
//        
//    }
    
        
        
    
   
      //  self.performSegueWithIdentifier("mainToComment", sender: self)
   // }
    
    

    /*func howaboutThis() {
        let query = PFQuery(className: "User")
        query.whereKey("objectId", equalTo: (PFUser.currentUser()?.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if(error == nil) {
                var temp: NSArray = objects as! NSArray
                
                self.userArray = temp.mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
                
            }else {
                print(error?.userInfo)
            }
        }
       //테이블 뷰 셀에 쓸꺼
    var object: PFObject = self.uerArray.objectIndex(indexPath.row) as PFObject
    cell.titleLabel.text = object["nickName"] as? String
    
    return cell
    
    //preparefor segue
    if (segue.identifier == "editNote") {
    let indexPath = self.tableView.indexPathForSelectedRow()!
    var object : PFObject = self.noteObjects.objectAtIndex(indexPath.row) as PFObject
    upcoming.object = object
    self.tableView.deselectRowAtIndexPath(indexPath, animated : true)
*/

