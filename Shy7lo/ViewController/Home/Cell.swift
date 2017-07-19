//
//  Cell.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 01/09/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpUI()
    {
        if isEnglish
        {
            lblTitle.transform = CGAffineTransform.identity
            viewTitle.transform = CGAffineTransform.identity
            lblTitle.textAlignment = .left
        }
        else
        {
            lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            viewTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            lblTitle.textAlignment = .right
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var viewTitle: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
