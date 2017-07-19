//
//  cellShippingAddress.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellShippingAddress: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblName.transform = CGAffineTransform.identity
            self.lblAddress.transform = CGAffineTransform.identity
            self.lblShippingAddress.transform = CGAffineTransform.identity
            self.imgBottom.transform = CGAffineTransform.identity
            
            self.btnBack.transform = CGAffineTransform.identity
            self.btnBuyNow.transform = CGAffineTransform.identity
            
            self.lblName.textAlignment = .left
            self.lblAddress.textAlignment = .left
            self.lblShippingAddress.textAlignment = .left
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblAddress.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblShippingAddress.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgBottom.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnBack.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnBuyNow.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblName.textAlignment = .right
            self.lblAddress.textAlignment = .right
            self.lblShippingAddress.textAlignment = .right
            
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
