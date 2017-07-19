//
//  cellCoupenCode.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellCoupenCode: UITableViewCell {

    @IBOutlet weak var heightCoupenCode: NSLayoutConstraint!
    @IBOutlet weak var btnAddCoupenCode: UIButton!
    @IBOutlet weak var lblCoupenCode: UILabel!
    @IBOutlet weak var txtCoupenCode: UITextField!
    
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var viewCell: UIView!
    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblCoupenCode.transform = CGAffineTransform.identity
            self.txtCoupenCode.transform = CGAffineTransform.identity
            self.btnStatus.transform = CGAffineTransform.identity
            self.txtCoupenCode.textAlignment = .left
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblCoupenCode.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtCoupenCode.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnStatus.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtCoupenCode.textAlignment = .right
            
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
