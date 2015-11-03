//
//  Data.swift
//  bany
//
//  Created by Lee Janghyup on 10/28/15.
//  Copyright © 2015 jay. All rights reserved.
//

import Parse

func bringAllDatafromParse() {
       var postsArray = [PFObject]()
        
        
        //bring data from parse
        let query = PFQuery(className: "Posts")
        // query.cachePolicy = PFCachePolicy.NetworkOnly
        query.orderByAscending("createdAt")
    
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) -> Void in
            if error == nil && objects != nil{
                for object in objects! {
                    
                    postsArray.append(object)
                }
                
            }
        
        }
}