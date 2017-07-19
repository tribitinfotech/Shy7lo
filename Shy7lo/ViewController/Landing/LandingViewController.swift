//
//  LandingViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 22/08/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class LandingViewController: UIViewController {

    //MARK:- View life cycle
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var imgLandingTop: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblSelectCountry: UILabel!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    var isCountrySelected:Bool = false
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var runkeeperSwitch4: DGRunkeeperSwitch!
    
    @IBOutlet weak var btnKuwait: UIButton!
    @IBOutlet weak var btnOman: UIButton!
    @IBOutlet weak var btnDubai: UIButton!
    @IBOutlet weak var btnSaudiArabia: UIButton!
    @IBOutlet weak var btnQatar: UIButton!
    @IBOutlet weak var btnBahrin: UIButton!
    
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var imgBaharin: UIImageView!
    
    @IBOutlet weak var imgQuwait: UIImageView!
    @IBOutlet weak var btnArabic: UIButton!
    
    @IBOutlet weak var imgOman: UIImageView!
    @IBOutlet weak var imgDubai: UIImageView!
    
    @IBOutlet weak var imgQatar: UIImageView!
    @IBOutlet weak var imgSaudiArabia: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        
        //FIRAnalytics.setScreenName("Landing_screen", screenClass: "LandingViewCOntroller")
        FIRAnalytics.logEvent(withName: "Landing_Page", parameters: ["name":"Landing_Page"])
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*let topBorder = CALayer()
        topBorder.borderColor = UIColor.black.cgColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRect(x: 0, y: 0, width: self.btnEnglish.bounds.width, height: 1)
        self.btnEnglish.layer.addSublayer(topBorder)
        
        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.black.cgColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRect(x: 0, y: self.btnEnglish.bounds.height, width: self.btnEnglish.bounds.width, height: 1)
        self.btnEnglish.layer.addSublayer(bottomBorder)
        
        let leftBorder = CALayer()
        leftBorder.borderColor = UIColor.black.cgColor;
        leftBorder.borderWidth = 1;
        leftBorder.frame = CGRect(x: 0, y: 0, width:1, height: self.btnEnglish.bounds.height)
        self.btnEnglish.layer.addSublayer(leftBorder)*/
     

        /*guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: "Landing")
        
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])*/
        //jk
        BasicStuff.basic.addHUD()
        
        if let runkeeperSwitch4 = runkeeperSwitch4 {
            
            runkeeperSwitch4.titles = ["English", "١لعربية"]
            runkeeperSwitch4.backgroundColor = UIColor.black
            runkeeperSwitch4.selectedBackgroundColor = UIColor.white
            runkeeperSwitch4.titleColor =  UIColor.white
            runkeeperSwitch4.selectedTitleColor = UIColor.black
            runkeeperSwitch4.titleFont = UIFont(name: "Tahoma-Bold", size: 14.0)
        }
        
        if isEnglish {
            
            appDel.strFont = "Tahoma"
            appDel.strFont_Bold = "Tahoma-Bold"
            
            self.runkeeperSwitch4.setSelectedIndex(0, animated: false)
        }
        else
        {
            /*appDel.strFont = "DroidArabicNaskh"
            appDel.strFont_Bold = "DroidArabicNaskh-Bold"
            
            appDel.strFontKufi = "DroidArabicKufi"
            appDel.strFontKufi_Bold = "DroidArabicKufi-Bold"*/
            
            appDel.strFont = "Tahoma"
            appDel.strFont_Bold = "Tahoma-Bold"
            
            appDel.strFontKufi = "Tahoma"
            appDel.strFontKufi_Bold = "Tahoma-Bold"
            
            self.runkeeperSwitch4.setSelectedIndex(1, animated: false)
        }
        
        /**  HUD  **/
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.getCurrency()
        
        if UIScreen.main.bounds.size.width > 420
        {
            self.imgLogo.frame = CGRect(x: self.imgLandingTop.frame.origin.x + self.imgLandingTop.frame.size.width/2 - 40, y: self.imgLandingTop.frame.origin.y + imgLandingTop.frame.size.height/2 - 14, width: 81, height: 28)
        }
        
        self.imgSaudiArabia.isHidden = true
        self.imgSaudiArabia.backgroundColor = UIColor.clear
        self.imgSaudiArabia.layer.borderWidth = 1.0
        self.imgSaudiArabia.layer.borderColor = UIColor.black.cgColor
        self.imgSaudiArabia.clipsToBounds = true
        
        self.imgDubai.isHidden = true
        self.imgDubai.backgroundColor = UIColor.clear
        self.imgDubai.layer.borderWidth = 1.0
        self.imgDubai.layer.borderColor = UIColor.black.cgColor
        self.imgDubai.clipsToBounds = true
        
        self.imgQatar.isHidden = true
        self.imgQatar.backgroundColor = UIColor.clear
        self.imgQatar.layer.borderWidth = 1.0
        self.imgQatar.layer.borderColor = UIColor.black.cgColor
        self.imgQatar.clipsToBounds = true
        
        self.imgOman.isHidden = true
        self.imgOman.backgroundColor = UIColor.clear
        self.imgOman.layer.borderWidth = 1.0
        self.imgOman.layer.borderColor = UIColor.black.cgColor
        self.imgOman.clipsToBounds = true
        
        self.imgQuwait.isHidden = true
        self.imgQuwait.backgroundColor = UIColor.clear
        self.imgQuwait.layer.borderWidth = 1.0
        self.imgQuwait.layer.borderColor = UIColor.black.cgColor
        self.imgQuwait.clipsToBounds = true
        
        self.imgBaharin.isHidden = true
        self.imgBaharin.backgroundColor = UIColor.clear
        self.imgBaharin.layer.borderWidth = 1.0
        self.imgBaharin.layer.borderColor = UIColor.black.cgColor
        self.imgBaharin.clipsToBounds = true
        
      //  self.setUpUI()

        // Do any additional setup after loading the view.
    }

    //MARK:- private method
    
    func setUpUI()
    {
        if isEnglish {
            
             self.imgLogo.image = UIImage(named: "ic_top_logo.png")
             self.imgLogo.frame = CGRect(x: self.imgLandingTop.frame.origin.x + self.imgLandingTop.frame.size.width/2 - ((UIScreen.main.bounds.size.width*71)/320)/2, y: self.imgLandingTop.frame.origin.y + self.imgLandingTop.frame.size.height/2 - 10, width: (UIScreen.main.bounds.size.width*71)/320, height: (UIScreen.main.bounds.size.height*24)/568)
      
            //ipad logic
            
            self.lblSelectLanguage.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            self.lblSelectCountry.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            self.btnNext.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 18.0)
            
            self.viewBottom.transform = CGAffineTransform.identity
            self.btnNext.transform = CGAffineTransform.identity
            
            self.btnEnglish.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            self.btnArabic.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            
            self.btnArabic.backgroundColor = UIColor.white
            self.btnArabic.setTitleColor(UIColor.black, for: .normal)
            
            self.btnEnglish.backgroundColor = UIColor.black
            self.btnEnglish.setTitleColor(UIColor.white, for: .normal)
            
        }
        else{
            
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            self.imgLogo.frame = CGRect(x: self.imgLandingTop.frame.origin.x + self.imgLandingTop.frame.size.width/2 - ((UIScreen.main.bounds.size.width*71)/320)/2, y: self.imgLandingTop.frame.origin.y + self.imgLandingTop.frame.size.height/2 - 10, width: (UIScreen.main.bounds.size.width*71)/320, height: (UIScreen.main.bounds.size.height*22)/568)
            
            self.lblSelectLanguage.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            self.lblSelectCountry.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            
            self.btnNext.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 18.0)
            
            self.viewBottom.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnNext.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
             self.btnEnglish.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
             self.btnArabic.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            
            self.btnEnglish.backgroundColor = UIColor.white
            self.btnEnglish.setTitleColor(UIColor.black, for: .normal)
            
            self.btnArabic.backgroundColor = UIColor.black
            self.btnArabic.setTitleColor(UIColor.white, for: .normal)
        }
        
        self.lblSelectLanguage.text = appDel.mapping?.string(forKey: "Select language")
        self.lblSelectCountry.text = appDel.mapping?.string(forKey: "Select country") 
        self.btnNext.setTitle(appDel.mapping?.string(forKey: "Next"), for: UIControlState.normal)
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
    func getCurrency()
    {
        self.HUD?.show(true)
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        manager.get("\(API_URL)/v1/currency", parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    self.HUD?.hide(true)
                    
                    if flag == "1"
                    {
                        
                        let dataExchangeRates:NSData = NSKeyedArchiver.archivedData(withRootObject: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "exchange_rates") as! NSMutableArray) as NSData
                        UserDefaults.standard.set(dataExchangeRates, forKey: "ExchangeRates")
                        
                        self.btnLanguageAction(self.btnSaudiArabia)
                        
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
    
    
    //MARK:- Action zones
    @IBAction func switchValueDidChange(_ sender: AnyObject)
    {
        print(sender.selectedIndex)
        
        if sender.selectedIndex == 0 {
            
            /*appDel.strFont = "Raleway-Regular"
            appDel.strFont_Bold = "Raleway-SemiBold"*/
            
            appDel.strFont = "Tahoma"
            appDel.strFont_Bold = "Tahoma-Bold"
            
            setLanguage(lang: .English)
            
            appDel.mapping = StringMapping.shared()
            
            appDel.mapping?.setLanguage()
            
            self.setUpUI()
        }
        else
        {
            /*appDel.strFont = "DroidArabicNaskh"
            appDel.strFont_Bold = "DroidArabicNaskh-Bold"
            
            appDel.strFontKufi = "DroidArabicKufi"
            appDel.strFontKufi_Bold = "DroidArabicKufi-Bold"*/
            
            appDel.strFont = "Tahoma"
            appDel.strFont_Bold = "Tahoma-Bold"
            
            appDel.strFontKufi = "Tahoma"
            appDel.strFontKufi_Bold = "Tahoma-Bold"
            
            setLanguage(lang: .Arabic)
            
            appDel.mapping = StringMapping.shared()
            
            appDel.mapping?.setLanguage()
            
            self.setUpUI()
        }
    }
    
    @IBAction func btnArabicAction(_ sender: AnyObject)
    {
        appDel.strFont = "Tahoma"
        appDel.strFont_Bold = "Tahoma-Bold"
        
        appDel.strFontKufi = "Tahoma"
        appDel.strFontKufi_Bold = "Tahoma-Bold"
        
        setLanguage(lang: .Arabic)
        
        appDel.mapping = StringMapping.shared()
        
        appDel.mapping?.setLanguage()
        
        self.setUpUI()

    }
    @IBAction func btnEnglishAction(_ sender: AnyObject)
    {
        appDel.strFont = "Tahoma"
        appDel.strFont_Bold = "Tahoma-Bold"
        
        setLanguage(lang: .English)
        
        appDel.mapping = StringMapping.shared()
        
        appDel.mapping?.setLanguage()
        
        self.setUpUI()
    }
    @IBAction func btnLanguageAction(_ sender: AnyObject)
    {
        
        self.btnSaudiArabia.isSelected = false
        self.btnDubai.isSelected = false
        self.btnQatar.isSelected = false
        self.btnOman.isSelected = false
        self.btnKuwait.isSelected = false
        self.btnBahrin.isSelected = false

        let btn:UIButton = sender as! UIButton
        
        if btn.isSelected == true {
            
            btn.isSelected = false
            self.isCountrySelected = false
        }
        else
        {
            btn.isSelected = true
            self.isCountrySelected = true
        }
        
        
        switch btn.tag {
        case 1:
            
            self.imgSaudiArabia.isHidden = false
            self.imgDubai.isHidden = true
            self.imgQatar.isHidden = true
            self.imgOman.isHidden = true
            self.imgQuwait.isHidden = true
            self.imgBaharin.isHidden = true
            
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "SAR"), forKey: "currencyCode")
            UserDefaults.standard.set(self.getExchangeRate(code: "SAR"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("966", forKey: "countryCode")
            UserDefaults.standard.setValue("SA", forKey: "country_id")
            UserDefaults.standard.setValue("Saudi Arabia", forKey: "country_name")
            UserDefaults.standard.synchronize()
            break
        case 2:
            
            self.imgSaudiArabia.isHidden = true
            self.imgDubai.isHidden = false
            self.imgQatar.isHidden = true
            self.imgOman.isHidden = true
            self.imgQuwait.isHidden = true
            self.imgBaharin.isHidden = true
            
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "AED"), forKey: "currencyCode")
            UserDefaults.standard.set(self.getExchangeRate(code: "AED"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("AE", forKey: "country_id")
            UserDefaults.standard.setValue("UAE", forKey: "country_name")
            UserDefaults.standard.setValue("971", forKey: "countryCode")
            UserDefaults.standard.synchronize()
            break
        case 3:
            self.imgSaudiArabia.isHidden = true
            self.imgDubai.isHidden = true
            self.imgQatar.isHidden = false
            self.imgOman.isHidden = true
            self.imgQuwait.isHidden = true
            self.imgBaharin.isHidden = true
            
            UserDefaults.standard.setValue("974", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "QAR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("QA", forKey: "country_id")
            UserDefaults.standard.setValue("Qatar", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "QAR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
            break
        case 4:
            
            self.imgSaudiArabia.isHidden = true
            self.imgDubai.isHidden = true
            self.imgQatar.isHidden = true
            self.imgOman.isHidden = false
            self.imgQuwait.isHidden = true
            self.imgBaharin.isHidden = true
            
            UserDefaults.standard.setValue("968", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "OMR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("OM", forKey: "country_id")
            UserDefaults.standard.setValue("Oman", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "OMR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
            break
        case 5:
            
            self.imgSaudiArabia.isHidden = true
            self.imgDubai.isHidden = true
            self.imgQatar.isHidden = true
            self.imgOman.isHidden = true
            self.imgQuwait.isHidden = false
            self.imgBaharin.isHidden = true
            
            UserDefaults.standard.setValue("965", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "KWD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("KW", forKey: "country_id")
            UserDefaults.standard.setValue("Kuwait", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "KWD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
            break
        case 6:
            
            self.imgSaudiArabia.isHidden = true
            self.imgDubai.isHidden = true
            self.imgQatar.isHidden = true
            self.imgOman.isHidden = true
            self.imgQuwait.isHidden = true
            self.imgBaharin.isHidden = false
            
            UserDefaults.standard.setValue("973", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "BHD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("BH", forKey: "country_id")
            UserDefaults.standard.setValue("Bahrain", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "BHD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
            break
            
        default:
            break
        }
        
        print(UserDefaults.standard.value(forKey: "currencyCode") ?? "")
        print(UserDefaults.standard.value(forKey: "exchangeRates") ?? "")
        
    }
    
    @IBAction func btnNextAction(_ sender: AnyObject)
    {

        if self.btnSaudiArabia.isSelected == true {
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "SAR"), forKey: "currencyCode")
            UserDefaults.standard.set(self.getExchangeRate(code: "SAR"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("Saudi Arabia", forKey: "country_name")
            UserDefaults.standard.setValue("966", forKey: "countryCode")
            UserDefaults.standard.setValue("SA", forKey: "country_id")
            UserDefaults.standard.synchronize()
        }
        if self.btnDubai.isSelected == true
        {
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "AED"), forKey: "currencyCode")
            UserDefaults.standard.setValue("UAE", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "AED"), forKey: "exchangeRates")
            UserDefaults.standard.setValue("AE", forKey: "country_id")
            UserDefaults.standard.setValue("971", forKey: "countryCode")
            UserDefaults.standard.synchronize()
        }
        if self.btnQatar.isSelected == true
        {
            UserDefaults.standard.setValue("974", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "QAR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("QA", forKey: "country_id")
            UserDefaults.standard.setValue("Qatar", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "QAR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        if self.btnOman.isSelected == true
        {
            UserDefaults.standard.setValue("968", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "OMR"), forKey: "currencyCode")
            UserDefaults.standard.setValue("OM", forKey: "country_id")
            UserDefaults.standard.setValue("Oman", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "OMR"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        if self.btnKuwait.isSelected == true
        {
            UserDefaults.standard.setValue("965", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "KWD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("KW", forKey: "country_id")
            UserDefaults.standard.setValue("Kuwait", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "KWD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }
        if self.btnBahrin.isSelected == true
        {
            UserDefaults.standard.setValue("973", forKey: "countryCode")
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "BHD"), forKey: "currencyCode")
            UserDefaults.standard.setValue("BH", forKey: "country_id")
            UserDefaults.standard.setValue("Bahrain", forKey: "country_name")
            UserDefaults.standard.set(self.getExchangeRate(code: "BHD"), forKey: "exchangeRates")
            UserDefaults.standard.synchronize()
        }

        
        if self.isCountrySelected == false {
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please select country"))!)
            return
        }
        
        if isEnglish {
            
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                appDel.setUpTabbarForArabic()
                appDel.tabBarController?.selectedIndex = 4
            }
            else
            {
                appDel.setUpTabbarForEnglish()
                appDel.tabBarController?.selectedIndex = 0
            }
            
        }
        else
        {
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                appDel.setUpTabbarForArabic()
                appDel.tabBarController?.selectedIndex = 4
            }
            else
            {
                appDel.setUpTabbarForEnglish()
                appDel.tabBarController?.selectedIndex = 0
            }
            
        }
        
        UserDefaults.standard.set(true, forKey: "landingShow")
        UserDefaults.standard.synchronize()
        
        appDel.registerToken()
        
        self.navigationController?.present(appDel.tabBarController!, animated: false, completion: nil)
        
        //self.payFort()
        
      /*  let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)*/


    }
    
    func placeOrder()
    {
        let PayFort:PayFortController = PayFortController.init(enviroment: KPayFortEnviromentSandBox)
        
        let request1 = NSMutableDictionary.init()
        request1.setValue("1000", forKey: "amount")
        request1.setValue("AUTHORIZATION", forKey: "command")
        request1.setValue("SAR", forKey: "currency")
        request1.setValue("zahid@shy7lo.com", forKey: "customer_email")
        request1.setValue("ar", forKey: "language")
        request1.setValue("112233682686", forKey: "merchant_reference")
        request1.setValue("KVIHFZPKWDSTNU1JDHY7EBBUI84194545299535078506" , forKey: "sdk_token")
        request1.setValue("VISA", forKey: "payment_option")
        request1.setValue("gr66zzwW9" , forKey: "token_name")
        
        PayFort.callPayFort(withRequest: request1, currentViewController: self, success: { (requestDic, responeDic) in
            print(responeDic ?? "")
        }, canceled: { (requestDic, responeDic) in
            print(responeDic ?? "")
        }) { (requestDic, responeDic, message) in
            print(responeDic ?? "")
        }
        
        
          
       /*     let params:NSMutableDictionary = NSMutableDictionary()
            params.setValue("XNEw23o2DodbqTOLR6V3", forKey: "access_code")
        params.setValue("1000", forKey: "amount")
        params.setValue("PURCHASE", forKey: "command")
        params.setValue("SAR", forKey: "currency")
        params.setValue("zahid@shy7lo.com", forKey: "customer_email")
        params.setValue("en", forKey: "language")
        params.setValue("qxbVGjJK", forKey: "merchant_identifier")
        params.setValue("12345678", forKey: "merchant_reference")
        params.setValue("0cdb4c9b705826de3fd3b548515f5916197ff3f38965a38e5527ce9654387623", forKey: "signature")
            NSLog("parameter %@", params)
            
            let manager = AFHTTPRequestOperationManager()
            // manager.responseSerializer = AFHTTPResponseSerializer()
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            manager.post("https://sbpaymentservices.payfort.com/FortAPI/paymentApi",
                         parameters: params,
                         success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
                            
                            //print(responseObject)
                            var jsonResult = NSDictionary()
                            
                            do {
                                jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                print(jsonResult)
                              
                                
                                // use jsonData
                            } catch {
                                // report error
                            }
                            
            },
                         failure: { (operation: AFHTTPRequestOperation?,
                            error:Error?) in
                            print("Error: " + (error?.localizedDescription)!)
                            
                            let err = error as! NSError
                            
                            
                            
            })*/
        
    }
    
    func payFort()
    {
        let PayFortObj:PayFortController  = PayFortController.init(enviroment: KPayFortEnviromentSandBox)
        
        //    let post:String = String(format: "fRawuF2DreDraceaccess_code=XNEw23o2DodbqTOLR6V3amount=10command=PURCHASEcurrency=SARcustomer_email=test@gmail.comlanguage=enmerchant_identifier=qxbVGjJKmerchant_reference=%@fRawuF2DreDrace",self.orderId)
        
        let post:String = String(format: "fRawuF2DreDraceaccess_code=XNEw23o2DodbqTOLR6V3language=enmerchant_identifier=qxbVGjJKmerchant_reference=%@service_command=TOKENIZATIONfRawuF2DreDrace","")
        
        /* test payfort */
        
        let str:String = String(format:"https://sbpaymentservices.payfort.com/FortAPI/paymentApi")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        print(post)
        print(post.sha256())
        
        parameter.setValue("SDK_TOKEN", forKey: "service_command")
        parameter.setValue("qxbVGjJK", forKey: "merchant_identifier")
        parameter.setValue("XNEw23o2DodbqTOLR6V3", forKey: "access_code")
        parameter.setValue("en", forKey: "language")
        parameter.setValue("0cdb4c9b705826de3fd3b548515f5916197ff3f38965a38e5527ce9654387623", forKey: "signature")
        parameter.setValue(PayFortObj.getUDID() , forKey: "device_id")
        
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
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    
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
        task.resume()
    }
    
    //MARK:- Memory managment method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
