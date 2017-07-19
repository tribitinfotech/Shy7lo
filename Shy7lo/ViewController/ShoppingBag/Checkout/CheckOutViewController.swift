//
//  CheckOutViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 21/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class CheckOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var viewPickerTop: UIView!
    @IBOutlet weak var viewShipment: UIView!
    @IBOutlet weak var btnShipment: UIButton!
    
    @IBOutlet weak var btnReviewPay: UIButton!
    
    @IBOutlet weak var scrlShipment: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var scrlReviewAndPay: TPKeyboardAvoidingScrollView!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtLastSevenDigit: UITextField!
    
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var btnCountryCode: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var btnPickerDone: UIButton!
    @IBOutlet weak var btnPickerCancel: UIButton!
    
    @IBOutlet weak var viewPickerBg: UIView!
    @IBOutlet weak var normalPicker: UIPickerView!
    
    var arrExpiryMonth:NSMutableArray = NSMutableArray()
    var arrExpiryYear:NSMutableArray = NSMutableArray()
    
    var isFromAddCoupen:Bool = false
    var isFromSetPaymentMethod:Bool = false
    var strSelectedCode:String = ""
    
    var isRegisterNewsLetter:Bool = false
    var isSameShippingAddress:Bool = false
    
    var strCoupenCode:String = ""
    
    var strCardNumber:String = ""
    var strNameOnCard:String = ""
    var strCVV:String = ""
    var strExpiryYear:String = ""
    var strExpiryMonth:String = ""
    
    var sdk_token:String = ""
    
    var orderId:String = ""
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var arrReview:NSMutableArray = NSMutableArray()
    
    var isComingFromGuest:Bool?
    
    var HUD : MBProgressHUD?
    
    let PayFort:PayFortController  = PayFortController.init(enviroment: KPayFortEnviromentProduction)
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var viewMenu: UIView!
    
    @IBOutlet weak var btnOne: UIButton!
    
    @IBOutlet weak var btnTwo: UIButton!
    
    
    @IBOutlet weak var imgBottom: UIImageView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnStaticProceedPayment: UIButton!
    @IBOutlet weak var lblStaticRequiredFields: UILabel!
    @IBOutlet weak var lblStaticCity: UILabel!
    @IBOutlet weak var lblStaticAddress: UILabel!
    @IBOutlet weak var lblStaticLastSevenDigit: UILabel!
    @IBOutlet weak var lblStaticCountryCode: UILabel!
    @IBOutlet weak var lblStaticContactNumber: UILabel!
    @IBOutlet weak var lblStaticFullName: UILabel!
    @IBOutlet weak var lblStaticLastName: UILabel!
    
    @IBOutlet weak var lblStaticReviewAndPay: UILabel!
    @IBOutlet weak var lblStaticCheckout: UILabel!
    
    @IBOutlet weak var lblStaticShipment: UILabel!
    //View review & pay
    
    @IBOutlet weak var tblReviewAndPay: UITableView!
  
   //MARK:- View life cycle
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if appDel.isLanguageChanged == true && self.scrlReviewAndPay.isHidden == false
        {
            
            appDel.isLanguageChanged = false
            
            self.HUD?.show(true)
            
            self.getPaymentMethod()
        }
        else
        {
            appDel.isLanguageChanged = false
        }
        
        self.lblEmail.text = "\((appDel.mapping?.string(forKey: "Email"))!) : \((UserDefaults.standard.value(forKey: "userEmail") as? String)!)"
        
        if isEnglish {
            
            self.imgLogo.image = UIImage(named: "ic_top_logo.png")
            
            self.lblStaticShipment.font = UIFont(name: appDel.strFont, size: 11.0)
            
            self.lblStaticReviewAndPay.font = UIFont(name: appDel.strFont_Bold, size: 11.0)
            
            self.lblStaticCheckout.font = UIFont(name: appDel.strFont_Bold, size: 19.0)
            
            self.lblEmail.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.lblContact.font = UIFont(name: appDel.strFont, size: 17.0)
            
            self.lblStaticFullName.font = UIFont(name: appDel.strFont, size: 15.0)
            self.lblStaticLastName.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.txtFullName.font = UIFont(name: appDel.strFont, size: 14.0)
            self.txtLastName.font = UIFont(name: appDel.strFont, size: 14.0)
            
            self.lblStaticContactNumber.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.lblStaticCountryCode.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.lblStaticLastSevenDigit.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.btnCountryCode.font =  UIFont(name: appDel.strFont, size: 14.0)
            
            self.txtLastSevenDigit.font = UIFont(name: appDel.strFont, size: 14.0)
            
            self.lblStaticAddress.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.lblStaticCity.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.txtAddress.font = UIFont(name: appDel.strFont, size: 14.0)
            
            self.txtCity.font = UIFont(name: appDel.strFont, size: 14.0)
            
            self.lblStaticRequiredFields.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.btnStaticProceedPayment.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 15.0)
            
            self.viewTop.transform = CGAffineTransform.identity
            self.viewPhoneNumber.transform = CGAffineTransform.identity
            
            self.viewPickerTop.transform = CGAffineTransform.identity
            self.btnPickerCancel.transform = CGAffineTransform.identity
            self.btnPickerDone.transform = CGAffineTransform.identity
            
            
            self.imgLogo.transform = CGAffineTransform.identity
            self.lblStaticCheckout.transform = CGAffineTransform.identity
            
            self.viewMenu.transform = CGAffineTransform.identity
            self.btnOne.transform = CGAffineTransform.identity
            self.btnTwo.transform = CGAffineTransform.identity
            self.lblStaticShipment.transform = CGAffineTransform.identity
            self.lblStaticReviewAndPay.transform = CGAffineTransform.identity
            self.lblContact.transform = CGAffineTransform.identity
            
            self.viewShipment.transform = CGAffineTransform.identity
            self.lblEmail.transform = CGAffineTransform.identity
            self.lblStaticFullName.transform = CGAffineTransform.identity
            self.lblStaticLastName.transform = CGAffineTransform.identity
            self.txtFullName.transform = CGAffineTransform.identity
            self.txtLastName.transform = CGAffineTransform.identity
            self.lblStaticContactNumber.transform = CGAffineTransform.identity
            self.lblStaticCountryCode.transform = CGAffineTransform.identity
            self.lblStaticLastSevenDigit.transform = CGAffineTransform.identity
            self.btnCountryCode.transform = CGAffineTransform.identity
            self.txtLastSevenDigit.transform = CGAffineTransform.identity
            self.lblStaticAddress.transform = CGAffineTransform.identity
            self.txtAddress.transform = CGAffineTransform.identity
            self.lblStaticCity.transform = CGAffineTransform.identity
            self.txtCity.transform = CGAffineTransform.identity
            self.lblStaticRequiredFields.transform = CGAffineTransform.identity
            self.btnStaticProceedPayment.transform = CGAffineTransform.identity
            self.imgBottom.transform = CGAffineTransform.identity
            
            self.lblEmail.textAlignment = .left
            self.lblStaticFullName.textAlignment = .left
            self.lblStaticLastName.textAlignment = .left
            self.txtFullName.textAlignment = .left
            self.txtLastName.textAlignment = .left
            self.lblStaticContactNumber.textAlignment = .left
            self.lblStaticCountryCode.textAlignment = .left
            self.lblStaticLastSevenDigit.textAlignment = .left
            self.btnCountryCode.textAlignment = .left
            self.txtLastSevenDigit.textAlignment = .left
            self.lblStaticAddress.textAlignment = .left
            self.txtAddress.textAlignment = .left
            self.lblStaticCity.textAlignment = .left
            self.txtCity.textAlignment = .left
            self.lblStaticRequiredFields.textAlignment = .left
            
        }
        else
        {
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            
            self.lblStaticShipment.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            
            self.lblStaticReviewAndPay.font = UIFont(name: appDel.strFontKufi_Bold, size: 11.0)
            
            self.lblStaticCheckout.font = UIFont(name: appDel.strFontKufi_Bold, size: 19.0)
            
            self.lblEmail.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.lblContact.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            
            self.lblStaticFullName.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.lblStaticLastName.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.txtFullName.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.txtLastName.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.lblStaticContactNumber.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.lblStaticCountryCode.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.lblStaticLastSevenDigit.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.btnCountryCode.font =  UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.txtLastSevenDigit.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.lblStaticAddress.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.lblStaticCity.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.txtAddress.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.txtCity.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            self.lblStaticRequiredFields.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.btnStaticProceedPayment.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 15.0)
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewPhoneNumber.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            /*self.lblStaticCountryCode.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
             self.lblStaticLastSevenDigit.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
             self.btnCountryCode.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
             self.txtLastSevenDigit.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)*/
            
            self.viewPickerTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnPickerCancel.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnPickerDone.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.imgLogo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticCheckout.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblContact.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnOne.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnTwo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticShipment.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticReviewAndPay.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewShipment.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblEmail.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticFullName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticLastName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtFullName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtLastName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticContactNumber.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticAddress.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtAddress.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticCity.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtCity.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticRequiredFields.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnStaticProceedPayment.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgBottom.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            
            self.lblEmail.textAlignment = .right
            self.lblStaticFullName.textAlignment = .right
            self.lblStaticLastName.textAlignment = .right
            self.txtFullName.textAlignment = .right
            self.txtLastName.textAlignment = .right
            self.lblStaticContactNumber.textAlignment = .right
            self.lblStaticCountryCode.textAlignment = .right
            self.lblStaticLastSevenDigit.textAlignment = .right
            self.btnCountryCode.textAlignment = .left
            self.txtLastSevenDigit.textAlignment = .left
            self.lblStaticAddress.textAlignment = .right
            self.txtAddress.textAlignment = .right
            self.lblStaticCity.textAlignment = .right
            self.txtCity.textAlignment = .right
            self.lblStaticRequiredFields.textAlignment = .left
            
            self.tblReviewAndPay.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, UIScreen.main.bounds.size.width - 10)
        }
        
        self.lblStaticCheckout.text = appDel.mapping?.string(forKey: "Checkout")
        self.lblStaticShipment.text = appDel.mapping?.string(forKey: "Shipment")
        self.lblStaticReviewAndPay.text = appDel.mapping?.string(forKey: "Review & Pay")
        
        self.lblStaticFullName.text = appDel.mapping?.string(forKey: "First Name Checkout")
        self.lblStaticLastName.text = appDel.mapping?.string(forKey: "Last Name Checkout")
        self.lblStaticContactNumber.text = appDel.mapping?.string(forKey: "Contact number")
        self.lblStaticCountryCode.text = appDel.mapping?.string(forKey: "Country Code")
        self.lblStaticLastSevenDigit.text = appDel.mapping?.string(forKey: "Number(Last 7 digit)")
        self.lblStaticAddress.text = appDel.mapping?.string(forKey: "Address")
        self.lblStaticCity.text = appDel.mapping?.string(forKey: "City")
        self.lblStaticRequiredFields.text = appDel.mapping?.string(forKey: "Required fields")
        
        self.btnPickerDone.setTitle(appDel.mapping?.string(forKey: "Done"), for: UIControlState.normal)
        self.btnPickerCancel.setTitle(appDel.mapping?.string(forKey: "Cancel"), for: UIControlState.normal)
        
        self.btnStaticProceedPayment.setTitle(appDel.mapping?.string(forKey: "Proceed to payment"), for: UIControlState.normal)
        
        self.tblReviewAndPay.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAnalytics.logEvent(withName: "Checkout_address", parameters: ["name":"Checkout_address"])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(orderPlaced), name: Notification.Name("orderPlaced"), object: nil)

        self.btnCountryCode.text = UserDefaults.standard.value(forKey: "countryCode") as? String
        
        self.scrlShipment.isHidden = false
        self.scrlReviewAndPay.isHidden = true

        self.btnShipment.backgroundColor = UIColor(red: 30.0/255.0, green: 200.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.btnReviewPay.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.customizeTextfield(self.txtFullName)
        self.customizeTextfield(self.txtLastName)
        self.customizeTextfield(self.txtLastSevenDigit)
        self.customizeTextfield(self.txtAddress)
        self.customizeTextfield(self.txtCity)
        
        self.tblReviewAndPay.register(UINib(nibName: "cellOrder", bundle: nil), forCellReuseIdentifier: "cellOrder")
        self.tblReviewAndPay.register(UINib(nibName: "cellPaymentMethod", bundle: nil), forCellReuseIdentifier: "cellPaymentMethod")
        self.tblReviewAndPay.register(UINib(nibName: "cellCreditDebit", bundle: nil), forCellReuseIdentifier: "cellCreditDebit")
        self.tblReviewAndPay.register(UINib(nibName: "cellCoupenCode", bundle: nil), forCellReuseIdentifier: "cellCoupenCode")
        self.tblReviewAndPay.register(UINib(nibName: "cellSubTotal", bundle: nil), forCellReuseIdentifier: "cellSubTotal")
        self.tblReviewAndPay.register(UINib(nibName: "cellCartItemAmount", bundle: nil), forCellReuseIdentifier: "cellCartItemAmount")
        self.tblReviewAndPay.register(UINib(nibName: "cellReviewOrder", bundle: nil), forCellReuseIdentifier: "cellReviewOrder")
        self.tblReviewAndPay.register(UINib(nibName: "cellShippingAddress", bundle: nil), forCellReuseIdentifier: "cellShippingAddress")
        

        self.arrExpiryMonth = NSMutableArray()
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "January") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "Febuary") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "March") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "April") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "May") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "June") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "July") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "August") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "September") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "October") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "November") ?? "")
        self.arrExpiryMonth.add(appDel.mapping?.string(forKey: "December") ?? "")
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
        for i:NSInteger in year  ..< year + 50
        {
            self.arrExpiryYear.add(String(format: "%d",i))
        }
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let dict:NSMutableDictionary = self.arrReview.object(at: indexPath.row) as! NSMutableDictionary
        
        if dict.value(forKey: "type") as! String == "payment_method"
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellPaymentMethod", for: indexPath) as! cellPaymentMethod
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblPaymentMethod.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFont, size: 13.0)
                
            }
            else
            {
                cell.lblPaymentMethod.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFontKufi, size: 13.0)
            }
            
            if dict.value(forKey: "code") as! String == "banktransfer" {
                
                if dict.value(forKey: "isSelected") as! String == "0" {
                     cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_bank.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.black
                    
                    cell.lblInstruction.text = ""
                    cell.imgInstructionBack.isHidden = true
                    cell.bottomInstruction.constant = -5.0
                    
                }
                else
                {
                     cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg_select.png"), for: UIControlState.normal)
                    //cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_bank_selected.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_bank.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.white
                    
                    cell.lblInstruction.text = dict.value(forKey: "description") as? String
                    cell.imgInstructionBack.isHidden = false
                    cell.bottomInstruction.constant = 13.5
                }
               
            }
            else if dict.value(forKey: "code") as! String == "payfort_fort_cc"
            {
                if dict.value(forKey: "isSelected") as! String == "0" {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg.png"), for: UIControlState.normal)
                     cell.btnPaymentIcon.setImage(UIImage.init(named: "credit_debit_unselect.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.black
                    
                    cell.lblInstruction.text = ""
                    cell.imgInstructionBack.isHidden = true
                    cell.bottomInstruction.constant = -5.0
                }
                else
                {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg_select.png"), for: UIControlState.normal)
                    // cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_credit.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "credit_debit_unselect.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.white
                    
                    cell.lblInstruction.text = dict.value(forKey: "description") as? String
                    cell.imgInstructionBack.isHidden = false
                    cell.bottomInstruction.constant = 13.5
                }
            }
            else if dict.value(forKey: "code") as! String == "payfort_fort_sadad"
            {
                if dict.value(forKey: "isSelected") as! String == "0" {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_sada.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.black
                    
                    cell.lblInstruction.text = ""
                    cell.imgInstructionBack.isHidden = true
                    cell.bottomInstruction.constant = -5.0
                }
                else
                {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg_select.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_sada.png"), for: UIControlState.normal)
                    //cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_sada_selected.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.white
                    
                    cell.lblInstruction.text = dict.value(forKey: "description") as? String
                    cell.imgInstructionBack.isHidden = false
                    cell.bottomInstruction.constant = 13.5
                }
            }
            else if dict.value(forKey: "code") as! String == "shy7lo_paypal"
            {
                if dict.value(forKey: "isSelected") as! String == "0" {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "paypal.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.black
                    
                    cell.lblInstruction.text = ""
                    cell.imgInstructionBack.isHidden = true
                    cell.bottomInstruction.constant = -5.0
                }
                else
                {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg_select.png"), for: UIControlState.normal)
                   // cell.btnPaymentIcon.setImage(UIImage.init(named: "paypal_selected.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "paypal.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.white
                    
                    cell.lblInstruction.text = dict.value(forKey: "description") as? String
                    cell.imgInstructionBack.isHidden = false
                    cell.bottomInstruction.constant = 13.5
                }
            }
            else if dict.value(forKey: "code") as! String == "msp_cashondelivery"
            {
                if dict.value(forKey: "isSelected") as! String == "0" {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg.png"), for: UIControlState.normal)
                    cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_cashondelivery.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.black
                    
                    cell.lblInstruction.text = ""
                    cell.imgInstructionBack.isHidden = true
                    cell.bottomInstruction.constant = -5.0
                }
                else
                {
                    cell.btnPaymentMethod.setBackgroundImage(UIImage.init(named: "payment_bg_select.png"), for: UIControlState.normal)
                   // cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_cashondelivery_select.png"), for: UIControlState.normal)
                     cell.btnPaymentIcon.setImage(UIImage.init(named: "ship_cashondelivery.png"), for: UIControlState.normal)
                    cell.lblPaymentMethod.textColor = UIColor.white
                    
                    cell.lblInstruction.text = dict.value(forKey: "description") as? String
                    cell.imgInstructionBack.isHidden = false
                    cell.bottomInstruction.constant = 13.5
                }
            }
            
             //cell.lblPaymentMethod.text = (dict.value(forKey: "title") as! String).uppercased()
            cell.lblPaymentMethod.text = (appDel.mapping?.string(forKey: "\((dict.value(forKey: "code") as! String))"))!.uppercased()
             cell.btnPaymentMethod.tag = indexPath.row
             cell.btnPaymentMethod.addTarget(self, action: #selector(btnPaymentMethodAction(_:)), for: UIControlEvents.touchUpInside)
            
             cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            //trailing space of quantity
            
             cell.contentView.layoutIfNeeded()
             return cell
        }
        if dict.value(forKey: "type") as! String == "add_coupen"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCoupenCode", for: indexPath) as! cellCoupenCode
            
            if isEnglish {
                cell.lblCoupenCode.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.txtCoupenCode.font = UIFont(name: appDel.strFont, size: 14.0)
            }
            else
            {
                cell.lblCoupenCode.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                cell.txtCoupenCode.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            }

            cell.setUpUI()
            
            cell.txtCoupenCode.placeholder = appDel.mapping?.string(forKey: "Enter Coupen code")
            
            if dict.value(forKey: "editMode") as! String == "0"
            {
                cell.heightCoupenCode.constant = 0
            }
            else
            {
                cell.heightCoupenCode.constant = 35
            }
            
            if dict.value(forKey: "isApplied") as! String == "0"
            {
                cell.btnAddCoupenCode.setBackgroundImage(UIImage.init(named: "add.png"), for: UIControlState.normal)
                cell.btnAddCoupenCode.tag = indexPath.row
                cell.btnAddCoupenCode.addTarget(self, action: #selector(btnAddCoupenCode(_:)), for: UIControlEvents.touchUpInside)
                cell.btnStatus.addTarget(self, action: #selector(btnChangeStatusOfCoupen(_:)), for: UIControlEvents.touchUpInside)
                cell.btnStatus.tag = indexPath.row
                cell.txtCoupenCode.text = ""
                cell.btnStatus.setTitle(appDel.mapping?.string(forKey: "Validate"), for: UIControlState.normal)
            }
            else
            {
                cell.btnAddCoupenCode.setBackgroundImage(UIImage.init(named: "add.png"), for: UIControlState.normal)
                cell.btnAddCoupenCode.tag = indexPath.row
                cell.btnStatus.tag = indexPath.row
                cell.btnAddCoupenCode.addTarget(self, action: #selector(btnAddCoupenCode(_:)), for: UIControlEvents.touchUpInside)
                cell.btnStatus.setTitle(appDel.mapping?.string(forKey: "Remove coupen"), for: UIControlState.normal)
                cell.btnStatus.addTarget(self, action: #selector(btnChangeStatusOfCoupen(_:)), for: UIControlEvents.touchUpInside)
                cell.txtCoupenCode.text = self.strCoupenCode
            }
            
            self.customizeTextfield(cell.txtCoupenCode)
            
            cell.txtCoupenCode.delegate = self
            cell.txtCoupenCode.tag = 1
            
            //cell.lblCoupenCode.text = dict.value(forKey: "coupenCode") as? String
            cell.lblCoupenCode.text = self.appDel.mapping?.string(forKey: "Use coupen code")
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            //trailing space of quantity
            
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        
        if dict.value(forKey: "type") as! String == "sub_total"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCartItemAmount", for: indexPath) as! cellCartItemAmount
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblAmount.font = UIFont(name: appDel.strFont, size: 16.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFont, size: 16.0)
            }
            else
            {
                cell.lblAmount.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            }
            
            cell.lblAmount.text = String(format:"%0.2f %@",Float(dict.value(forKey: "value") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),(dict.value(forKey: "currency") as! String))
           
            cell.lblInstruction.text = dict.value(forKey: "title") as? String
           
            if !isEnglish {
                
                cell.widthAmount.constant = cell.lblAmount.intrinsicContentSize.width
                
                print(cell.widthAmount.constant)
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            //trailing space of quantity
            
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        
        if dict.value(forKey: "type") as! String == "total"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubTotal", for: indexPath) as! cellSubTotal
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblAmount.font = UIFont(name: appDel.strFont_Bold, size: 18.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFont_Bold, size: 18.0)
                
                cell.btnBack.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 14.0)
                cell.btnBuyNow.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 14.0)
                
                cell.lblIncludeDuties.font = UIFont(name: appDel.strFont, size: 11.0)
            }
            else
            {
                cell.lblAmount.font = UIFont(name: appDel.strFontKufi_Bold, size: 18.0)
                cell.lblInstruction.font = UIFont(name: appDel.strFontKufi_Bold, size: 18.0)
                
                cell.btnBack.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
                cell.btnBuyNow.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
                
                cell.lblIncludeDuties.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            }
            
            cell.lblAmount.text = String(format:"%0.2f %@",Float(dict.value(forKey: "value") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),(dict.value(forKey: "currency") as! String))
            
            cell.lblInstruction.text = dict.value(forKey: "title") as? String
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.btnBack.tag = indexPath.row
            cell.btnBack.addTarget(self, action: #selector(btnBackAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnBuyNow.tag = indexPath.row
            cell.btnBuyNow.addTarget(self, action: #selector(btnBuyNowAction(_:)), for: UIControlEvents.touchUpInside)
            
            
            cell.btnBack.setTitle(appDel.mapping?.string(forKey: "Back"), for: UIControlState.normal)
             cell.btnBuyNow.setTitle(appDel.mapping?.string(forKey: "Buy Now"), for: UIControlState.normal)
            cell.lblIncludeDuties.text = appDel.mapping?.string(forKey: "Include all duties")
            
            //trailing space of quantity
            
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        
        if dict.value(forKey: "type") as! String == "review_order"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellReviewOrder", for: indexPath) as! cellReviewOrder
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblReviewOrder.font = UIFont(name: appDel.strFont_Bold, size: 15.0)
            }
            else
            {
                cell.lblReviewOrder.font = UIFont(name: appDel.strFontKufi_Bold, size: 15.0)
            }
            
            cell.lblReviewOrder.text = appDel.mapping?.string(forKey: "Review your order")
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        if dict.value(forKey: "type") as! String == "order"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrder", for: indexPath) as! cellOrder
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblProductName.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
                
                cell.lblBrandName.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblSize.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblQuantity.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblPrice.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblSpecialPrice.font = UIFont(name: appDel.strFont, size: 14.0)
                cell.lblStaticPrice.font = UIFont(name: appDel.strFont, size: 14.0)
                
            }
            else
            {
                cell.lblProductName.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
                
                cell.lblBrandName.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                cell.lblSize.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                cell.lblQuantity.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                cell.lblPrice.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                cell.lblSpecialPrice.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                 cell.lblStaticPrice.font = UIFont(name: appDel.strFontKufi, size: 14.0)
                
            }
            
            
            //let strURL:String = String(format: "%@%@",IMAGE_URL_CART,dict.value(forKey: "image") as! String)
            
            let strURL:String = String(format: "%@",dict.value(forKey: "image") as! String)
            
            
            cell.imgProduct.sd_setImage(with:  NSURL(string: strURL) as URL!, placeholderImage: UIImage(named: "image_placeholder.png"), options: SDWebImageOptions.lowPriority)
            
            //cell.imgProduct.sd_setImage(with:  NSURL(string: dict.value(forKey: "image") as! String) as URL!, placeholderImage: UIImage(named: "image_placeholder.png"), options: SDWebImageOptions.lowPriority)
            
            cell.lblProductName.text = dict.value(forKey: "name") as? String
            cell.lblBrandName.text = dict.value(forKey: "brandName") as? String
            
            cell.lblStaticPrice.text = appDel.mapping?.string(forKey: "Price")
            
            if let price = dict.value(forKey: "special_price") as? String
            {
                
                let dateFormatter:DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let fromdate = dict.value(forKey: "special_from_date") as? String
                {
                    if let todate = dict.value(forKey: "special_to_date") as? String
                    {
                        let dateFrom = dateFormatter.date(from: dict.value(forKey: "special_from_date") as! String)!
                        // Get a later date (after a couple of milliseconds)
                        let dateTo = dateFormatter.date(from: dict.value(forKey: "special_to_date") as! String)!
                        
                        if NSDate().isBetweeen(date: dateFrom as NSDate, andDate: dateTo as NSDate) == true
                        {
                            cell.lblPrice.text = String(format: ": %0.2f %@",Float((dict.value(forKey: "special_price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            
                            cell.lblPrice.textColor = UIColor.red
                            
                            cell.lblSpecialPrice.text = String(format:"%0.2f %@",Float((dict.value(forKey: "price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            
                            cell.lblSpecialPrice.textColor = UIColor.black
                        }
                        else
                        {
                            cell.lblPrice.text = String(format:": %0.2f %@",Float((dict.value(forKey: "price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            
                            cell.lblPrice.textColor = UIColor.black
                            
                            cell.lblSpecialPrice.textColor = UIColor.black
                            
                            cell.lblSpecialPrice.text = ""
                        }
                        
                    }
                    else
                    {
                        cell.lblPrice.text = String(format:": %0.2f %@",Float((dict.value(forKey: "price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.black
                        
                        cell.lblSpecialPrice.textColor = UIColor.black
                        
                        cell.lblSpecialPrice.text = ""
                    }
            }
            else
            {
                cell.lblPrice.text = String(format:": %0.2f %@",Float((dict.value(forKey: "price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                
                cell.lblPrice.textColor = UIColor.black
                
                cell.lblSpecialPrice.textColor = UIColor.black
                
                cell.lblSpecialPrice.text = ""
            }
  
            }
            else
            {
                cell.lblPrice.text = String(format:": %0.2f %@",Float((dict.value(forKey: "price") as! String))!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                
                cell.lblPrice.textColor = UIColor.black
                
                cell.lblSpecialPrice.textColor = UIColor.black
                
                cell.lblSpecialPrice.text = ""
            }
            
            
                        
            cell.lblQuantity.text = "\((appDel.mapping?.string(forKey: "Quantity"))!) : \(dict.value(forKey: "qty") as! String)"
            
            if dict.value(forKey: "product_type") as? String == "configurable" {
                
                cell.heightSize.constant = 22
                
                let arr:NSMutableArray = (dict.value(forKey: "configure_option") as? NSMutableArray)!
                
                if arr.count > 0
                {
                    for item in arr {
                        
                        let dict:NSMutableDictionary = item as! NSMutableDictionary
                        
                        if (dict.value(forKey: "option_label") as! String).lowercased().contains("size") == true {
                            
                             cell.lblSize.text = "\((appDel.mapping?.string(forKey: "Size"))!) : \(dict.value(forKey: "option_value") as! String)"
                                                        
                            break
                        }
                    }
                }
                
            }
            else
            {
                cell.heightSize.constant = 0
                
                cell.lblSize.text = "\((appDel.mapping?.string(forKey: "Size"))!) : \(dict.value(forKey: "size") as! String)"
            }
            
           
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        
        if dict.value(forKey: "type") as! String == "shipping_address"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellShippingAddress", for: indexPath) as! cellShippingAddress
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblShippingAddress.font = UIFont(name: appDel.strFont_Bold, size: 16.0)
                cell.lblAddress.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.lblName.font = UIFont(name: appDel.strFont, size: 15.0)
                
                cell.btnBack.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 14.0)
                cell.btnBuyNow.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 14.0)
                
            }
            else
            {
                cell.lblShippingAddress.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
                cell.lblAddress.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                cell.lblName.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                
                cell.btnBack.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
                cell.btnBuyNow.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
                
            }

            cell.lblName.text = dict.value(forKey: "name") as? String
            cell.lblAddress.text = dict.value(forKey: "address") as? String
            
            cell.btnBack.tag = indexPath.row
            cell.btnBack.addTarget(self, action: #selector(btnBackAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnBuyNow.tag = indexPath.row
            cell.btnBuyNow.addTarget(self, action: #selector(btnBuyNowAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnBack.setTitle(appDel.mapping?.string(forKey: "Back"), for: UIControlState.normal)
            cell.btnBuyNow.setTitle(appDel.mapping?.string(forKey: "Buy Now"), for: UIControlState.normal)
            cell.lblShippingAddress.text = appDel.mapping?.string(forKey: "Shipping address")

            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
            
        }
        
        if dict.value(forKey: "type") as! String == "credit_debit_card"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCreditDebit", for: indexPath) as! cellCreditDebit
       
            self.customizeTextfieldForCredit(cell.txtCardNumber)
            self.customizeTextfieldForCredit(cell.txtNameOnCard)
            self.customizeTextfieldForCredit(cell.txtCVV)
            
            cell.setUpUI()
            
            if isEnglish {
                cell.lblStaticCardNumber.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.txtCardNumber.font = UIFont(name: appDel.strFont, size: 13.0)
                
                cell.lblStaticNameOnCard.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.txtNameOnCard.font = UIFont(name: appDel.strFont, size: 13.0)
                
                cell.lblStaticExpDate.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.btnExpirationYear.titleLabel?.font = UIFont(name: appDel.strFont, size: 13.0)
                cell.btnExpirationDate.titleLabel?.font = UIFont(name: appDel.strFont, size: 13.0)
                
                cell.lblStaticCVV.font = UIFont(name: appDel.strFont, size: 15.0)
                cell.txtCVV.font = UIFont(name: appDel.strFont, size: 13.0)
                
                cell.lblStaticNewsLetter.font = UIFont(name: appDel.strFont, size: 12.0)
                cell.lblStaticBillingAddress.font = UIFont(name: appDel.strFont, size: 12.0)
            }
            else
            {
                cell.lblStaticCardNumber.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                cell.txtCardNumber.font = UIFont(name: appDel.strFontKufi, size: 13.0)
                
                cell.lblStaticNameOnCard.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                cell.txtNameOnCard.font = UIFont(name: appDel.strFontKufi, size: 13.0)
                
                cell.lblStaticExpDate.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                cell.btnExpirationYear.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 13.0)
                cell.btnExpirationDate.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 13.0)
                
                cell.lblStaticCVV.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                cell.txtCVV.font = UIFont(name: appDel.strFontKufi, size: 13.0)
                
                cell.lblStaticNewsLetter.font = UIFont(name: appDel.strFontKufi, size: 12.0)
                cell.lblStaticBillingAddress.font = UIFont(name: appDel.strFontKufi, size: 12.0)
                
            }
 
            cell.txtCardNumber.text = self.strCardNumber
            cell.txtNameOnCard.text = self.strNameOnCard
            
            if self.strExpiryYear != (appDel.mapping?.string(forKey: "—Choose year—"))! {
                cell.btnExpirationYear.contentHorizontalAlignment = .center
                cell.btnExpirationYear.setTitle("\(self.strExpiryYear)", for: UIControlState.normal)
            }
            else
            {
                cell.btnExpirationYear.setTitle("       \(self.strExpiryYear)", for: UIControlState.normal)
            }
            
            if self.strExpiryMonth != appDel.mapping?.string(forKey: "—Choose month—") {
                cell.btnExpirationDate.contentHorizontalAlignment = .center

                cell.btnExpirationDate.setTitle("\(self.strExpiryMonth)", for: UIControlState.normal)
            }
            else
            {
                 cell.btnExpirationDate.setTitle("       \(self.strExpiryMonth)", for: UIControlState.normal)
            }
            
           
          
            cell.txtCVV.text = self.strCVV
            
            cell.txtCardNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.txtNameOnCard.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.txtCVV.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            
            cell.lblStaticNewsLetter.text = appDel.mapping?.string(forKey: "REGISTER NEWSLETTER")
            cell.lblStaticBillingAddress.text = appDel.mapping?.string(forKey: "BILLING ADDRESS SAME AS SHIPPING ADDRESS")
            cell.lblStaticCVV.text = appDel.mapping?.string(forKey: "CVV")
            cell.lblStaticExpDate.text = appDel.mapping?.string(forKey: "Expiration date")
            cell.lblStaticNameOnCard.text = appDel.mapping?.string(forKey: "Name on card")
            cell.lblStaticCardNumber.text = appDel.mapping?.string(forKey: "Card number")
            
            if dict.value(forKey: "isNewsLetter") as! String == "0"{
                cell.btnRegisterNewLetter.isSelected = false
            }
            else
            {
                cell.btnRegisterNewLetter.isSelected = true
            }
            
            if dict.value(forKey: "isSameAsShippingAddress") as! String == "0"{
                cell.btnBillingSameAsShipping.isSelected = false
            }
            else
            {
                cell.btnBillingSameAsShipping.isSelected = true
            }
            
            cell.btnRegisterNewLetter.tag = indexPath.row
            cell.btnRegisterNewLetter.addTarget(self, action: #selector(btnRegisterNewLetterAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnExpirationDate.tag = indexPath.row
            cell.btnExpirationDate.addTarget(self, action: #selector(btnExpirationDateAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnExpirationYear.tag = indexPath.row
            cell.btnExpirationYear.addTarget(self, action: #selector(btnExpirationYearAction(_:)), for: UIControlEvents.touchUpInside)
            
            cell.btnBillingSameAsShipping.tag = indexPath.row
            cell.btnBillingSameAsShipping.addTarget(self, action: #selector(btnBillingSameAsShippingAction(_:)), for: UIControlEvents.touchUpInside)
       
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
            
        }

   
        
        return UITableViewCell()
       
    }
    
    //MARK:- Action zones
    
    @IBAction func btnCloseAction(_ sender: Any)
    {
        if isEnglish
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
        else
        {
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            navigationController?.view?.layer.add(transition, forKey: nil)
            self.navigationController?.popToRootViewController(animated: false)
        }
        
        
    }
    @IBAction func btnRegisterNewLetterAction(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
        
        if btn.isSelected == true {
            
            btn.isSelected = false
            
            dict.setValue("0", forKey: "isNewsLetter")
            
            isRegisterNewsLetter = false
        }
        else
        {
            btn.isSelected = true
            
            dict.setValue("1", forKey: "isNewsLetter")
            
            isRegisterNewsLetter = true
        }
        
    }
    @IBAction func btnExpirationDateAction(_ sender: AnyObject)
    {
        self.view.endEditing(true)
        
        btnPickerDone.tag = 100;
        
        self.normalPicker.reloadAllComponents()
        
        self.movePickerUp(animated: true)
    }
    @IBAction func btnPickerCancel_Click(sender: AnyObject)
    {
        self.movePickerDown(animated: true)
    }
    
    @IBAction func btnPickerDone_Click(sender: AnyObject)
    {
        
        if self.btnPickerDone.tag == 100
        {
            self.strExpiryMonth = "\((self.arrExpiryMonth.object(at: normalPicker.selectedRow(inComponent: 0)) as? String)!)"
        }
        else if self.btnPickerDone.tag == 101
        {
            
            self.strExpiryYear = "\((self.arrExpiryYear.object(at: normalPicker.selectedRow(inComponent: 0)) as? String)!)"
        }
        
        self.movePickerDown(animated: true)
        
        self.tblReviewAndPay.reloadData()
    }

    @IBAction func btnBackAction(_ sender: AnyObject)
    {
        self.scrlReviewAndPay.isHidden = true
        self.scrlShipment.isHidden = false
        
        self.btnShipment.backgroundColor = UIColor(red: 30.0/255.0, green: 200.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.btnReviewPay.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        
    }
    @IBAction func btnExpirationYearAction(_ sender: AnyObject)
    {
        self.view.endEditing(true)
        
        btnPickerDone.tag = 101;
        
        self.normalPicker.reloadAllComponents()
        
        self.movePickerUp(animated: true)
    }
    @IBAction func btnBillingSameAsShippingAction(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
        
        if btn.isSelected == true {
            
            btn.isSelected = false
            
            dict.setValue("0", forKey: "isSameAsShippingAddress")
            
            self.isSameShippingAddress = false
        }
        else
        {
            btn.isSelected = true
            
            dict.setValue("1", forKey: "isSameAsShippingAddress")
            
            self.isSameShippingAddress = true
        }
    }
    @IBAction func btnBuyNowAction(_ sender: AnyObject)
    {
        var str:String = ""
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            str = String(format:"\(API_URL)/v1/checkout/cart/place-order")
        }
        else
        {
            str = String(format:"\(API_URL)/v1/checkout/cart/place-order")
        }
        
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
        }
        
        var strPaymentMethod:String = ""
        
        for i in 0..<self.arrReview.count
        {
            let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
            
            if dict.value(forKey: "type") as! String == "payment_method" && dict.value(forKey: "isSelected") as! String == "1"  {
                
                strPaymentMethod = dict.value(forKey: "code") as! String
            }
        }
        
        if strPaymentMethod == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please select payment method"))!)
            return
        }
        
         HUD?.show(true)
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
        }
        else
        {
             parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
        }
        
       
        parameter.setValue(strPaymentMethod, forKey: "payment_method")
        parameter.setValue(self.txtFullName.text, forKey: "firstname")
        parameter.setValue(self.txtLastName.text, forKey: "lastname")
        parameter.setValue(UserDefaults.standard.value(forKey: "userEmail") as? String, forKey: "email")
        parameter.setValue(self.txtAddress.text, forKey: "street")
        parameter.setValue("", forKey: "region")
        parameter.setValue("\(self.btnCountryCode.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)) \(self.txtLastSevenDigit.text!)", forKey: "phone")
        parameter.setValue(self.txtCity.text, forKey: "city")
        parameter.setValue(UserDefaults.standard.value(forKey: "country_id") as! String, forKey: "country_id")
        
        print(parameter)
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                if httpStatus.statusCode == 500
                {
                    self.HUD?.hide(true)
                    return
                }
                else
                {
                    DispatchQueue.main.async()
                        {
                            self.HUD?.hide(true)
                            return
                    }
                }
                 
               
            }
            
            var jsonResult = NSDictionary()
            
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                // use jsonData
            } catch {
                // report error
            }
            
            DispatchQueue.main.async()
                {
                    if (jsonResult.value(forKey: "success") as! NSNumber).stringValue == "1"
                    {
                        //self.appDel.showAlert(title: jsonResult.value(forKey: "message") as! String)
                        
                        FIRAnalytics.logEvent(withName: "Order_Placed", parameters: ["name":"Order_Placed"])
                        
                        if let id = ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "order_id")) as? String
                        {
                            self.orderId = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "order_id") as! String
                        }
                        else
                        {
                            self.orderId = ""
                        }

                        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                            
                           self.appDel.createEmptyCartForUser(Auth:  UserDefaults.standard.value(forKey: "user_authorization") as! String, needToPost: true)
                            
                        }
                        else
                        {
                            self.appDel.createEmptyCart()
                        }
                        
                        UserDefaults.standard.set(nil, forKey: "badge")
                        
                        UserDefaults.standard.synchronize()
                        
                        if UserDefaults.standard.integer(forKey: "badge") != 0
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                        }
                        else
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                        }
                        
                        self.repositionBadge(tabIndex: 3)
                        
                        //check if payment with payfort
                        
                        if self.strSelectedCode == "payfort_fort_cc"
                        {
                            self.generateToken()
                        }
  
                        
                    }
            }
            
           
            
            print(jsonResult)
            
        }
        task.resume()
        
    }
    
    @IBAction func btnRemoveCode(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
      /*  if self.strCoupenCode == "" {
            
            let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
            
            dict.setValue("0", forKey:"editMode")
            dict.setValue("0", forKey:"isApplied")
            dict.setValue(appDel.mapping?.string(forKey: "Use coupen code"), forKey: "coupenCode")
            
            self.tblReviewAndPay.reloadData()
        }
        else
        {
            self.removeCoupens(tag: btn.tag)
        }  */
        
        let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
        
        dict.setValue("1", forKey:"editMode")
        dict.setValue("1", forKey:"isApplied")
        
        self.tblReviewAndPay.reloadData()
        
      
        
        
    }
    
    @IBAction func btnChangeStatusOfCoupen(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton

        if btn.title(for: UIControlState.normal) == appDel.mapping?.string(forKey: "Remove coupen") {
            
            self.removeCoupens(tag: btn.tag)
        }
        else
        {
            let cell:cellCoupenCode = self.tblReviewAndPay.cellForRow(at: NSIndexPath(row: btn.tag, section: 0) as IndexPath) as! cellCoupenCode
            
            self.isFromAddCoupen = true
            self.strCoupenCode = cell.txtCoupenCode.text!
            
            if self.strCoupenCode == "" {
                
                appDel.showAlert(title: (appDel.mapping!.string(forKey: "Enter Coupen code"))!)
                
                return
            }
            
            self.addCoupenCode(strCoupenCode: cell.txtCoupenCode.text!)
        }
        
    }
    @IBAction func btnAddCoupenCode(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        /* if self.strCoupenCode == "" {
            
            let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
            
            dict.setValue("1", forKey:"editMode")
            dict.setValue("1", forKey:"isApplied")
            
            self.tblReviewAndPay.reloadData()
        }*/
        
        let dict:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
        
        if dict.value(forKey: "editMode") as! String == "1" {
            dict.setValue("0", forKey:"editMode")
           
        }
        else
        {
            dict.setValue("1", forKey:"editMode")
           
        }
        
        if self.strCoupenCode == "" {
            dict.setValue("0", forKey:"isApplied")
        }
        else
        {
            dict.setValue("1", forKey:"isApplied")
        }
        
        
        
        self.tblReviewAndPay.reloadData()
       
        
        
    }
    @IBAction func btnPaymentMethodAction(_ sender: AnyObject)
    {
        

        /*let PayFort:PayFortController = PayFortController.init(enviroment: KPayFortEnviromentSandBox)
        
        let request1 = NSMutableDictionary.init()
        request1.setValue("1000", forKey: "amount")
        request1.setValue("AUTHORIZATION", forKey: "command")
        request1.setValue("USD", forKey: "currency")
        request1.setValue("jit.alpha@gmail.com", forKey: "customer_email")
        request1.setValue("en", forKey: "language")
        request1.setValue("112233682686", forKey: "merchant_reference")
        request1.setValue("tok_c63e7e88c024b660c5abd9374a16" , forKey: "sdk_token")
        request1.setValue("VISA", forKey: "payment_option")
        request1.setValue("tok_c63e7e88c024b660c5abd9374a16" , forKey: "token_name")
        
        PayFort.callPayFort(withRequest: request1, currentViewController: self, success: { (requestDic, responeDic) in
            print(responeDic ?? "")
        }, canceled: { (requestDic, responeDic) in
            print(responeDic ?? "")
        }) { (requestDic, responeDic, message) in
             print(responeDic ?? "")
        }*/
        
        /*               */
        
        let btn:UIButton = sender as! UIButton
        
        let dictSelected:NSMutableDictionary = self.arrReview.object(at: btn.tag) as! NSMutableDictionary
        
        if dictSelected.value(forKey: "isSelected") as! String == "1" {
            
            return
        }
        
        let dictCredit:NSMutableDictionary = NSMutableDictionary()
        
        var indexCredit:NSInteger = 0
        
        for i in 0..<self.arrReview.count
        {
            let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
            
            if dict.value(forKey: "type") as! String == "payment_method" {
                
                dict.setValue("0", forKey: "isSelected")
                
                if dictSelected.value(forKey: "code") as! String == "payfort_fort_cc" && dict.value(forKey: "code") as! String == "payfort_fort_cc"  {
                    
                     self.strCardNumber = ""
                     self.strNameOnCard = ""
                     self.strCVV = ""
                     self.strExpiryYear = (appDel.mapping?.string(forKey: "—Choose year—"))!
                     self.strExpiryMonth = (appDel.mapping?.string(forKey: "—Choose month—"))!
                    
                    dictCredit.setValue("credit_debit_card", forKey: "type")
                    dictCredit.setValue(self.strCardNumber, forKey: "card_number")
                    dictCredit.setValue(self.strNameOnCard, forKey: "name_card")
                    dictCredit.setValue(self.strExpiryMonth, forKey: "expiry_month")
                    dictCredit.setValue(self.strExpiryYear, forKey: "expiry_year")
                    dictCredit.setValue(self.strCVV, forKey: "CVV")
                    dictCredit.setValue("0", forKey: "isNewsLetter")
                    dictCredit.setValue("0", forKey: "isSameAsShippingAddress")
                    
                    indexCredit = i
                }
            }
            
        }
  
        
        dictSelected.setValue("1", forKey:"isSelected")
        
        if indexCredit != 0 {
            
            //self.arrReview.insert(dictCredit, at: indexCredit + 1)
        }
        else
        {
            var indexCreditCard:NSInteger = 0
            
            for i in 0..<self.arrReview.count
            {
                let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
                
                if dict.value(forKey: "type") as! String == "credit_debit_card" {
                        
                    indexCreditCard = i
                }
                
                
            }
            
            if indexCreditCard != 0 {
                
                self.arrReview.removeObject(at: indexCreditCard)
            }
            
        }
        
        print(self.arrReview)
        
        self.HUD?.show(true)
        
        var str:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != ""
        {
             str = String(format:"\(API_URL)/v1/payment/user-set-method")
        }
        else
        {
             str = String(format:"\(API_URL)/v1/payment/set-method")
        }
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
        }
        else
        {
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
        }
        
        parameter.setValue(dictSelected.value(forKey: "code"), forKey: "payment_method")
        parameter.setValue(self.txtFullName.text, forKey: "firstname")
        parameter.setValue(self.txtLastName.text, forKey: "lastname")
        parameter.setValue(UserDefaults.standard.value(forKey: "userEmail") as? String, forKey: "email")
        parameter.setValue(self.txtAddress.text, forKey: "street")
        parameter.setValue("", forKey: "region")
        parameter.setValue(self.txtCity.text, forKey: "city")
        parameter.setValue(UserDefaults.standard.value(forKey: "country_id") as! String, forKey: "country_id")
        parameter.setValue("\(self.btnCountryCode.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)) \(self.txtLastSevenDigit.text!)", forKey: "phone")
        
        print(parameter)
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        return
                }
            }
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                DispatchQueue.main.async()
                    {
                        
                        var jsonResult = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            print(jsonResult)
                            
                            let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                            
                            if flag == "1"
                            {
                                self.isFromSetPaymentMethod = true
                                self.strSelectedCode = dictSelected.value(forKey: "code") as! String
                                
                                for i in 0..<self.arrReview.count
                                {
                                    let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
                                    
                                    if dict.value(forKey: "type") as! String == "add_coupen" && dict.value(forKey: "isApplied") as! String == "1"  {
                                        
                                        self.isFromAddCoupen = true
                                        self.strCoupenCode = dict.value(forKey: "coupenCode") as! String
                                    }
                                }
                                
                                FIRAnalytics.logEvent(withName: "Payment_Selected", parameters: ["name":"Payment_Selected"])
                                
                                self.getPaymentMethod()
                            }
                            else
                            {
                                
                            }
                            
                            // use jsonData
                        } catch {
                            // report error
                        }
 
                }
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }

            
        }
        task.resume()
        
        
        
        
    }

    @IBAction func btnProceedToPaymentAction(_ sender: Any)
    {
        
        self.view.endEditing(true)
        
        if self.txtFullName.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter name"))!)
            return
        }
        if self.txtLastName.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter name"))!)
            return
        }
        if self.txtLastSevenDigit.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter phone number"))!)
            return
        }
        if self.txtAddress.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter address"))!)
            return
        }
        if self.txtCity.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter city"))!)
            return
        }
        
        HUD?.show(true)
        
        let str:String = String(format:"\(API_URL)/v1/checkout/cart/address")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            //parameter.setValue(UserDefaults.standard.value(forKey: "user_cart_id") as! String, forKey: "cart_id")
        }
        else
        {
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
        }
        
        
        parameter.setValue(self.txtFullName.text, forKey: "firstname")
        parameter.setValue(self.txtLastName.text, forKey: "lastname")
        
        parameter.setValue(UserDefaults.standard.value(forKey: "userEmail"), forKey: "email")
        parameter.setValue(self.txtAddress.text, forKey: "street")
        parameter.setValue("", forKey: "region")
        parameter.setValue(self.txtCity.text, forKey: "city")
        parameter.setValue(UserDefaults.standard.value(forKey: "country_id") as! String, forKey: "country")
        parameter.setValue("\(self.btnCountryCode.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)) \(self.txtLastSevenDigit.text!)", forKey: "phone")
        
        print(parameter)
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                //DispatchQueue.main.async()
                  //  {
                        self.HUD?.hide(true)
                        return
               // }
            }
            
            var jsonResult = NSDictionary()
            
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print(jsonResult)
                
                //**  temp code for get payment method **//
                
                /*self.arrReview = NSMutableArray()
                
                let arrPaymentMethod:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "payment_methods") as! NSMutableArray
                
                for item in arrPaymentMethod
                {
                    let dict:NSMutableDictionary = item as! NSMutableDictionary
                    
                    if self.isFromSetPaymentMethod == true && self.strSelectedCode == dict.value(forKey: "code") as! String
                    {
                        self.isFromSetPaymentMethod = false
                        
                        dict.setValue("payment_method", forKey: "type")
                        dict.setValue("1", forKey: "isSelected")
                        self.arrReview.add(dict)
                        
                        if self.strSelectedCode == "payfort_fort_cc"
                        {
                            let dictCredit:NSMutableDictionary = NSMutableDictionary()
                            dictCredit.setValue("credit_debit_card", forKey: "type")
                            dictCredit.setValue(self.strCardNumber, forKey: "card_number")
                            dictCredit.setValue(self.strNameOnCard, forKey: "name_card")
                            dictCredit.setValue(self.strExpiryMonth, forKey: "expiry_month")
                            dictCredit.setValue(self.strExpiryYear, forKey: "expiry_year")
                            dictCredit.setValue(self.strCVV, forKey: "CVV")
                            dictCredit.setValue("0", forKey: "isNewsLetter")
                            dictCredit.setValue("0", forKey: "isSameAsShippingAddress")
                            self.arrReview.add(dictCredit)
                        }
                        
                    }
                    else
                    {
                        dict.setValue("payment_method", forKey: "type")
                        dict.setValue("0", forKey: "isSelected")
                        self.arrReview.add(dict)
                    }
                    
                    
                }*/
                
                //**                                   **//
                
                // use jsonData
            } catch {
                // report error
            }
            
            DispatchQueue.main.async()
                {
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        self.scrlReviewAndPay.isHidden = false
                        self.scrlShipment.isHidden = true
                        
                        self.btnReviewPay.backgroundColor = UIColor(red: 30.0/255.0, green: 200.0/255.0, blue: 30.0/255.0, alpha: 1.0)
                        self.btnShipment.backgroundColor = UIColor.black
                        
                        FIRAnalytics.logEvent(withName: "Checkout_payment", parameters: ["name":"Checkout_payment"])
                        
                        self.getPaymentMethod()
                    }
                    else
                    {
                        self.appDel.showAlert(title: jsonResult.value(forKey: "Something went wrong") as! String)
                        
                        self.HUD?.hide(true)
                    }
     
            }
            
            print(jsonResult)
            
        }
        task.resume()
    }
    
    //MARK:- Private method
    func repositionBadge(tabIndex: Int){
        
        for badgeView in self.tabBarController!.tabBar.subviews[tabIndex].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
            }
        }
    }
    func generateToken()
    {
        self.getCredentials()
    }
    func getCredentials()
    {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        var str:String = ""
        str = String(format:"\(API_URL)/v1/cc/config")
        manager.post(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        self.getSignature(identifier: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "merchant_identifier") as! String, accesscode: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "access_code") as! String)
                        
                       // self.getSDKToken(identifier: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "merchant_identifier") as! String, accesscode: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "access_code") as! String)
                    }
                    else
                    {
                        self.HUD?.hide(true)
                    }
                    
                    // use jsonData
                } catch {
                    // report error
                }
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
        })
    }
    func getSignature(identifier:String,accesscode:String)
    {
        var str1:String = ""
        
        str1 = String(format: "\(API_URL)/v1/cc/signature/request")
        
        var request = URLRequest(url: URL(string: str1)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue("SDK_TOKEN", forKey: "service_command")
        parameter.setValue(PayFort.getUDID(), forKey: "device_id")
        parameter.setValue(Default.value(forKey: LANG_KEY) as! String!, forKey: "language")
        print(parameter)
        /*let dictSend:NSMutableDictionary = NSMutableDictionary()
         dictSend.setValue(parameter, forKey: "cartItem")*/
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        return
                }
                
            }
            
            DispatchQueue.main.async()
                {
                    
                    do {
                        /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                         
                         print((string!).replacingOccurrences(of: "\"", with: ""))*/
                        
                        var jsonResult = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            print(jsonResult)
                            
                            let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                            
                            if flag == "1"
                            {
                                self.getSDKToken(identifier: identifier, accesscode: accesscode, signature: jsonResult.value(forKey: "data") as! String)
                            }
                            else
                            {
                                
                            }
                            
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        // use jsonData
                    } catch let err{
                        // report error
                        
                        print(err)
                    }
                    
            }
            
            
        }
        task.resume()
    }
    func getSDKToken(identifier:String,accesscode:String,signature:String)
    {
        
        /*let post:String = "fRawuF2DreDraceaccess_code=\(accesscode)device_id=\(PayFort.getUDID()!)language=\((Default.value(forKey: LANG_KEY) as! String!)!)merchant_identifier=\(identifier)service_command=SDK_TOKENfRawuF2DreDrace"*/
        
        let post:String = "3t2Nax6tRuPhe4e5tArAmErucA6EXaccess_code=\(accesscode)device_id=\(PayFort.getUDID()!)language=\((Default.value(forKey: LANG_KEY) as! String!)!)merchant_identifier=\(identifier)service_command=SDK_TOKEN3t2Nax6tRuPhe4e5tArAmErucA6EX"
        
        let tmp:NSMutableDictionary = NSMutableDictionary()
        tmp.setValue("SDK_TOKEN", forKey: "service_command")
        tmp.setValue(accesscode, forKey: "access_code")
        tmp.setValue(identifier, forKey: "merchant_identifier")
        tmp.setValue(Default.value(forKey: LANG_KEY) as! String!, forKey: "language")
        //tmp.setValue(post.sha256(), forKey: "signature")
        tmp.setValue(signature, forKey: "signature")
        tmp.setValue(PayFort.getUDID(), forKey: "device_id")
        
       // let str:String = String(format:"https://sbpaymentservices.payfort.com/FortAPI/paymentApi")
        
        let str:String = String(format:"https://paymentservices.payfort.com/FortAPI/paymentApi")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: tmp, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        return
                }
            }
            
            var jsonResult = NSDictionary()
            
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                // use jsonData
            } catch {
                // report error
            }
            
            DispatchQueue.main.async()
                {

                    if let token = jsonResult.value(forKey: "sdk_token") as? String
                    {
                        self.sdk_token = jsonResult.value(forKey: "sdk_token") as! String
                        self.launch(identifier: identifier, accesscode: accesscode)
                    }
                    else
                    {
                        self.appDel.showAlert(title: jsonResult.value(forKey: "response_message") as! String)
                        
                        self.HUD?.hide(true)
                    }
                    
            }
  
            print(jsonResult)
            
        }
        task.resume()
        
    }
    func launch(identifier:String,accesscode:String)
    {
        self.HUD?.hide(true)
        
        let request:NSMutableDictionary = NSMutableDictionary()
        
        for item in self.arrReview
        {
            let dict:NSMutableDictionary = item as! NSMutableDictionary
         
            if dict.value(forKey: "type") as! String == "total"
            {
                print(dict.value(forKey: "value") as! String)
                
                let price:Int = Int((Float(dict.value(forKey: "value") as! String))!)
                
                request.setValue(String(price), forKey: "amount")
                
                break
            }
        }
        //request.setValue("100", forKey: "amount")
        request.setValue("PURCHASE", forKey: "command")
        request.setValue("SAR", forKey: "currency")
        request.setValue(Default.value(forKey: LANG_KEY) as! String!, forKey: "language")
        request.setValue((UserDefaults.standard.value(forKey: "userEmail") as? String)!, forKey: "customer_email")
        //request.setValue("VISA", forKey: "payment_option")
        request.setValue(self.orderId, forKey: "merchant_reference")
        request.setValue(self.sdk_token, forKey: "sdk_token")
        
        print(request)
        
        
        PayFort.setPayFortCustomViewNib("PayfortPayment")
        
        PayFort.callPayFort(withRequest: request, currentViewController: self, success: { (requestDic, responeDic) in
            print("success")
            print(responeDic ?? "")
            
            if isEnglish {
                
                let obj:SuccessOrderViewController = SuccessOrderViewController(nibName: "SuccessOrderViewController", bundle: nil)
                obj.orderID = self.orderId
                obj.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(obj, animated: false)
            }
            else
            {
                let obj:SuccessOrderViewController = SuccessOrderViewController(nibName: "SuccessOrderViewController", bundle: nil)
                obj.orderID = self.orderId
                obj.hidesBottomBarWhenPushed = true
                let transition = CATransition()
                transition.duration = 0.45
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                self.navigationController?.view?.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(obj, animated: false)
                
            }
            
        },
                            canceled: { (requestDic, responeDic) in print("canceled")
        },
                            faild: { (requestDic, responeDic, message) in print("faild")
                                print(responeDic)
        })
        
    }
    func setFont(fontSize:CGFloat) -> CGFloat
    {
        print("\((fontSize*UIScreen.main.bounds.size.width)/320)")
        
        return (fontSize*UIScreen.main.bounds.size.width)/320
    }
    func getPaymentMethod()
    {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
         var str:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
             manager.requestSerializer.setValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
             str = String(format:"\(API_URL)/v1/payment/methods/user")
        }
        else
        {
             str = String(format:"\(API_URL)/v1/checkout/payment/methods/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
        }
        
        
        manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        self.arrReview = NSMutableArray()
                        
                        let arrPaymentMethod:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "payment_methods") as! NSMutableArray
                        
                        for item in arrPaymentMethod
                        {
                            let dict:NSMutableDictionary = item as! NSMutableDictionary
                            
                            if self.isFromSetPaymentMethod == true && self.strSelectedCode == dict.value(forKey: "code") as! String
                            {
                                self.isFromSetPaymentMethod = false
                                
                                dict.setValue("payment_method", forKey: "type")
                                dict.setValue("1", forKey: "isSelected")
                                self.arrReview.add(dict)
                                
                                if self.strSelectedCode == "payfort_fort_cc"
                                {
                                    //Need to remove if we want UI under credit debit button
                                    
                                    /*let dictCredit:NSMutableDictionary = NSMutableDictionary()
                                    dictCredit.setValue("credit_debit_card", forKey: "type")
                                    dictCredit.setValue(self.strCardNumber, forKey: "card_number")
                                    dictCredit.setValue(self.strNameOnCard, forKey: "name_card")
                                    dictCredit.setValue(self.strExpiryMonth, forKey: "expiry_month")
                                    dictCredit.setValue(self.strExpiryYear, forKey: "expiry_year")
                                    dictCredit.setValue(self.strCVV, forKey: "CVV")
                                    dictCredit.setValue("0", forKey: "isNewsLetter")
                                    dictCredit.setValue("0", forKey: "isSameAsShippingAddress")
                                    self.arrReview.add(dictCredit)*/
                                }
                                
                            }
                            else
                            {
                                dict.setValue("payment_method", forKey: "type")
                                dict.setValue("0", forKey: "isSelected")
                                self.arrReview.add(dict)
                            }
                            
                           
                        }
                        

                        self.getCoupenForCart()
    
                        
                    }
                    else
                    {
                         self.getCoupenForCart()
                    }
                    
                    // use jsonData
                } catch {
                    // report error
                }
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                 self.getCoupenForCart()
                
        })
        
    }
    func getCoupenForCart()
    {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        var str:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            str = String(format:"\(API_URL)/v1/checkout/customer-cart/coupons")
            
            manager.requestSerializer.setValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
        }
        else
        {
            str = String(format:"\(API_URL)/v1/checkout/guest-carts/coupons/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
        }
        
        
        manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        if let code = (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "coupon_code") as? String
                        {
                            self.strCoupenCode = code
                            
                            self.isFromAddCoupen = false
                            
                            let dictCoupen:NSMutableDictionary = NSMutableDictionary()
                            
                            dictCoupen.setValue("add_coupen", forKey: "type")
                            dictCoupen.setValue("1", forKey: "isApplied")
                            dictCoupen.setValue("0", forKey: "editMode")
                            dictCoupen.setValue(code, forKey: "coupenCode")
                            self.arrReview.add(dictCoupen)
                            
                        }
                        else
                        {
                            let dictCoupen:NSMutableDictionary = NSMutableDictionary()
                            
                            self.isFromAddCoupen = false
                            self.strCoupenCode = ""
                            
                            dictCoupen.setValue("add_coupen", forKey: "type")
                            dictCoupen.setValue("0", forKey: "isApplied")
                            dictCoupen.setValue("0", forKey: "editMode")
                            dictCoupen.setValue(self.appDel.mapping?.string(forKey: "Use coupen code"), forKey: "coupenCode")
                            self.arrReview.add(dictCoupen)
                            
                        }
                        
                        self.getTotalAmount()
                        
                    }
                    else
                    {
                        let dictCoupen:NSMutableDictionary = NSMutableDictionary()
                        
                        dictCoupen.setValue("add_coupen", forKey: "type")
                        dictCoupen.setValue("0", forKey: "isApplied")
                        dictCoupen.setValue("0", forKey: "editMode")
                        dictCoupen.setValue(self.appDel.mapping?.string(forKey: "Use coupen code"), forKey: "coupenCode")
                        self.arrReview.add(dictCoupen)
                        
                        self.getTotalAmount()
                    }
                    
                    // use jsonData
                } catch {
                    // report error
                }
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
               self.getTotalAmount()
                
        })
    }
    func getTotalAmount()
    {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        var str:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            str = String(format:"\(API_URL)/v1/checkout/cart/totals/mine")
            
            manager.requestSerializer.setValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
        }
        else
        {
            str = String(format:"\(API_URL)/v1/checkout/cart/totals/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
        }
        
        
        manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        let arrTotal:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
                        
                        var count:NSInteger = 0
                        
                        for item in arrTotal
                        {
                            let dict:NSMutableDictionary = item as! NSMutableDictionary
                            
                            if count == arrTotal.count - 1
                            {
                                dict.setValue("total", forKey: "type")
                                
                                if let number = dict.value(forKey: "value") as? NSNumber
                                {
                                    dict.setValue((dict.value(forKey: "value") as! NSNumber).stringValue, forKey: "value")
                                }
                                else
                                {
                                    dict.setValue("0", forKey: "value")
                                }
                                
                                dict.setValue(dict.value(forKey: "title") as! String, forKey: "title")
                                dict.setValue(UserDefaults.standard.value(forKey: "currencyCode") as! String, forKey: "currency")
                                self.arrReview.add(dict)
                            }
                            else
                            {
                                dict.setValue("sub_total", forKey: "type")
                                
                                if let value = dict.value(forKey: "value") as? NSNumber
                                {
                                     dict.setValue((dict.value(forKey: "value") as! NSNumber).stringValue, forKey: "value")
                                }
                                else
                                {
                                    dict.setValue("0.0", forKey: "value")
                                }
                               
                                dict.setValue(dict.value(forKey: "title") as! String, forKey: "title")
                                dict.setValue(UserDefaults.standard.value(forKey: "currencyCode") as! String, forKey: "currency")
                                self.arrReview.add(dict)
                            }
                            
                            count = count + 1
                        }
                        
                        print(self.arrReview)
                        
                        let dictReviewOrder:NSMutableDictionary = NSMutableDictionary()
                        
                        dictReviewOrder.setValue("review_order", forKey: "type")
                        self.arrReview.add(dictReviewOrder)
                        
                        self.getCartItems()
                        
                    }
                    else
                    {
                        self.getCartItems()
                    }
                    
                    // use jsonData
                } catch {
                    // report error
                }
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                self.getCartItems()
                
        })
    }
    func getProductImage(index:NSInteger,count:NSInteger,dict:NSMutableDictionary)
    {
        //8ilvs6ke53k10gqxsyr022ok28umaqxr
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("Bearer o6esxf41wvdfp631bj23j229p1lk6ac6", forHTTPHeaderField: "Authorization")
        
        let str:String = String(format:"http://mage2.shy7lo.com/index.php/rest/V1/products/%@/media",dict.value(forKey: "sku") as! String)
        
        manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            do {
                let arrImages = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
                
                print(arrImages)
                
                if arrImages.count > 0
                {
                    let dictImage:NSMutableDictionary = arrImages.object(at: 0) as! NSMutableDictionary
                    
                    dict.setValue(dictImage.value(forKey: "file") as! String, forKey: "image")
                    
                    if count - 1 == 0
                    {
                    
                        self.tblReviewAndPay.reloadData()
                        
                        self.HUD?.hide(true)
                    }
                    else
                    {
                        self.getProductImage(index: index+1, count: count - 1, dict: self.arrReview.object(at: index+1) as! NSMutableDictionary)
                    }
                }
                else
                {
                    if count - 1 == 0
                    {
                        
                        self.tblReviewAndPay.reloadData()
                        
                        self.HUD?.hide(true)
                    }
                    else
                    {
                        self.getProductImage(index: index+1, count: count - 1, dict: self.arrReview.object(at: index+1) as! NSMutableDictionary)
                    }
                    
                }
                
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                self.HUD?.hide(true)
                
        })
        
        
        
    }
    func getCartItems()
    {
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            var str1:String = ""
            
            str1 = String(format: "\(API_URL)/v1/checkout/get-cart/mine")
            
            var request = URLRequest(url: URL(string: str1)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            }
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            
            print(parameter)
            /*let dictSend:NSMutableDictionary = NSMutableDictionary()
             dictSend.setValue(parameter, forKey: "cartItem")*/
            
            var jsondata2 = Data()
            
            do {
                jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
                // use jsonData
            } catch {
                // report error
            }
            
            request.httpBody = jsondata2
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    self.HUD?.hide(true)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    DispatchQueue.main.async()
                        {
                            self.HUD?.hide(true)
                            return
                    }
                    
                }
                
                DispatchQueue.main.async()
                    {
                        
                        do {
                            /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                             
                             print((string!).replacingOccurrences(of: "\"", with: ""))*/
                            
                            var jsonResult = NSDictionary()
                            
                            do {
                                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                print(jsonResult)
                                
                                let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                                
                                if flag == "1"
                                {
                                    let arrItems:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                                    
                                    print(arrItems)
                                    
                                    let index:NSInteger = self.arrReview.count
                                    
                                    
                                    for item in arrItems
                                    {
                                        let dict:NSMutableDictionary = item as! NSMutableDictionary
                                        
                                        dict.setValue("order", forKey: "type")
                                        dict.setValue(dict.value(forKey: "name") as! String, forKey: "name")
                                        if let brand = dict.value(forKey: "brand") as? String
                                        {
                                            dict.setValue(dict.value(forKey: "brand") as! String, forKey: "brandName")
                                        }
                                        else
                                        {
                                            dict.setValue("", forKey: "brandName")
                                        }
                                        
                                        dict.setValue("\(dict.value(forKey: "price") as! Int)", forKey: "price")
                                        dict.setValue(UserDefaults.standard.value(forKey: "currencyCode") as! String, forKey: "currency")
                                        if let size = dict.value(forKey: "size") as? Int
                                        {
                                            dict.setValue("\(size)", forKey: "size")
                                        }
                                        else
                                        {
                                            dict.setValue("", forKey: "size")
                                        }
                                        
                                        
                                        dict.setValue("\(dict.value(forKey: "qty") as! Int)", forKey: "qty")
                                        //dict.setValue(dict.value(forKey: "image") as! String, forKey: "image")
                                        
                                        self.arrReview.add(dict)
                                        
                                    }
                                    
                                    if arrItems.count > 0
                                    {
                                        /*self.getProductImage(index: index, count: arrItems.count, dict: self.arrReview.object(at: index) as! NSMutableDictionary)*/
                                    }
                                    
                                    
                                    let dictShipping:NSMutableDictionary = NSMutableDictionary()
                                    
                                    dictShipping.setValue("shipping_address", forKey: "type")
                                    dictShipping.setValue("\(self.txtFullName.text!) \(self.txtLastName.text!)", forKey: "name")
                                    dictShipping.setValue("\(self.txtAddress.text!),\(self.txtCity.text!) \n \(self.btnCountryCode.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)) \(self.txtLastSevenDigit.text!)", forKey: "address")
                                    
                                    self.arrReview.add(dictShipping)
                                    
                                    print(self.arrReview)
                                    
                                    if arrItems.count == 0
                                    {
                                        self.tblReviewAndPay.reloadData()
                                        
                                        self.HUD?.hide(true)
                                    }
                                    else
                                    {
                                        self.tblReviewAndPay.reloadData()
                                        
                                        self.HUD?.hide(true)
                                    }
                                    
                                }
                                else
                                {
                                    
                                }
                                
                                // use jsonData
                            } catch {
                                // report error
                            }
                            
                            // use jsonData
                        } catch let err{
                            // report error
                            
                            print(err)
                        }

                }
                
                
            }
            task.resume()
            
        }
        else
        {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
            manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            var str:String = ""
            str = String(format:"\(API_URL)/v1/checkout/get-cart/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
            manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
                
                
                
                do {
                    /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                     
                     print((string!).replacingOccurrences(of: "\"", with: ""))*/
                    
                    var jsonResult = NSDictionary()
                    
                    do {
                        jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        print(jsonResult)
                        
                        let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                        
                        
                        if flag == "1"
                        {
                            let arrItems:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                            
                            print(arrItems)
                            
                            let index:NSInteger = self.arrReview.count
                            
                            
                            for item in arrItems
                            {
                                let dict:NSMutableDictionary = item as! NSMutableDictionary
                                
                                dict.setValue("order", forKey: "type")
                                dict.setValue(dict.value(forKey: "name") as! String, forKey: "name")
                                
                                if let brand = dict.value(forKey: "brand") as? String
                                {
                                    dict.setValue(dict.value(forKey: "brand") as! String, forKey: "brandName")
                                }
                                else
                                {
                                    dict.setValue("", forKey: "brandName")
                                }
                                
                                dict.setValue("\(dict.value(forKey: "price") as! Int)", forKey: "price")
                                dict.setValue(UserDefaults.standard.value(forKey: "currencyCode") as! String, forKey: "currency")
                                if let size = dict.value(forKey: "size") as? Int
                                {
                                    dict.setValue("\(size)", forKey: "size")
                                }
                                else
                                {
                                    dict.setValue("", forKey: "size")
                                }
                                
                                
                                dict.setValue("\(dict.value(forKey: "qty") as! Int)", forKey: "qty")
                                //dict.setValue(dict.value(forKey: "image") as! String, forKey: "image")
                                
                                self.arrReview.add(dict)
                                
                            }
                            
                            if arrItems.count > 0
                            {
                               /* self.getProductImage(index: index, count: arrItems.count, dict: self.arrReview.object(at: index) as! NSMutableDictionary) */
                            
                            }
                            
                            
                            let dictShipping:NSMutableDictionary = NSMutableDictionary()
                            
                            dictShipping.setValue("shipping_address", forKey: "type")
                            dictShipping.setValue("\(self.txtFullName.text!) \(self.txtLastName.text!)", forKey: "name")
                            dictShipping.setValue("\(self.txtAddress.text!),\(self.txtCity.text!) \n \(self.btnCountryCode.text!.trimmingCharacters(in: NSCharacterSet.whitespaces)) \(self.txtLastSevenDigit.text!)", forKey: "address")
                            
                            self.arrReview.add(dictShipping)
                            
                            print(self.arrReview)
                            
                            if arrItems.count == 0
                            {
                                self.tblReviewAndPay.reloadData()
                                
                                self.HUD?.hide(true)
                            }
                            else
                            {
                                self.tblReviewAndPay.reloadData()
                                
                                self.HUD?.hide(true)
                            }
                            
                        }
                        else
                        {
                            
                        }
                        
                        // use jsonData
                    } catch {
                        // report error
                    }
                    
                    // use jsonData
                } catch let err{
                    // report error
                    
                    print(err)
                }
                
            }
                , failure: { (operation: AFHTTPRequestOperation?,
                    error) in
                    print("Error: " + (error?.localizedDescription)!)
                    
                    self.HUD?.hide(true)
                    
            })
        }
                
       
    }
    
    
    func removeCoupens(tag:Int)
    {
        
        self.HUD?.show(true)
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        var str:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            str = String(format:"\(API_URL)/v1/checkout/customer-cart/coupons")
            
            manager.requestSerializer.setValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
        }
        else
        {
            str = String(format:"\(API_URL)/v1/checkout/guest-carts/coupons/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
        }
        
        manager.delete(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                        
                        for i in 0..<self.arrReview.count
                        {
                            let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
                            
                            if dict.value(forKey: "type") as! String == "payment_method" && dict.value(forKey: "isSelected") as! String == "1"  {
                                
                                self.isFromSetPaymentMethod = true
                                self.strSelectedCode = dict.value(forKey: "code") as! String
                            }
                        }
                        
                        self.isFromAddCoupen = false
                        self.strCoupenCode = ""
                        
                        self.getPaymentMethod()
                        
                    }
                    else
                    {
                        self.isFromAddCoupen = false
                        self.strCoupenCode = ""
                    }
                    
                    // use jsonData
                } catch {
                    // report error
                }
                
                // use jsonData
            } catch let err{
                // report error
                self.isFromAddCoupen = false
                self.strCoupenCode = ""
                
                print(err)
            }
            
        }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                self.HUD?.hide(true)
                
        })
        
    }
    func addCoupenCode(strCoupenCode:String)
    {
        HUD?.show(true)
        
        var str1:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != ""
        {
            str1 = String(format: "\(API_URL)/v1/checkout/customer-cart/coupons")
        }
        else
        {
            str1 = String(format: "\(API_URL)/v1/checkout/guest-carts/coupons")
        }
        
        var request = URLRequest(url: URL(string: str1)!)
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
        }
        else
        {
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        parameter.setValue(strCoupenCode, forKey: "coupon")
       
        print(parameter)
        /*let dictSend:NSMutableDictionary = NSMutableDictionary()
         dictSend.setValue(parameter, forKey: "cartItem")*/
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        /*self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Enter valid coupen code"))!)
                        self.HUD?.hide(true)*/
                        return
                }
            }
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                DispatchQueue.main.async()
                    {
                        
                        var jsonResult = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            print(jsonResult)
                            
                            let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                            
                            if flag == "1"
                            {
                                FIRAnalytics.logEvent(withName: "Coupon_Applied", parameters: ["name":"Coupon_Applied"])
                                
                                for i in 0..<self.arrReview.count
                                {
                                    let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
                                    
                                    if dict.value(forKey: "type") as! String == "payment_method" && dict.value(forKey: "isSelected") as! String == "1"  {
                                        
                                        self.isFromSetPaymentMethod = true
                                        self.strSelectedCode = dict.value(forKey: "code") as! String
                                    }
                                }
                                
                                self.getPaymentMethod()
                                
                            }
                            else
                            {
                                
                                self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Enter valid coupen code"))!)
                                
                                self.isFromAddCoupen = false
                                self.strCoupenCode = ""
                                
                                self.HUD?.hide(true)
                                
                                /* for i in 0..<self.arrReview.count
                                 {
                                 let dict:NSMutableDictionary = self.arrReview.object(at: i) as! NSMutableDictionary
                                 
                                 if dict.value(forKey: "type") as! String == "payment_method" && dict.value(forKey: "isSelected") as! String == "1"  {
                                 
                                 self.isFromSetPaymentMethod = true
                                 self.strSelectedCode = dict.value(forKey: "code") as! String
                                 }
                                 }
                                 
                                 self.getPaymentMethod()*/
                            }
                            
                            // use jsonData
                        } catch {
                            // report error
                        }

                }
                
                // use jsonData
            } catch let err{
                // report error
                self.HUD?.hide(true)
                print(err)
            }
            
            
            
            
        }
        task.resume()
    }
    
    func orderPlaced()
    {
        if self.strSelectedCode != "payfort_fort_cc"
        {
            self.HUD?.hide(true)
            
            if isEnglish {
                
                let obj:SuccessOrderViewController = SuccessOrderViewController(nibName: "SuccessOrderViewController", bundle: nil)
                obj.orderID = self.orderId
                obj.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                let obj:SuccessOrderViewController = SuccessOrderViewController(nibName: "SuccessOrderViewController", bundle: nil)
                obj.orderID = self.orderId
                obj.hidesBottomBarWhenPushed = true
                let transition = CATransition()
                transition.duration = 0.45
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                navigationController?.view?.layer.add(transition, forKey: nil)
                navigationController?.pushViewController(obj, animated: false)
                
            }
        }
        
    }
    func customizeTextfield( _ textfield:UITextField)
    {
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.clipsToBounds = true
        
        let leftView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftView.backgroundColor=UIColor.clear
        textfield.leftView = leftView
        textfield.leftViewMode = UITextFieldViewMode.always
        
        let rightView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        rightView.backgroundColor=UIColor.clear
        textfield.rightView = rightView
        textfield.rightViewMode = UITextFieldViewMode.always
        
    }
    
    func customizeTextfieldForCredit( _ textfield:UITextField)
    {
        
        let leftView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftView.backgroundColor=UIColor.clear
        textfield.leftView = leftView
        textfield.leftViewMode = UITextFieldViewMode.always
        
        let rightView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        rightView.backgroundColor=UIColor.clear
        textfield.rightView = rightView
        textfield.rightViewMode = UITextFieldViewMode.always
        
    }
    func movePickerUp( animated:Bool)
    {
        
        var pickerFrame:CGRect = viewPickerBg.frame
        
        pickerFrame.origin.y = UIScreen.main.bounds.size.height - pickerFrame.size.height;
        
        var animDuration = 0.0
        
        if animated
        {
            animDuration = 0.3
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        viewPickerBg.frame = pickerFrame;
        
        UIView.commitAnimations()
    }
    
    func movePickerDown( animated:Bool)
    {
        
        var pickerFrame:CGRect = viewPickerBg.frame
        
        pickerFrame.origin.y = self.view.frame.size.height;
        
        var animDuration = 0.0
        
        if animated
        {
            animDuration = 0.3
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        viewPickerBg.frame = pickerFrame;
        
        UIView.commitAnimations()
    }
    //MARK:- Textfield method
    func textFieldDidChange(_ textField: UITextField) {
        
        if textField.tag == 1 {
            
            self.strCardNumber = textField.text!
        }
        if textField.tag == 2 {
            
            self.strNameOnCard = textField.text!
            
        }
        if textField.tag == 3 {
            
            self.strCVV = textField.text!
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == self.txtLastSevenDigit {
            guard let text = textField.text else { return true }
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 10 // Bool
        }
        
       return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.tag == 1 {
            
           /* if textField.text != ""
            {
                self.isFromAddCoupen = true
                self.strCoupenCode = textField.text!
                self.addCoupenCode(strCoupenCode: textField.text!)
            }*/
            
           
        }
        
        textField.resignFirstResponder()
        
        return true
    }

    //MARK: pickerview delegate method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.btnPickerDone.tag == 100
        {
            return self.arrExpiryMonth.count
        }
        else
        {
            return self.arrExpiryYear.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.btnPickerDone.tag == 100
        {
            let str:String = self.arrExpiryMonth.object(at: row) as! String
            
            return str
            
        }
        else
        {
            let str:String = self.arrExpiryYear.object(at: row) as! String
            
            return str
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let lblPickerCell:UILabel = UILabel()
        lblPickerCell.backgroundColor = UIColor.clear
        lblPickerCell.frame = CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 25)
        if isEnglish {
             lblPickerCell.font = UIFont(name: appDel.strFont, size: self.setFont(fontSize: 19.0))
        }
        else
        {
             lblPickerCell.font = UIFont(name: appDel.strFontKufi, size: self.setFont(fontSize: 19.0))
        }
       
        lblPickerCell.textColor = UIColor.darkGray
        lblPickerCell.textAlignment = NSTextAlignment.center
        if self.btnPickerDone.tag == 100
        {
            lblPickerCell.text = self.arrExpiryMonth.object(at: row) as? String
        }
        else
        {
            lblPickerCell.text = self.arrExpiryYear.object(at: row) as? String
        }
        
        
        return lblPickerCell
    }
    
     //MARK:- Memory managment method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension String {
    func width(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
    func sha256() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
}
