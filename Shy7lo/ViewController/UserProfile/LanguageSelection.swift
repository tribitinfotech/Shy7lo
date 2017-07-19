//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class LanguageSelection: UIViewController {

    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnArabic: UIButton!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var lblSelectYourCountry: UILabel!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var runkeeperSwitch4: DGRunkeeperSwitch!
    
    @IBOutlet weak var btnApply: UIButton!
    
    var selecteLanguage:NSInteger = 0
    
    var isEnglishLanguage:Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAnalytics.logEvent(withName: "Language", parameters: ["name":"Language"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        self.setUpUI()
        
        self.lblSelectYourCountry.text = appDel.mapping?.string(forKey: "Select language").uppercased()
        
        self.btnApply.setTitle(appDel.mapping?.string(forKey: "Apply").uppercased(), for: UIControlState.normal)
        
        
        if let runkeeperSwitch4 = runkeeperSwitch4 {
            runkeeperSwitch4.titles = ["English", "١لعربية"]
            runkeeperSwitch4.backgroundColor = UIColor.black
            runkeeperSwitch4.selectedBackgroundColor = UIColor.white
            runkeeperSwitch4.titleColor =  UIColor.white
            runkeeperSwitch4.selectedTitleColor = UIColor.black
            runkeeperSwitch4.titleFont = UIFont(name: "Tahoma-Bold", size: 14.0)
        }
        
        if isEnglish
        {
            self.selecteLanguage = 0
            self.isEnglishLanguage = true
            self.runkeeperSwitch4.setSelectedIndex(0, animated: false)
            
            self.btnEnglish.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            self.btnArabic.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            
            self.btnArabic.backgroundColor = UIColor.white
            self.btnArabic.setTitleColor(UIColor.black, for: .normal)
            
            self.btnEnglish.backgroundColor = UIColor.black
            self.btnEnglish.setTitleColor(UIColor.white, for: .normal)
        }
        else
        {
            self.selecteLanguage = 1
            self.isEnglishLanguage = false
            self.runkeeperSwitch4.setSelectedIndex(1, animated: false)
            
            self.btnEnglish.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            self.btnArabic.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 14.0)
            
            self.btnEnglish.backgroundColor = UIColor.white
            self.btnEnglish.setTitleColor(UIColor.black, for: .normal)
            
            self.btnArabic.backgroundColor = UIColor.black
            self.btnArabic.setTitleColor(UIColor.white, for: .normal)
        }

        // Do any additional setup after loading the view.
    }

    func setUpUI()
    {
        if isEnglish {
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
        }
        else
        {
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
        }
    }
    
    //MARK:- Action zones
    
    @IBAction func btnDismissAction(_ sender: Any)
    {
        if self.runkeeperSwitch4.selectedIndex == 0 {
            self.navigationController?.popViewController(animated: true)
            
        }
        else{
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            navigationController?.view?.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)

        }
       
    }
    
    @IBAction func btnApplyAction(_ sender: Any)
    {
        
        if  self.selecteLanguage == 0 {
            
            if self.isEnglishLanguage == true {
                
            }
            else
            {
                appDel.isFromProductList = true
                
                appDel.isLanguageChanged = true
                
                setLanguage(lang: .English)
                
                appDel.mapping = StringMapping.shared()
                
                appDel.mapping?.setLanguage()
                
                /*appDel.strFont = "Raleway-Regular"
                 appDel.strFont_Bold = "Raleway-SemiBold"*/
                
                appDel.strFont = "Tahoma"
                appDel.strFont_Bold = "Tahoma-Bold"
                
                self.setCountryCode()
                
                /*let arr:NSArray = NSArray(objects: appDel.tabBarController?.viewControllers![4] ?? "",appDel.tabBarController?.viewControllers![3] ?? "",appDel.tabBarController?.viewControllers![2] ?? "",appDel.tabBarController?.viewControllers![1] ?? "",appDel.tabBarController?.viewControllers![0] ?? "")
                
                print(arr)
                
                appDel.tabBarController?.viewControllers = arr as? [UIViewController]
                
                appDel.tabBarController?.selectedIndex = 4*/
                
                appDel.registerToken()
            }

        }
        else
        {
            if self.isEnglishLanguage == false
            {
                
            }
            else
            {
                appDel.isFromProductList = true
                
                appDel.isLanguageChanged = true
                
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
                
                self.setCountryCode()
                
                /*let arr:NSArray = NSArray(objects: appDel.tabBarController?.viewControllers![4] ?? "",appDel.tabBarController?.viewControllers![3] ?? "",appDel.tabBarController?.viewControllers![2] ?? "",appDel.tabBarController?.viewControllers![1] ?? "",appDel.tabBarController?.viewControllers![0] ?? "")
                
                print(arr)
                
                appDel.tabBarController?.viewControllers = arr as? [UIViewController]
                
                appDel.tabBarController?.selectedIndex = 0*/
                
                appDel.registerToken()
            }

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
        
        //self.navigationController?.present(appDel.tabBarController!, animated: false, completion: nil)
    }
    @IBAction func btnArabicAction(_ sender: AnyObject)
    {
         self.selecteLanguage = 1
        
        self.imgTitle.image = UIImage(named: "logo_arabic.png")
        self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        
        self.lblSelectYourCountry.text = "اللغة"
        
        self.btnApply.setTitle("المتابعة", for: UIControlState.normal)
        
        self.btnEnglish.backgroundColor = UIColor.white
        self.btnEnglish.setTitleColor(UIColor.black, for: .normal)
        
        self.btnArabic.backgroundColor = UIColor.black
        self.btnArabic.setTitleColor(UIColor.white, for: .normal)

    }
    @IBAction func btnEnglishAction(_ sender: AnyObject)
    {
         self.selecteLanguage = 0
        
        self.imgTitle.image = UIImage(named: "ic_top_logo.png")
        self.viewTop.transform = CGAffineTransform.identity
        self.imgTitle.transform = CGAffineTransform.identity
        
        self.lblSelectYourCountry.text = "SELECT LANGUAGE"
        
        self.btnApply.setTitle("APPLY", for: UIControlState.normal)
        
        self.btnArabic.backgroundColor = UIColor.white
        self.btnArabic.setTitleColor(UIColor.black, for: .normal)
        
        self.btnEnglish.backgroundColor = UIColor.black
        self.btnEnglish.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func switchValueDidChange(_ sender: AnyObject)
    {
        if sender.selectedIndex == 0
        {
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
            self.lblSelectYourCountry.text = "SELECT LANGUAGE"
            
            self.btnApply.setTitle("APPLY", for: UIControlState.normal)
        }
        else
        {
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSelectYourCountry.text = "اللغة"
            
            self.btnApply.setTitle("المتابعة", for: UIControlState.normal)
        }
    }
    
    func setCountryCode()
    {
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Saudi Arabia" {
           UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "SAR"), forKey: "currencyCode")
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "UAE" {
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "AED"), forKey: "currencyCode")
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Qatar" {
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "QAR"), forKey: "currencyCode")
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Oman" {
           UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "OMR"), forKey: "currencyCode")
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Kuwait" {
            UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "KWD"), forKey: "currencyCode")
        }
        if UserDefaults.standard.value(forKey: "country_name") as! String == "Bahrain" {
             UserDefaults.standard.setValue(appDel.mapping?.string(forKey: "BHD"), forKey: "currencyCode")
        }
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
