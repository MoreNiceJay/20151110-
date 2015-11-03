//
//  MainTVCE.swift
//  bany
//
//  Created by Lee Janghyup on 9/30/15.
//  Copyright © 2015 jay. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class MainTVCE: PFTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
        
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var mainPhoto: UIImageView!
    
    @IBOutlet weak var commentButton: UIButton!
    var didRequestToShowComment:((cell:UITableViewCell) -> ())?
    
       
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func commentButtonTapped(sender: AnyObject) {
        
        if self.didRequestToShowComment != nil {
            self.didRequestToShowComment!(cell: self) // self is this UITableViewCell
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
