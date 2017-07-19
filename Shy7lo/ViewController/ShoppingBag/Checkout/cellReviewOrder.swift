//
//  cellReviewOrder.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellReviewOrder: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblReviewOrder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblReviewOrder.transform = CGAffineTransform.identity
            
            self.lblReviewOrder.textAlignment = .left
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblReviewOrder.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblReviewOrder.textAlignment = .right
            
        }
        
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
