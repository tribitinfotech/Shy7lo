//
//  cellSubTotal.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellSubTotal: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    @IBOutlet weak var lblIncludeDuties: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    
    func setUpUI()
    {
        self.lblInstruction.adjustsFontSizeToFitWidth = true
        
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblAmount.transform = CGAffineTransform.identity
            self.lblInstruction.transform = CGAffineTransform.identity
            self.lblIncludeDuties.transform = CGAffineTransform.identity
            
            self.btnBack.transform = CGAffineTransform.identity
            self.btnBuyNow.transform = CGAffineTransform.identity
            
            self.lblIncludeDuties.textAlignment = .right
            
            self.lblInstruction.textAlignment = .left
            self.lblAmount.textAlignment = .right
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblAmount.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblInstruction.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblIncludeDuties.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnBack.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnBuyNow.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblIncludeDuties.textAlignment = .left
            
            self.lblInstruction.textAlignment = .right
            self.lblAmount.textAlignment = .left
            
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
