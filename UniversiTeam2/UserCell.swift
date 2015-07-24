//
//  UserCell.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 13..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileNameLabel2: UILabel!
    @IBOutlet weak var profileImg2: UIImageView!
    @IBOutlet weak var userNameLabel2: UILabel!
    
    var chosenCell: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImg2.layer.cornerRadius = profileImg2.frame.size.width/2
        profileImg2.clipsToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
