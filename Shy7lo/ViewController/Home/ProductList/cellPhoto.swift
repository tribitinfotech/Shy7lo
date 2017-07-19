//
//  cellPhoto.swift
//  PriorityApp
//
//  Created by Jitendra Bhadja on 30/06/16.
//  Copyright © 2016 Jitendra Bhadja. All rights reserved.
//

import UIKit

class cellPhoto: UICollectionViewCell {

    @IBOutlet var btnPhoto: UIButton!
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblNotSoldPrice: UILabel!
    @IBOutlet weak var lblSoldPrice: UILabel!
    @IBOutlet weak var lblSeprator: UILabel!
    @IBOutlet weak var lblNotSoldCenter: NSLayoutConstraint!
    @IBOutlet weak var trailingNotSold: NSLayoutConstraint!
    
    @IBOutlet weak var lblNotSoldWidth: NSLayoutConstraint!
    @IBOutlet weak var lblSoldCenter: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
