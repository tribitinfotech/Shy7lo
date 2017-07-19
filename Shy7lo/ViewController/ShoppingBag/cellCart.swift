//
//  cellProductTitle.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 12/01/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellCart: UITableViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var btnSize: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewFavourite: UIView!
    @IBOutlet weak var viewRemove: UIView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var lblRemove: UILabel!
    @IBOutlet weak var lblSaveForLater: UILabel!
    @IBOutlet weak var quantityTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var viewCart: UIView!
    
    @IBOutlet weak var lblPriceSeperator: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func updateUI()
    {
        if isEnglish {
            
            
           
            
            self.viewCart.transform = CGAffineTransform.identity
            
            //self.viewFavourite.transform = CGAffineTransform.identity
            //self.viewRemove.transform = CGAffineTransform.identity
            
            self.lblProductName.transform = CGAffineTransform.identity
            self.lblBrandName.transform = CGAffineTransform.identity
            self.lblPrice.transform = CGAffineTransform.identity
            self.imgProduct.transform = CGAffineTransform.identity
            self.btnSize.transform = CGAffineTransform.identity
            self.lblQuantity.transform = CGAffineTransform.identity
            
            self.lblSaveForLater.transform = CGAffineTransform.identity
            self.lblRemove.transform = CGAffineTransform.identity
            
            self.lblOldPrice.transform = CGAffineTransform.identity
            self.lblOldPrice.textAlignment = .right
            
            self.lblProductName.textAlignment = .left
            self.lblPrice.textAlignment = .right
            self.lblBrandName.textAlignment = .left
            
            
          
        }
        else{
            
            self.viewCart.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewCart.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            //self.viewFavourite.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            //self.viewRemove.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblProductName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblBrandName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgProduct.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblQuantity.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSaveForLater.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblRemove.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            if UIScreen.main.bounds.size.width == 320 {
                self.lblPrice.adjustsFontSizeToFitWidth = true
            }
            
            self.lblOldPrice.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblOldPrice.textAlignment = .left
            
            self.lblProductName.textAlignment = .right
            self.lblPrice.textAlignment = .left
            self.lblBrandName.textAlignment = .right
            
        }
        
        self.lblRemove.text = appDel.mapping?.string(forKey: "Remove")
        self.lblSaveForLater.text = appDel.mapping?.string(forKey: "Save for later")
        
       
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
