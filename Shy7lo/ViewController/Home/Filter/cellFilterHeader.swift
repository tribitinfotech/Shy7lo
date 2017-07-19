//
//  cellFilterHeader.swift
//  Shy7lo
//
//  Created by Shy7lo Developer on 13/07/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellFilterHeader: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var btnShowHide: UIButton!
    @IBOutlet weak var lblFilterHeader: UILabel!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setUpUI(isSelected:Bool)
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblFilterHeader.transform = CGAffineTransform.identity
            self.lblFilterHeader.textAlignment = .left
            
            if isSelected == true
            {
                self.lblFilterHeader.font = UIFont(name: appDel.strFont_Bold, size: appDel.setFont(14.0))
            }
            else
            {
                self.lblFilterHeader.font = UIFont(name: appDel.strFont, size: appDel.setFont(14.0))
            }
            
            
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblFilterHeader.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblFilterHeader.textAlignment = .right
            
            if isSelected == true
            {
                self.lblFilterHeader.font = UIFont(name: appDel.strFontKufi_Bold, size: appDel.setFont(14.0))
            }
            else
            {
                self.lblFilterHeader.font = UIFont(name: appDel.strFontKufi, size: appDel.setFont(14.0))
            }
            
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
