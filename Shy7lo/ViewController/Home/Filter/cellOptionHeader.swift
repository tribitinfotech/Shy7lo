//
//  cellOptionHeader.swift
//  Shy7lo
//
//  Created by Shy7lo Developer on 13/07/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellOptionHeader: UITableViewCell {

    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btngrid: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setUpUI()
    {
        if isEnglish {
            
            self.viewCell.transform = CGAffineTransform.identity
            self.lblTitle.transform = CGAffineTransform.identity
            self.lblTitle.textAlignment = .left
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.textAlignment = .right
        }
        
        self.lblTitle.text = appDel.mapping?.string(forKey: "view")
        self.lblTitle.font = UIFont(name: appDel.strFont, size: appDel.setFont(14.0))
        
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
