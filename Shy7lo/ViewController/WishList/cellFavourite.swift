//
//  cellFavourite.swift
//  Shy7lo
//
//  Created by Jitendra bhadja on 11/05/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellFavourite: UITableViewCell {

    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var topOldPrice: NSLayoutConstraint!
    @IBOutlet weak var lblPriceSeperator: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    func setUpUI()
    {
        if isEnglish
        {
            viewCell.transform = CGAffineTransform.identity
            lblPrice.transform = CGAffineTransform.identity
            lblOldPrice.transform = CGAffineTransform.identity
            lblBrandName.transform = CGAffineTransform.identity
            lblProductName.transform = CGAffineTransform.identity
            imgProduct.transform = CGAffineTransform.identity
            
            lblPrice.textAlignment = .right
            lblOldPrice.textAlignment = .right
            lblBrandName.textAlignment = .left
            lblProductName.textAlignment = .left
            
           // topOldPrice.constant = 22
        }
        else
        {
            viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblOldPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblBrandName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblProductName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            imgProduct.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            lblPrice.textAlignment = .left
            lblOldPrice.textAlignment = .left
            lblBrandName.textAlignment = .right
            lblProductName.textAlignment = .right
            
           // topOldPrice.constant = 15
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
