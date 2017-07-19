//
//  cellCreditDebit.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 30/03/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class cellCreditDebit: UITableViewCell {

    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblStaticExpDate: UILabel!
    
    @IBOutlet weak var imgVIsaCard: UIImageView!
    @IBOutlet weak var lblStaticCVV: UILabel!
    @IBOutlet weak var lblStaticNameOnCard: UILabel!
    @IBOutlet weak var lblStaticCardNumber: UILabel!
    
    @IBOutlet weak var lblStaticNewsLetter: UILabel!
    @IBOutlet weak var lblStaticBillingAddress: UILabel!
    @IBOutlet weak var txtCardNumber: UITextField!
    
    @IBOutlet weak var btnExpirationDate: UIButton!
    @IBOutlet weak var txtNameOnCard: UITextField!
    @IBOutlet weak var btnExpirationYear: UIButton!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnBillingSameAsShipping: UIButton!
    @IBOutlet weak var btnRegisterNewLetter: UIButton!
    
    func setUpUI()
    {
        if isEnglish
        {
            self.viewCell.transform = CGAffineTransform.identity
            self.lblStaticCardNumber.transform = CGAffineTransform.identity
            self.txtCardNumber.transform = CGAffineTransform.identity
            self.lblStaticNameOnCard.transform = CGAffineTransform.identity
            self.txtNameOnCard.transform = CGAffineTransform.identity
            self.lblStaticExpDate.transform = CGAffineTransform.identity
            self.btnExpirationDate.transform = CGAffineTransform.identity
            self.btnExpirationYear.transform = CGAffineTransform.identity
            self.lblStaticCVV.transform = CGAffineTransform.identity
            self.txtCVV.transform = CGAffineTransform.identity
            self.imgVIsaCard.transform = CGAffineTransform.identity
            
            self.btnBillingSameAsShipping.transform = CGAffineTransform.identity
            self.btnRegisterNewLetter.transform = CGAffineTransform.identity
            
            self.lblStaticBillingAddress.transform = CGAffineTransform.identity
            self.lblStaticNewsLetter.transform = CGAffineTransform.identity
            
            self.btnExpirationDate.setBackgroundImage(UIImage.init(named: "ship_selectmonth.png"), for: UIControlState.normal)
            self.btnExpirationYear.setBackgroundImage(UIImage.init(named: "ship_selectmonth.png"), for: UIControlState.normal)
       
            self.lblStaticCardNumber.textAlignment = .left
            self.txtCardNumber.textAlignment = .left
            self.lblStaticNameOnCard.textAlignment = .left
            self.txtNameOnCard.textAlignment = .left
            self.lblStaticExpDate.textAlignment = .left
            self.btnExpirationDate.contentHorizontalAlignment = .left
            self.btnExpirationYear.contentHorizontalAlignment = .left
            self.lblStaticCVV.textAlignment = .left
            self.txtCVV.textAlignment = .left
            self.lblStaticBillingAddress.textAlignment = .left
            self.lblStaticNewsLetter.textAlignment = .left
            
        }
        else
        {
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticCardNumber.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtCardNumber.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticNameOnCard.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtNameOnCard.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticExpDate.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnExpirationDate.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnExpirationYear.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnExpirationDate.setBackgroundImage(UIImage.init(named: "ship_selectmonth_ar.png"), for: UIControlState.normal)
            self.btnExpirationYear.setBackgroundImage(UIImage.init(named: "ship_selectmonth_ar.png"), for: UIControlState.normal)
            
            self.lblStaticCVV.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtCVV.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            //self.imgVIsaCard.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnBillingSameAsShipping.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnRegisterNewLetter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticBillingAddress.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticNewsLetter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            
            self.lblStaticCardNumber.textAlignment = .right
            self.txtCardNumber.textAlignment = .right
            self.lblStaticNameOnCard.textAlignment = .right
            self.txtNameOnCard.textAlignment = .right
            self.lblStaticExpDate.textAlignment = .right
            self.btnExpirationDate.contentHorizontalAlignment = .center
            self.btnExpirationYear.contentHorizontalAlignment = .center
            self.lblStaticCVV.textAlignment = .right
            self.txtCVV.textAlignment = .right
            self.lblStaticBillingAddress.textAlignment = .right
            self.lblStaticNewsLetter.textAlignment = .right
            
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
