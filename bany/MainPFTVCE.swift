//
//  parseCell.swift
//  bany
//
//  Created by Lee Janghyup on 11/1/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainPFTVCE: PFTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
