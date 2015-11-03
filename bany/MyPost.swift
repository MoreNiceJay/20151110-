//
//  MyPost.swift
//  bany
//
//  Created by Lee Janghyup on 10/5/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class MyPost: UIViewController,  UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var myPostTitle = [String]()
    var myPostPic = [PFFile]()
    var myPostDate = [String]()
    var objectArray = [String]()
    var postsArray = [PFObject]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        fetchAllObjectsFromLocalDataStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myPostCell", forIndexPath: indexPath) as! MyPostTVCE
        
        
       let postObjects = self.postsArray[indexPath.row]
        
        
        
        
        
        // Show sold label or not
        cell.soldLabel.hidden = !(postObjects.objectForKey("sold") as! Bool)
        
        // title Label of post
        cell.titleLabel.text = postObjects.objectForKey("titleText") as? String
            
        
        // Show sold label or not
        cell.soldLabel.hidden = !(postObjects.objectForKey("sold") as! Bool)
        
        // time label for posts
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM /dd /yy"
        cell.timeLabel.text = (dateFormatter.stringFromDate(postObjects.createdAt!))
        
        // price label
        let price = (postObjects.objectForKey("priceText") as! String)
        cell.priceLabel.text = "   $\(price)"
        

        // main Image for post
        let mainImages = postObjects.objectForKey("front_image") as! PFFile
        mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            let image = UIImage(data: imageData!)
            cell.mainImageView.image = image
        }
        
        return cell
        
    }



    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postsArray.count
    }

    
    
//    func loadMyPost(){
//        
//        let myPost = PFQuery(className: "Posts")
//        myPost.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
//        myPost.orderByAscending("createdAt")
//        myPost.findObjectsInBackgroundWithBlock { (posts, error) -> Void in
//            if error == nil {
//                
//                for post in posts! {
//                    
//                    self.myPostTitle.append(post["titleText"] as! String)
//                    //time
//                    let dateFormatter:NSDateFormatter = NSDateFormatter()
//                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
//                    self.myPostDate.append(dateFormatter.stringFromDate(post.createdAt!))
//                    self.myPostPic.append(post["front_image"] as! PFFile)
//                    self.objectArray.append((post.objectId)! as String!)
//                    
//                    self.tableView.reloadData()
//                }
//                
//                
//            }else{
//                print(error)
//            }
//            
//        }
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "MyPostToDetail") {
            
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            let destViewController : DetailVC = segue.destinationViewController as! DetailVC
            destViewController.object = postsArray[(selectedRowIndex?.row)!] 
            
            
        }
    
    }


    func fetchAllObjectsFromLocalDataStore() {
        //empty postArray
        postsArray = []
        
        //bring data from parse
        let query = PFQuery(className: "Posts")
        //query.fromLocalDatastore()
        query.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                for object in objects! {
                    
                    self.postsArray.append(object)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    })
                }
            }else{
                print(error?.localizedDescription)
                
            }
        }

        }
    
}


