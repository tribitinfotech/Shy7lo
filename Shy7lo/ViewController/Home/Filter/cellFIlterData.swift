//
//  cellSortParameter.swift
//  Shy7lo
//
//  Created by Jitendra bhadja on 29/04/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellFIlterData: UITableViewCell {

    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblSortParameter: UIButton!
    @IBOutlet weak var imgSortIcon: UIImageView!
    
     var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblSortParameter.transform = CGAffineTransform.identity
            self.imgCheckMark.transform = CGAffineTransform.identity
            self.lblSortParameter.titleLabel?.textAlignment = .right
            
            self.lblSortParameter.titleLabel?.font = UIFont(name: appDel.strFont, size: appDel.setFont(13.0))
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblSortParameter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckMark.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblSortParameter.contentHorizontalAlignment = .right
            
            self.lblSortParameter.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: appDel.setFont(13.0))
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
