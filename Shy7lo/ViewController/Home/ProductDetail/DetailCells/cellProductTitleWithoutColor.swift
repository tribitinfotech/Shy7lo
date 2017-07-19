//
//  cellProductTitle.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 12/01/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellProductTitleWithoutColor: UITableViewCell {

    @IBOutlet weak var viewInfo: UIView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblStaticSize: UILabel!
    @IBOutlet weak var btnStaticSize: UIButton!
    
    @IBOutlet weak var lblPriceSeperator: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var topSpecialPrice: NSLayoutConstraint!
    @IBOutlet weak var heightOldPrice: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpUI()
    {
        if isEnglish
        {
            viewInfo.transform = CGAffineTransform.identity
            lblPrice.transform = CGAffineTransform.identity
            lblName.transform = CGAffineTransform.identity
            lblStaticSize.transform = CGAffineTransform.identity
            btnStaticSize.transform = CGAffineTransform.identity
            
            self.lblOldPrice.transform = CGAffineTransform.identity
            self.lblOldPrice.textAlignment = .left
            
            lblPrice.textAlignment = .left
            lblStaticSize.textAlignment = .left
            lblName.textAlignment = .left
            
        }
        else
        {
            viewInfo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblStaticSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            btnStaticSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblOldPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblOldPrice.textAlignment = .right
            
            lblPrice.textAlignment = .right
            lblStaticSize.textAlignment = .left
            lblName.textAlignment = .right
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
