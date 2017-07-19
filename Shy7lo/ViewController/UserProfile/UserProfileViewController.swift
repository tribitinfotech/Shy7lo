//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblShop: UILabel!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var heightLogout: NSLayoutConstraint!
    @IBOutlet weak var btnSIgnUp: UIButton!
    
    @IBOutlet weak var btnSignIn: UIButton!

    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnMyAccount: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    //View country
    @IBOutlet weak var viewCountry: UIView!
    
    @IBOutlet weak var imgCountryDetail: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblStaticCountry: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    
    //VIew Language
    
    @IBOutlet weak var imgLanguage: UIImageView!
    
    @IBOutlet weak var viewLanguage: UIView!
    
    @IBOutlet weak var imgDetailLanguage: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblStaticLanguage: UILabel!
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    
    var isFromLoginOrSignUp:Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if UserDefaults.standard.integer(forKey: "badge") != 0
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
        }
        else
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
        }
        
        self.repositionBadge(tabIndex: 3)
        
        if self.isFromLoginOrSignUp == true {
            
            self.isFromLoginOrSignUp = false
            
            if isEnglish {
                
                let check:UserDashboardViewController = UserDashboardViewController(nibName: "UserDashboardViewController", bundle: nil)
                self.navigationController?.pushViewController(check, animated: false)
            }
            else
            {
                /*let check:UserDashboardViewController = UserDashboardViewController(nibName: "UserDashboardViewController", bundle: nil)
                let transition = CATransition()
                transition.duration = 0.45
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                self.navigationController?.view?.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(check, animated: false)*/
                
                let check:UserDashboardViewController = UserDashboardViewController(nibName: "UserDashboardViewController", bundle: nil)
                self.navigationController?.pushViewController(check, animated: false)
                
            }
        }
        
        self.navigationController?.isNavigationBarHidden = true
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.btnSignIn.backgroundColor = .clear
        self.btnSignIn.layer.cornerRadius = 0
        self.btnSignIn.layer.borderWidth = 1
        self.btnSignIn.layer.borderColor = UIColor.black.cgColor
        
        self.btnMyAccount.backgroundColor = .clear
        self.btnMyAccount.layer.cornerRadius = 0
        self.btnMyAccount.layer.borderWidth = 1
        self.btnMyAccount.layer.borderColor = UIColor.black.cgColor
        
        self.btnSIgnUp.backgroundColor = .clear
        self.btnSIgnUp.layer.cornerRadius = 0
        self.btnSIgnUp.layer.borderWidth = 1
        self.btnSIgnUp.layer.borderColor = UIColor.black.cgColor
        
        self.btnLogOut.backgroundColor = .clear
        self.btnLogOut.layer.cornerRadius = 0
        self.btnLogOut.layer.borderWidth = 1
        self.btnLogOut.layer.borderColor = UIColor.black.cgColor
        
        
        if isEnglish {
            
            self.lblLanguage.text = "English"
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
            self.viewCountry.transform = CGAffineTransform.identity
            self.imgCountryDetail.transform = CGAffineTransform.identity
            self.lblCountry.transform = CGAffineTransform.identity
            self.lblStaticCountry.transform = CGAffineTransform.identity
            self.imgCountry.transform = CGAffineTransform.identity
            
            self.lblCountry.textAlignment = .right
            self.lblStaticCountry.textAlignment = .left
            
            self.viewLanguage.transform = CGAffineTransform.identity
            self.lblLanguage.transform = CGAffineTransform.identity
            self.lblStaticLanguage.transform = CGAffineTransform.identity
            
            self.lblLanguage.textAlignment = .right
            self.lblStaticLanguage.textAlignment = .left
            
            self.lblShop.transform = CGAffineTransform.identity
            
            self.lblShop.font = UIFont(name: appDel.strFont_Bold, size: 16.0)!
            self.btnSignIn.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
            self.btnSIgnUp.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
            
            self.lblUserName.font = UIFont(name: appDel.strFont, size: 16.0)!
            self.btnMyAccount.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
            
            self.lblLanguage.font = UIFont(name: appDel.strFont, size: 17.0)!
            self.lblStaticLanguage.font = UIFont(name: appDel.strFont, size: 17.0)!
            self.lblCountry.font = UIFont(name: appDel.strFont, size: 17.0)!
            self.lblStaticCountry.font = UIFont(name: appDel.strFont, size: 17.0)!
            
            self.btnLogOut.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
        }
        else
        {
            self.lblLanguage.text = "العربية"
            
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.viewCountry.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblCountry.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticCountry.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblCountry.textAlignment = .left
            self.lblStaticCountry.textAlignment = .right
            
            
            self.viewLanguage.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblLanguage.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticLanguage.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblLanguage.textAlignment = .left
            self.lblStaticLanguage.textAlignment = .right
            
            self.lblShop.textAlignment = .right
            
            self.lblShop.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)!
            self.btnSignIn.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 15.0)!
            self.btnSIgnUp.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 15.0)!
            
            self.lblLanguage.font = UIFont(name: appDel.strFontKufi, size: 17.0)!
            self.lblStaticLanguage.font = UIFont(name: appDel.strFontKufi, size: 17.0)!
            self.lblCountry.font = UIFont(name: appDel.strFontKufi, size: 17.0)!
            self.lblStaticCountry.font = UIFont(name: appDel.strFontKufi, size: 17.0)!
            
            self.lblUserName.font = UIFont(name: appDel.strFontKufi, size: 16.0)!
            self.btnMyAccount.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 15.0)!
            self.btnLogOut.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 15.0)!
        }
        
        self.lblCountry.text = UserDefaults.standard.value(forKey: "country_name") as! String?
        
        self.lblShop.text = appDel.mapping?.string(forKey: "Shop")
        
        self.lblStaticLanguage.text = appDel.mapping?.string(forKey: "Language")
        
        self.lblStaticCountry.text = appDel.mapping?.string(forKey: "Country")
        
        self.btnSIgnUp.setTitle(appDel.mapping?.string(forKey: "Sign Up"), for: UIControlState.normal)
        self.btnSignIn.setTitle(appDel.mapping?.string(forKey: "Sign In"), for: UIControlState.normal)
        self.btnMyAccount.setTitle(appDel.mapping?.string(forKey: "My Account"), for: UIControlState.normal)
        
        self.btnLogOut.setTitle(appDel.mapping?.string(forKey: "Logout"), for: UIControlState.normal)
        
        self.setUpUI()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK:- Private method
    func setUpUI()
    {
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            self.lblUserName.isHidden = false
            self.btnMyAccount.isHidden = false
            
            self.lblUserName.text = "Hi, \((UserDefaults.standard.value(forKey: "userName") as? String)!)"
            
            self.btnSignIn.isHidden = true
            self.btnSIgnUp.isHidden = true
            
            self.heightLogout.constant = 45
        }
        else
        {
            self.lblUserName.isHidden = true
            self.btnMyAccount.isHidden = true
            
            self.btnSignIn.isHidden = false
            self.btnSIgnUp.isHidden = false
            
            self.heightLogout.constant = 0
        }
    }
    func repositionBadge(tabIndex: Int){
        
        for badgeView in self.tabBarController!.tabBar.subviews[tabIndex].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
            }
        }
    }
    
    //MARK:- Action zones
    @IBAction func btnLogoutAction(_ sender: Any)
    {
        UserDefaults.standard.setValue("", forKey: "userDetail")
        
        UserDefaults.standard.setValue("", forKey: "userName")
        
        UserDefaults.standard.setValue("", forKey: "user_authorization")
        
        UserDefaults.standard.set("", forKey: "user_cart_id")
        
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(nil, forKey: "badge")
        
        UserDefaults.standard.synchronize()
        
        
        self.appDel.isUserLogout = true
        
        if UserDefaults.standard.integer(forKey: "badge") != 0
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
        }
        else
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
        }
        
        self.repositionBadge(tabIndex: 3)
        
        self.appDel.createEmptyCart()
        
        self.setUpUI()
        
    }
    @IBAction func btnMyAccountAction(_ sender: Any)
    {
        let check:UserDashboardViewController = UserDashboardViewController(nibName: "UserDashboardViewController", bundle: nil)
        self.navigationController?.pushViewController(check, animated: false)
    }
    @IBAction func btnSignUpAction(_ sender: Any)
    {
        let obj:SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
         obj.selectedIndex = 0
        obj.objProfile = self
        self.present(obj, animated: true, completion: nil)
    }
    
    @IBAction func btnSignInAction(_ sender: Any)
    {
        let obj:SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        obj.selectedIndex = 1
        obj.objProfile = self
        self.present(obj, animated: true, completion: nil)
    }
    @IBAction func btnCountryAction(_ sender: Any)
    {
        if isEnglish {
            
            let check:CountrySelectionViewController = CountrySelectionViewController(nibName: "CountrySelectionViewController", bundle: nil)
            check.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(check, animated: true)
        }
        else
        {
            let check:CountrySelectionViewController = CountrySelectionViewController(nibName: "CountrySelectionViewController", bundle: nil)
            check.hidesBottomBarWhenPushed = true
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            navigationController?.view?.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(check, animated: false)
            
        }
    }
    
    @IBAction func btnLanguageAction(_ sender: Any)
    {
        if isEnglish {
            
            let check:LanguageSelection = LanguageSelection(nibName: "LanguageSelection", bundle: nil)
            check.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(check, animated: true)
        }
        else
        {
            let check:LanguageSelection = LanguageSelection(nibName: "LanguageSelection", bundle: nil)
            check.hidesBottomBarWhenPushed = true
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            navigationController?.view?.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(check, animated: false)
            
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
