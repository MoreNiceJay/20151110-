//
//  CommentTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 10/14/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class CommentTVCE: UITableViewCell {

    var object : PFObject!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    var didRequestToShowComment:((cell:UITableViewCell) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        
        
    


  
}
