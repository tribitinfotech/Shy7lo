//
//  cellOrder.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 11/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellOrder: UITableViewCell {

 
    @IBOutlet weak var lblStaticPrice: UILabel!
    @IBOutlet weak var lblSpecialPrice: UILabel!

    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var heightSize: NSLayoutConstraint!
    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblProductName.transform = CGAffineTransform.identity
            self.lblBrandName.transform = CGAffineTransform.identity
            self.lblSize.transform = CGAffineTransform.identity
            self.lblQuantity.transform = CGAffineTransform.identity
            self.lblPrice.transform = CGAffineTransform.identity
            self.lblSpecialPrice.transform = CGAffineTransform.identity
            self.lblStaticPrice.transform = CGAffineTransform.identity
            self.imgProduct.transform = CGAffineTransform.identity

            
            self.lblProductName.textAlignment = .left
            self.lblBrandName.textAlignment = .left
            self.lblSize.textAlignment = .left
            self.lblQuantity.textAlignment = .left
            self.lblPrice.textAlignment = .left
            self.lblSpecialPrice.textAlignment = .left
            self.lblStaticPrice.textAlignment = .left
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblProductName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblBrandName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblQuantity.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblSpecialPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgProduct.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            
            self.lblProductName.textAlignment = .right
            self.lblBrandName.textAlignment = .right
            self.lblSize.textAlignment = .right
            self.lblQuantity.textAlignment = .right
            self.lblPrice.textAlignment = .right
            self.lblSpecialPrice.textAlignment = .right
            self.lblStaticPrice.textAlignment = .right
            
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
