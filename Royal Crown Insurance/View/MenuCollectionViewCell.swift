//
//  MenuCollectionViewCell.swift
//  Royal Crown Insurance
//
//  Created by MineDest on 3/13/20.
//  Copyright © 2020 MineDest. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var menu: Menu? {
        didSet{
            nameLabel.text = menu?.name
            if let image = menu?.imageName{
                imageView.image = UIImage(named: image) 
            }
        }
    }
}
