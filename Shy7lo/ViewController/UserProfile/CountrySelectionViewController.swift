//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class CountrySelectionViewController: UIViewController {

    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    var selectedIndex:NSInteger = 0
    
    
    @IBOutlet weak var btnBackSaudi: UIButton!
    
    @IBOutlet weak var btnBackQatar: UIButton!
    @IBOutlet weak var btnBackUAE: UIButton!
    
    @IBOutlet weak var btnBackOman: UIButton!
    @IBOutlet weak var btnBackKuwait: UIButton!
    @IBOutlet weak var btnBackBahrain: UIButton!
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var imgFlagQatar: UIImageView!
    @IBOutlet weak var imgFlagOman: UIImageView!
    @IBOutlet weak var imgFlagKuwait: UIImageView!
    
    @IBOutlet weak var imgFlagBahrain: UIImageView!
    @IBOutlet weak var imgFlagSaudi: UIImageView!
    
    @IBOutlet weak var imgFlagUae: UIImageView!
    @IBOutlet weak var imgCheckQatar: UIImageView!
    @IBOutlet weak var imgCheckOman: UIImageView!
    @IBOutlet weak var imgCheckKuwait: UIImageView!

    @IBOutlet weak var imgCheckBahrain: UIImageView!
    
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var imgCheckSaudi: UIImageView!
    
    @IBOutlet weak var imgCheckUae: UIImageView!
    
    @IBOutlet weak var lblSelectYourCountry: UILabel!
    
    @IBOutlet weak var lblSaudiArabia: UILabel!
    
    @IBOutlet weak var lblUAE: UILabel!
    
    @IBOutlet weak var lblQatar: UILabel!
    @IBOutlet weak var lblOman: UILabel!
    @IBOutlet weak var lblKuwait: UILabel!
    @IBOutlet weak var lblBahrain: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAnalytics.logEvent(withName: "Country", parameters: ["name":"Country"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if UserDefaults.standard.value(forKey: "country_name") as! String == "Saudi Arabia" {
            self.btnLanguageAction(self.btnBackSaudi)
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "UAE" {
            self.btnLanguageAction(self.btnBackUAE)
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Qatar" {
            self.btnLanguageAction(self.btnBackQatar)
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Oman" {
            self.btnLanguageAction(self.btnBackOman)
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Kuwait" {
            self.btnLanguageAction(self.btnBackKuwait)
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Bahrain" {
            self.btnLanguageAction(self.btnBackBahrain)
        }
        
        
        self.viewCountry.backgroundColor = .clear
        self.viewCountry.layer.cornerRadius = 0
        self.viewCountry.layer.borderWidth = 1
        self.viewCountry.layer.borderColor = UIColor.lightGray.cgColor
        
        self.navigationController?.isNavigationBarHidden = true
        
        if isEnglish {
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
            self.lblSelectYourCountry.font = UIFont(name: appDel.strFont, size: 16.0)
            
            self.viewCountry.transform = CGAffineTransform.identity
            
            self.imgFlagUae.transform = CGAffineTransform.identity
            self.imgFlagSaudi.transform = CGAffineTransform.identity
            self.imgFlagBahrain.transform = CGAffineTransform.identity
            self.imgFlagKuwait.transform = CGAffineTransform.identity
            self.imgFlagOman.transform = CGAffineTransform.identity
            self.imgFlagQatar.transform = CGAffineTransform.identity
            
            self.lblSaudiArabia.transform = CGAffineTransform.identity
            self.lblUAE.transform = CGAffineTransform.identity
            self.lblBahrain.transform = CGAffineTransform.identity
            self.lblKuwait.transform = CGAffineTransform.identity
            self.lblOman.transform = CGAffineTransform.identity
            self.lblQatar.transform = CGAffineTransform.identity
            
            self.lblSaudiArabia.textAlignment = .left
            self.lblUAE.textAlignment = .left
            self.lblBahrain.textAlignment = .left
            self.lblKuwait.textAlignment = .left
            self.lblOman.textAlignment = .left
            self.lblQatar.textAlignment = .left
            
            self.imgCheckSaudi.transform = CGAffineTransform.identity
            self.imgCheckUae.transform = CGAffineTransform.identity
            self.imgCheckBahrain.transform = CGAffineTransform.identity
            self.imgCheckKuwait.transform = CGAffineTransform.identity
            self.imgCheckOman.transform = CGAffineTransform.identity
            self.imgCheckQatar.transform = CGAffineTransform.identity
            
            
        }
        else
        {
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSelectYourCountry.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.viewCountry.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.imgFlagUae.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFlagSaudi.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFlagBahrain.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFlagKuwait.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFlagOman.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFlagQatar.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSaudiArabia.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblUAE.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblBahrain.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblKuwait.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblOman.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblQatar.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSaudiArabia.textAlignment = .right
            self.lblUAE.textAlignment = .right
            self.lblBahrain.textAlignment = .right
            self.lblKuwait.textAlignment = .right
            self.lblOman.textAlignment = .right
            self.lblQatar.textAlignment = .right
            
            self.imgCheckSaudi.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckUae.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckBahrain.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckKuwait.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckOman.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgCheckQatar.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        }
        
        self.lblSelectYourCountry.text = appDel.mapping?.string(forKey: "Select your country").uppercased()
        
        self.btnApply.setTitle(appDel.mapping?.string(forKey: "Apply").uppercased(), for: UIControlState.normal)
        
        // Do any additional setup after loading the view.
    }

    //MARK:- Action zones
    
    
    @IBAction func btnApplyAction(_ sender: Any)
    {
        if imgCheckSaudi.isHidden == false {
            
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "SAR"), forKey: "currencyCode")
            UserDefaults.standard.set(self.getExchangeRate(code: "SAR"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("966", forKey: "countryCode")
            UserDefaults.standard.setValue("SA", forKey: "country_id")
            UserDefaults.standard.setValue("Saudi Arabia", forKey: "country_name")
            UserDefaults.standard.synchronize()
        }
        else if imgCheckUae.isHidden == false {
            
            UserDefaults.standard.setValue("UAE", forKey: "country_name")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "AED"), forKey: "currencyCode")
            UserDefaults.standard.set(self.getExchangeRate(code: "AED"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("AE", forKey: "country_id")
            UserDefaults.standard.setValue("971", forKey: "countryCode")
            UserDefaults.standard.synchronize()

        }
        else if imgCheckBahrain.isHidden == false {
            
            UserDefaults.standard.setValue("973", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "BHD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("BH", forKey: "country_id")
            UserDefaults.standard.setValue("Bahrain", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "BHD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        else if imgCheckKuwait.isHidden == false {
            UserDefaults.standard.setValue("965", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "KWD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("KW", forKey: "country_id")
            UserDefaults.standard.setValue("Kuwait", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "KWD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        else if imgCheckOman.isHidden == false {
            
            UserDefaults.standard.setValue("968", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "OMR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("OM", forKey: "country_id")
            UserDefaults.standard.setValue("Oman", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "OMR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        else{
            
            UserDefaults.standard.setValue("974", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "QAR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("Qatar", forKey: "country_name")
            UserDefaults.standard.setValue("QA", forKey: "country_id")
            UserDefaults.standard.set(self.getExchangeRate(code: "QAR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        
        if isEnglish
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            navigationController?.view?.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    @IBAction func btnLanguageAction(_ sender: Any)
    {
        let btn:UIButton = sender as! UIButton
        
        switch btn.tag {
        case 1:
            self.btnBackSaudi.backgroundColor = UIColor.lightGray
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = false
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = true
            
            break
        case 2:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.lightGray
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = false
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = true
            
            break
        case 3:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.lightGray
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = false
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = true
            
            break
        case 4:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.lightGray
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = false
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = true
            
            break
        case 5:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.lightGray
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = false
            self.imgCheckQatar.isHidden = true
            
            break
        case 6:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.lightGray
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = false
            
            break
        default:
            self.btnBackSaudi.backgroundColor = UIColor.clear
            self.btnBackUAE.backgroundColor = UIColor.clear
            self.btnBackBahrain.backgroundColor = UIColor.clear
            self.btnBackKuwait.backgroundColor = UIColor.clear
            self.btnBackOman.backgroundColor = UIColor.clear
            self.btnBackQatar.backgroundColor = UIColor.clear
            
            self.imgCheckSaudi.isHidden = true
            self.imgCheckUae.isHidden = true
            self.imgCheckBahrain.isHidden = true
            self.imgCheckKuwait.isHidden = true
            self.imgCheckOman.isHidden = true
            self.imgCheckQatar.isHidden = true
            
            break
        }
    }
    
    @IBAction func btnDismissAction(_ sender: Any)
    {
        if isEnglish
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            navigationController?.view?.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func getExchangeRate(code:String) -> Float
    {
        let dataAlbumCover:NSData = UserDefaults.standard.object(forKey: "ExchangeRates") as! NSData
        let arrExchangeRate =  NSMutableArray(array: NSKeyedUnarchiver.unarchiveObject(with: dataAlbumCover as Data) as! NSArray)
        
        for i in 0..<arrExchangeRate.count
        {
            let dict:NSMutableDictionary = arrExchangeRate.object(at: i) as! NSMutableDictionary
            
            if dict.value(forKey: "currency_to") as! String == code {
                
                return dict.value(forKey: "rate") as! Float
            }
        }
        
        return 0.2661
        
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
