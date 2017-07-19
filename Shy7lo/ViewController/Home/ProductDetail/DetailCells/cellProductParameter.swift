//
//  cellProductDetail.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 13/01/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellProductParameter: UITableViewCell {

    @IBOutlet weak var viewInfo: UIView!
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    func setUpUI()
    {
        if isEnglish
        {
            viewInfo.transform = CGAffineTransform.identity
            lblValue.transform = CGAffineTransform.identity
            lblTitle.transform = CGAffineTransform.identity
            
            lblValue.textAlignment = .left
            lblTitle.textAlignment = .left
        }
        else
        {
            viewInfo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblValue.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            lblValue.textAlignment = .right
            lblTitle.textAlignment = .right
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