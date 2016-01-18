//
//  TermsOfUse.swift
//  bany
//
//  Created by Lee Janghyup on 11/2/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit

class TermsOfUse: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    
    }
