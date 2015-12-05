//
//  MyPostPF.swift
//  bany
//
//  Created by Lee Janghyup on 11/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MyPostPF : PFQueryTableViewController {
    
    var reachability : Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            
        }else{
            
            let myAlert = UIAlertController(title: "No network", message:
                "Your network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style:
                UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion:
                nil)
            
        }
        
    }
    func connectionChanged() {
        
        if reachability!.isReachable() {
            
        }else {
            let myAlert = UIAlertController(title: "No network", message: "Your network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }

    
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        parseClassName = "Posts"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parseClassName = "Posts"
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 20
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!)
        query.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)

        //query.whereKey("uploader", equalTo: (PFUser.currentUser()?.objectId)!)

        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        //if self.objects!.count == 0 {
        //  query.cachePolicy = .CacheThenNetwork
        // }
        
        query.orderByDescending("createdAt")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier = "myPostCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MyPostPfTVCE
        
        // Show sold label or not
        cell!.soldLabel.hidden = !(object!["sold"] as! Bool)
        
        
        // title Label of post
        cell!.titleLabel.text = " " + (object!["titleText"] as! String)
        
        // price label
        let price = (object!["priceText"] as! String)
        cell!.priceLabel.text = " $\(price)"
        
        
        
        // time label for posts
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM /dd /yy"
        cell!.timeLabel.text = (dateFormatter.stringFromDate(object!.createdAt!))
        
        
        //   main Image for post
        let mainImages = object!["front_image"] as! PFFile
        mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            let image = UIImage(data: imageData!)
            cell?.mainImageView.image = image
        }
        
        return cell
    }

    
        //    if cell == nil {
        //            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        //        }
        
        //        // Configure the cell to show todo item with a priority at the bottom
        //        if let object = object {
        //            cell!.textLabel?.text = object["titleText"] as? String
        //
        //        }
        
            override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailViewController = segue.destinationViewController
            as! DetailVC
        if segue.identifier == "MyPostToDetail"{
            let indexPath = self.tableView.indexPathForSelectedRow
            detailViewController.object = (self.objects![indexPath!.row] as! PFObject)
            print((self.objects![indexPath!.row] as! PFObject))
        }
        
        
    }
  
    
    
}