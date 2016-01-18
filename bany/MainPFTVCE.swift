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
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var mainPhoto: UIImageView!


    @IBOutlet weak var classLabel: UILabel!
    
    @IBOutlet weak var hardnessLabel: UILabel!
    
    @IBOutlet weak var assignment: UILabel!
    @IBOutlet weak var attendance: UILabel!
    
    @IBOutlet weak var textBookRQDLabel: UILabel!
    
    @IBOutlet weak var moreToSay: UILabel!
    
    @IBOutlet weak var soldImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
