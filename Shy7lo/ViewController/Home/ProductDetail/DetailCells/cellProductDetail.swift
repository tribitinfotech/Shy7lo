//
//  cellProductDetail.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 13/01/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellProductDetail: UITableViewCell {

    
    @IBOutlet weak var lblDetailStatic: UILabel!
    @IBOutlet weak var txtViewDetail: UITextView!
    @IBOutlet weak var lblProductDetail: UILabel!
    @IBOutlet weak var wbView: UIWebView!
    @IBOutlet weak var heightWbVIew: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
