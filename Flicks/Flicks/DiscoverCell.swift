//
//  CollectionViewCell.swift
//  Flicks
//
//  Created by Gelei Chen on 9/1/2016.
//  Copyright © 2016 geleichen. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: KMGillSansLightLabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UITextView! {
        didSet{
            self.descriptionLabel.sizeToFit()
        }
    }
}
