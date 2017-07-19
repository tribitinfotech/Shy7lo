//
//  filterCell.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 27/12/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit

class filterCell: UITableViewCell {

    
    @IBOutlet weak var lblFilterType: UILabel!
    @IBOutlet weak var lblSelectedFilters: UILabel!
    @IBOutlet weak var btnCategory: UIButton!
    
    @IBOutlet weak var viewFilter: UIView!
    
    
    func setUpUI()
    {
        if isEnglish {
         
            self.viewFilter.transform = CGAffineTransform.identity
            self.lblSelectedFilters.transform = CGAffineTransform.identity
            self.lblFilterType.transform = CGAffineTransform.identity
            
            lblFilterType.textAlignment = .left
            lblSelectedFilters.textAlignment = .left
        }
        else{
            
            self.viewFilter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblSelectedFilters.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblFilterType.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            lblFilterType.textAlignment = .right
            lblSelectedFilters.textAlignment = .right
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
