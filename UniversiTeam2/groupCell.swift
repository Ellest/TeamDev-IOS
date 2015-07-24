//
//  groupCell.swift
//  UniversiTeam
//
//  Created by Jin Seok Park on 2015. 6. 7..
//  Copyright (c) 2015년 Jin Seok Park. All rights reserved.
//

import UIKit

class groupCell: UICollectionViewCell {

    @IBOutlet weak var plusSign: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true

    }

}
