//
//  ResultCell.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 4/18/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let theWidth = UIScreen.mainScreen().bounds.width
        
//        contentView.frame = CGRectMake(0, 0, theWidth, 80)
        
//        profileImg.center = CGPointMake(60, 40)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
//        profileNameLabel.center = CGPointMake(230, 55)
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
