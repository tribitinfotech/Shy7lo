//
//  cellPaymentMethod.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellPaymentMethod: UITableViewCell {

    @IBOutlet weak var imgInstructionBack: UIImageView!
    @IBOutlet weak var imgBottom: NSLayoutConstraint!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var btnPaymentIcon: UIButton!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var btnPaymentMethod: UIButton!
    
    
    @IBOutlet weak var bottomInstruction: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpUI()
    {
        self.imgInstructionBack.layer.cornerRadius = 0
        self.imgInstructionBack.layer.borderWidth = 1
        self.imgInstructionBack.layer.borderColor = UIColor.black.cgColor
        
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblPaymentMethod.transform = CGAffineTransform.identity
            self.btnPaymentMethod.transform = CGAffineTransform.identity
            self.btnPaymentIcon.transform = CGAffineTransform.identity
            self.lblPaymentMethod.textAlignment = .left
            
            self.lblInstruction.transform = CGAffineTransform.identity
            self.lblInstruction.textAlignment = .left
        }                                                                                                                                                                      
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblPaymentMethod.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnPaymentIcon.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblPaymentMethod.textAlignment = .right
            
            self.lblInstruction.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblInstruction.textAlignment = .right

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
