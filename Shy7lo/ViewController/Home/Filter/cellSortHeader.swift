//
//  cellSortHeader.swift
//  Shy7lo
//
//  Created by Shy7lo Developer on 13/07/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellSortHeader: UITableViewCell {

    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewPopularity: UIView!
    @IBOutlet weak var btnPopularityIcon: UIButton!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var btnPopularity: UIButton!
    
    @IBOutlet weak var viewNew: UIView!
    @IBOutlet weak var btnNewIcon: UIButton!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var btnNew: UIButton!
    
    @IBOutlet weak var viewLowToHigh: UIView!
    @IBOutlet weak var btnLowToHighIcon: UIButton!
    @IBOutlet weak var lblLowToHigh: UILabel!
    @IBOutlet weak var btnLowToHigh: UIButton!
    
    @IBOutlet weak var viewHighToLow: UIView!
    @IBOutlet weak var btnHightoLowIcon: UIButton!
    @IBOutlet weak var lblHighToLow: UILabel!
    @IBOutlet weak var btnHighToLow: UIButton!
    
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var btnDiscountIcon: UIButton!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var btnDiscount: UIButton!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func setUpUI()
    {
        if isEnglish {
            
            self.viewCell.transform = CGAffineTransform.identity
            self.lblTitle.transform = CGAffineTransform.identity
            self.lblTitle.textAlignment = .left
            
            self.viewDiscount.transform = CGAffineTransform.identity
            self.viewNew.transform = CGAffineTransform.identity
            self.viewHighToLow.transform = CGAffineTransform.identity
            self.viewLowToHigh.transform = CGAffineTransform.identity
            self.viewPopularity.transform = CGAffineTransform.identity
            
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.textAlignment = .right
            
            self.viewDiscount.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewNew.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewHighToLow.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewLowToHigh.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewPopularity.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        }
        
        self.lblTitle.text = appDel.mapping?.string(forKey: "sort")
        
        self.lblNew.adjustsFontSizeToFitWidth = true
        self.lblDiscount.adjustsFontSizeToFitWidth = true
        self.lblHighToLow.adjustsFontSizeToFitWidth = true
        self.lblLowToHigh.adjustsFontSizeToFitWidth = true
        self.lblPopularity.adjustsFontSizeToFitWidth = true
        
        self.lblNew.text = appDel.mapping?.string(forKey: "New")
        self.lblDiscount.text = appDel.mapping?.string(forKey: "Discount")
        self.lblHighToLow.text = appDel.mapping?.string(forKey: "Price (High to Low)")
        self.lblLowToHigh.text = appDel.mapping?.string(forKey: "Price (Low to High)")
        self.lblPopularity.text = appDel.mapping?.string(forKey: "Popularity")
        
        self.lblTitle.font = UIFont(name: appDel.strFont, size: appDel.setFont(14.0))
        
        self.lblNew.font = UIFont(name: appDel.strFont, size: appDel.setFont(10.0))
        self.lblDiscount.font = UIFont(name: appDel.strFont, size: appDel.setFont(10.0))
        self.lblHighToLow.font = UIFont(name: appDel.strFont, size: appDel.setFont(10.0))
        self.lblLowToHigh.font = UIFont(name: appDel.strFont, size: appDel.setFont(10.0))
        self.lblPopularity.font = UIFont(name: appDel.strFont, size: appDel.setFont(10.0))
        
        switch appDel.filterSortIndex {
        case 1:
            
            self.btnPopularityIcon.isSelected = true
            self.btnNewIcon.isSelected = false
            self.btnHightoLowIcon.isSelected = false
            self.btnLowToHighIcon.isSelected = false
            self.btnDiscountIcon.isSelected = false
            
            self.lblPopularity.textColor = UIColor.black
            self.lblNew.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblHighToLow.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblLowToHigh.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblDiscount.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            
            break
        case 2:
            
            self.btnPopularityIcon.isSelected = false
            self.btnNewIcon.isSelected = true
            self.btnHightoLowIcon.isSelected = false
            self.btnLowToHighIcon.isSelected = false
            self.btnDiscountIcon.isSelected = false
            
            self.lblPopularity.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblNew.textColor = UIColor.black
            self.lblHighToLow.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblLowToHigh.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblDiscount.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            
            break
        case 3:
            
            self.btnPopularityIcon.isSelected = false
            self.btnNewIcon.isSelected = false
            self.btnHightoLowIcon.isSelected = false
            self.btnLowToHighIcon.isSelected = true
            self.btnDiscountIcon.isSelected = false
            
            self.lblPopularity.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblNew.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblHighToLow.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblLowToHigh.textColor = UIColor.black
            self.lblDiscount.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            
            break
        case 4:
            
            self.btnPopularityIcon.isSelected = false
            self.btnNewIcon.isSelected = false
            self.btnHightoLowIcon.isSelected = true
            self.btnLowToHighIcon.isSelected = false
            self.btnDiscountIcon.isSelected = false
            
            self.lblPopularity.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblNew.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblHighToLow.textColor = UIColor.black
            self.lblLowToHigh.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblDiscount.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            
            break
        case 5:
            
            self.btnPopularityIcon.isSelected = false
            self.btnNewIcon.isSelected = false
            self.btnHightoLowIcon.isSelected = false
            self.btnLowToHighIcon.isSelected = false
            self.btnDiscountIcon.isSelected = true
            
            self.lblPopularity.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblNew.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblHighToLow.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblLowToHigh.textColor = UIColor.init(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
            self.lblDiscount.textColor = UIColor.black
            
            break
        default:
            break
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
