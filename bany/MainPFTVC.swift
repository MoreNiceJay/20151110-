//
//  parsePractice.swift
//  bany
//
//  Created by Lee Janghyup on 10/31/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainPFTVC : PFQueryTableViewController {
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
  
      var reachability : Reachability?
    var category : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do{ let reachability = try Reachability.reachabilityForInternetConnection()
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            
        }
        catch {}

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "connectionChanged", name: ReachabilityChangedNotification, object: nil)
        
        
        // navigation bar extender
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if reachability?.isReachable() == true
        {
            
        }else{
            
            let myAlert = UIAlertController(title: "No network", message:
                "Network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style:
                UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion:
                nil)
           
        }
        
    }
    
    
    @IBAction func categorySegmentTapped(sender: AnyObject) {
       
        
        switch sender.selectedSegmentIndex {
        case 0:
            category = 0
        case 1:
            category = 1
        default:
            category = 2
            tableView.reloadData()
        }
        
        
        
      
    
    func connectionChanged() {
        
        if reachability!.isReachable() {
            
        }else {
            let myAlert = UIAlertController(title: "No network", message: "Network is not working", preferredStyle:
                UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if category == 0{
            
            query.whereKey("category", equalTo : 0)
        
        }
        query.orderByDescending("createdAt")
        
        return query
    }
    
    func queryForCategoryTable( category : Int ) -> PFQuery {
       
        
        let query = PFQuery(className: self.parseClassName!)
        
       query.whereKey("category", equalTo : category)
        query.orderByDescending("createdAt")
        
        
        
        return query
        
        tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier = "mainCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MainPFTVCE
        
        // Show sold label or not
        cell!.soldLabel.hidden = !(object!["sold"] as! Bool)
        
        
        // title Label of post      
        cell!.titleLabel.text = " " + (object!["titleText"] as! String)
        
        // price label
        let price = (object!["priceText"] as! String)
        cell!.priceLable.text = "$\(price)"
        

        
        // time label for posts
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM /dd /yy"
        cell!.timeLabel.text = (dateFormatter.stringFromDate(object!.createdAt!))
        
        
      //   main Image for post
        let mainImages = object!["front_image"] as! PFFile
        mainImages.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            let image = UIImage(data: imageData!)
            cell?.mainPhoto.image = image
        }
        
       
//    if cell == nil {
//            cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
//        }
        
//        // Configure the cell to show todo item with a priority at the bottom
//        if let object = object {
//            cell!.textLabel?.text = object["titleText"] as? String
//            
//        }
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let detailViewController = segue.destinationViewController
            as! DetailVC
        if segue.identifier == "mainToDetail"{
         let indexPath = self.tableView.indexPathForSelectedRow
            detailViewController.object = (self.objects![indexPath!.row] as! PFObject)
        
        }
        
            
    }
    
    
    
  
}