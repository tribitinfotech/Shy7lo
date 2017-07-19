//
//  cellSubTotal.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellCartItemAmount: UITableViewCell {

    @IBOutlet weak var widthAmount: NSLayoutConstraint!
    @IBOutlet weak var topInstruction: NSLayoutConstraint!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblAmount.transform = CGAffineTransform.identity
            self.lblInstruction.transform = CGAffineTransform.identity
            
            self.lblInstruction.textAlignment = .left
            self.lblAmount.textAlignment = .right
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblAmount.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblInstruction.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.topInstruction.constant = 8.0
            
            self.lblInstruction.textAlignment = .right
            self.lblAmount.textAlignment = .left
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
