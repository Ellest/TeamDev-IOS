//
//  messageCell.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 5/20/15.
//  Copyright (c) 2015 Jin Seok Park. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true


    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
