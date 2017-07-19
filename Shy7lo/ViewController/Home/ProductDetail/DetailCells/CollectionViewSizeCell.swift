//
//  CollectionViewSizeCell.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 26/01/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class CollectionViewSizeCell: UICollectionViewCell {

    @IBOutlet weak var viewSize: UIView!
     @IBOutlet weak var lblSize: UILabel!
    
    func setUpUI()
    {
        if isEnglish
        {
            lblSize.transform = CGAffineTransform.identity
     
        }
        else
        {
            lblSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        
        }
    }
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

}
