//
//  HomeViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 31/08/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class HomeViewController: RRNCollapsableTableViewController,UIWebViewDelegate {
    
    @IBOutlet weak var wbView: UIWebView!
    
    @IBOutlet weak var wbMen: UIWebView!
    
    @IBOutlet weak var wbKids: UIWebView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var sepLeading: NSLayoutConstraint!
    @IBOutlet weak var btnMen: UIButton!
    @IBOutlet weak var btnWomen: UIButton!
    @IBOutlet weak var btnKids: UIButton!
    @IBOutlet weak var imgSep: UIImageView!
    var menu = ModelBuilder.buildMenu()
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var scrlHeight: NSLayoutConstraint!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var scrlView: UIScrollView!
    
    var arrBanners:NSMutableArray = NSMutableArray()
    
    var arr:NSMutableArray?
    
    var HUD : MBProgressHUD?
    
    var isInPushState:Bool = false
   
    
    //MARK:- VIew life cycle
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if appDel.isFromProductList == true {
            
            appDel.isFromProductList = false
            
            self.setUpUI()
            
            var strURL:String = ""
            
            if isEnglish
            {
                strURL = "\(BANNER_URL)/mobile/banners/en"
            }
            else
            {
                strURL = "\(BANNER_URL)/mobile/banners/ar"
            }
            
            let url:URL = URL(string: strURL)!
            let urlreq:URLRequest = URLRequest(url: url)
            self.wbView.loadRequest(urlreq)
            
            
            var strURLMen:String = ""
            
            if isEnglish
            {
                strURLMen = "\(BANNER_URL)/mobile/men-banners/en"
            }
            else
            {
                strURLMen = "\(BANNER_URL)/mobile/men-banners/ar"
            }

            let urlMen:URL = URL(string: strURLMen)!
            let urlreqMen:URLRequest = URLRequest(url: urlMen)
            self.wbMen.loadRequest(urlreqMen)
            
            var strURLKids:String = ""
            
            if isEnglish
            {
                strURLKids = "\(BANNER_URL)/mobile/kids-banners/en"
            }
            else
            {
                strURLKids = "\(BANNER_URL)/mobile/kids-banners/ar"
            }
            
            let urlKids:URL = URL(string: strURLKids)!
            let urlreqKids:URLRequest = URLRequest(url: urlKids)
            self.wbKids.loadRequest(urlreqKids)
            
            self.wbMen.isHidden = true
            self.wbKids.isHidden = true
            self.wbView.isHidden = false
            
            self.btnMen.isSelected = false
            self.btnWomen.isSelected = true
            self.btnKids.isSelected = false
            
            self.sepLeading.constant = 0
        }
        
        print(UserDefaults.standard.integer(forKey: "badge"))
        
        if UserDefaults.standard.integer(forKey: "badge") != 0
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
        }
        else
        {
            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
        }
        
        self.repositionBadge(tabIndex: 3)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.navigateToBannerListDetail),
            name: NSNotification.Name(rawValue: "userNavigate"),
            object: nil)
        
        
        BasicStuff.basic.addHUD()
        
        self.btnMen.isSelected = false
        self.btnWomen.isSelected = true
        self.btnKids.isSelected = false
        
        /** HUD  **/
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        if UIScreen.main.bounds.size.width == 320
        {
            self.scrlHeight.constant = 428
        }
        else if UIScreen.main.bounds.size.width == 375
        {
            self.scrlHeight.constant = 527
        }
        else if UIScreen.main.bounds.size.width == 414
        {
            self.scrlHeight.constant = 596
        }
        else
        {
            self.scrlHeight.constant = UIScreen.main.bounds.size.height - 142
        }

        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.getHeight(_:)), name: NSNotification.Name(rawValue: "getTableHeight"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.reloadCategories(_:)), name: NSNotification.Name(rawValue: "reloadCategories"), object: nil)
        
        menu = ModelBuilder.buildMenu()
        
        self.navigationController?.isNavigationBarHidden = true

        print(" \(appDel.dictCategory.allKeys.count) \(self.tableView.frame)")
        
        self.perform(#selector(setTableFrame), with: self, afterDelay: 0.1)

        if UserDefaults.standard.bool(forKey: "guestCartCreated") == false {
            
            UserDefaults.standard.set(true, forKey: "guestCartCreated")
            UserDefaults.standard.synchronize()
            
             self.appDel.createEmptyCart()
        }
        
        
        self.setUpUI()
        
        var strURL:String = ""
        
        if isEnglish
        {
            strURL = "\(BANNER_URL)/mobile/banners/en"
        }
        else
        {
            strURL = "\(BANNER_URL)/mobile/banners/ar"
        }
        
        let url:URL = URL(string: strURL)!
        let urlreq:URLRequest = URLRequest(url: url)
        self.wbView.loadRequest(urlreq)
        
        
        var strURLMen:String = ""
        
        if isEnglish
        {
            strURLMen = "\(BANNER_URL)/mobile/men-banners/en"
        }
        else
        {
            strURLMen = "\(BANNER_URL)/mobile/men-banners/ar"
        }
        
        let urlMen:URL = URL(string: strURLMen)!
        let urlreqMen:URLRequest = URLRequest(url: urlMen)
        self.wbMen.loadRequest(urlreqMen)
        
        var strURLKids:String = ""
        
        if isEnglish
        {
            strURLKids = "\(BANNER_URL)/mobile/kids-banners/en"
        }
        else
        {
            strURLKids = "\(BANNER_URL)/mobile/kids-banners/ar"
        }
        
        let urlKids:URL = URL(string: strURLKids)!
        let urlreqKids:URLRequest = URLRequest(url: urlKids)
        self.wbKids.loadRequest(urlreqKids)
        
        self.wbMen.isHidden = true
        self.wbKids.isHidden = true
        self.wbView.isHidden = false
        
        self.sepLeading.constant = 0
        
        if appDel.isComingFromForceQuit == true {
            
            appDel.isComingFromForceQuit = false
            
            if appDel.isLoginSignUpPresent == true {
                
                appDel.isLoginSignUpPresent = false
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissSignUp"), object: nil)
                
            }
            
            let userInfo:NSDictionary = appDel.dictPush!
            
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "0"
            {
                //banner
                
                if (NSLocale.preferredLanguages[0] ).contains("ar") == true
                {
                    self.tabBarController?.selectedIndex = 4
                }
                else
                {
                     self.tabBarController?.selectedIndex = 0
                }
                
                if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "women" {
                    self.btnWomenAction(self.btnWomen)
                }
                if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "men" {
                    self.btnMenAction(self.btnMen)
                }
                if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "kids" {
                    self.btnKidsAction(self.btnKids)
                }
            }
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "1"
            {
                //product list
                
                if (NSLocale.preferredLanguages[0] ).contains("ar") == true
                {
                    self.tabBarController?.selectedIndex = 4
                }
                else
                {
                    self.tabBarController?.selectedIndex = 0
                }
                
                let dictToPass:NSMutableDictionary = NSMutableDictionary()
                
                let strBannerUrl:String = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String
                
                if strBannerUrl.contains("?") == true {
                    
                    let arr:NSArray = strBannerUrl.components(separatedBy: "?") as NSArray
                    
                    if arr.count > 1 {
                        
                        let str:String = arr.object(at: 1) as! String
                        
                        let arrParameter:NSArray = str.components(separatedBy: "&") as NSArray
                        
                        for i in 0..<arrParameter.count
                        {
                            let strParam:String = arrParameter.object(at: i) as! String
                            
                            let arrFinalParameter:NSArray = strParam.components(separatedBy: "=") as NSArray
                            
                            if arrFinalParameter.count > 1 {
                                
                                if arrFinalParameter.object(at: 0) as! String == "brand" {
                                    
                                    let dictFilterBody:NSMutableDictionary = NSMutableDictionary()
                                    
                                    if arrFinalParameter.object(at: 1) as? String != "null"
                                    {
                                        dictFilterBody.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                                    }
                                    else
                                    {
                                        // dictFilterBody.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                                    }
                                    
                                    dictToPass.setValue(dictFilterBody, forKey: "filterdata")
                                    
                                }
                                else
                                {
                                    if arrFinalParameter.object(at: 1) as? String != "null"
                                    {
                                        dictToPass.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                                    }
                                    else
                                    {
                                        dictToPass.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    print(dictToPass)
                    
                    
                    if isEnglish {
                        
                        self.isInPushState = true
                        let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                        obj.dictBanner = dictToPass
                        appDel.filterSortIndex = 2
                        appDel.isGridSelected = true
                        self.navigationController?.pushViewController(obj, animated: false)
                    }
                    else
                    {
                        self.isInPushState = true
                        let obj = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                        obj.dictBanner = dictToPass
                        appDel.filterSortIndex = 2
                        appDel.isGridSelected = true
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
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "2"
            {
                //SKU
                                
                if (NSLocale.preferredLanguages[0] ).contains("ar") == true
                {
                    self.tabBarController?.selectedIndex = 4
                }
                else
                {
                    self.tabBarController?.selectedIndex = 0
                }
                
                if isEnglish {
                    
                    let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
                    obj.strProductSKU = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String as NSString?
                    obj.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(obj, animated: false)
                }
                else
                {
                    let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
                    obj.strProductSKU = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String as NSString?
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
        
    }
    
    //MARK:- private method
    
    func navigateToBannerListDetail(notification: NSNotification){
        
        if appDel.isLoginSignUpPresent == true {
            
            appDel.isLoginSignUpPresent = false
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissSignUp"), object: nil)
            
        }
        
        let userInfo:NSDictionary = notification.object as! NSDictionary
        
        if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "0"
        {
            //banner
            
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                (self.tabBarController?.viewControllers?[4] as! UINavigationController).popToRootViewController(animated: false)
                self.tabBarController?.selectedIndex = 4
                
            }
            else
            {
                (self.tabBarController?.viewControllers?[0] as! UINavigationController).popToRootViewController(animated: false)
                self.tabBarController?.selectedIndex = 0
            }
            
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "women" {
                self.btnWomenAction(self.btnWomen)
            }
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "men" {
                self.btnMenAction(self.btnMen)
            }
            if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String == "kids" {
                self.btnKidsAction(self.btnKids)
            }
        }
        if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "1"
        {
            //product list
            
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                self.tabBarController?.selectedIndex = 4
            }
            else
            {
                self.tabBarController?.selectedIndex = 0
            }
            
            let dictToPass:NSMutableDictionary = NSMutableDictionary()
            
            let strBannerUrl:String = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String
            
            if strBannerUrl.contains("?") == true {
                
                let arr:NSArray = strBannerUrl.components(separatedBy: "?") as NSArray
                
                if arr.count > 1 {
                    
                    let str:String = arr.object(at: 1) as! String
                    
                    let arrParameter:NSArray = str.components(separatedBy: "&") as NSArray
                    
                    for i in 0..<arrParameter.count
                    {
                        let strParam:String = arrParameter.object(at: i) as! String
                        
                        let arrFinalParameter:NSArray = strParam.components(separatedBy: "=") as NSArray
                        
                        if arrFinalParameter.count > 1 {
                            
                            if arrFinalParameter.object(at: 0) as! String == "brand" {
                                
                                let dictFilterBody:NSMutableDictionary = NSMutableDictionary()
                                
                                if arrFinalParameter.object(at: 1) as? String != "null"
                                {
                                    dictFilterBody.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                                }
                                else
                                {
                                    // dictFilterBody.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                                }
                                
                                dictToPass.setValue(dictFilterBody, forKey: "filterdata")
                                
                            }
                            else
                            {
                                if arrFinalParameter.object(at: 1) as? String != "null"
                                {
                                    dictToPass.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                                }
                                else
                                {
                                    dictToPass.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                                }
                            }
                        }
                        
                    }
                }
                
                print(dictToPass)
                
                if isEnglish {
                    
                    self.isInPushState = true
                    let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                    obj.dictBanner = dictToPass
                    appDel.filterSortIndex = 2
                    appDel.isGridSelected = true
                    self.navigationController?.pushViewController(obj, animated: false)
                }
                else
                {
                    self.isInPushState = true
                    let obj = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                    obj.dictBanner = dictToPass
                    appDel.filterSortIndex = 2
                    appDel.isGridSelected = true
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
        if ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "m_t") as! String == "2"
        {
            //SKU
            
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                self.tabBarController?.selectedIndex = 4
            }
            else
            {
                self.tabBarController?.selectedIndex = 0
            }
  
            if isEnglish {
                
                let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
                obj.strProductSKU = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String as NSString?
                obj.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(obj, animated: false)
            }
            else
            {
                let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
                obj.strProductSKU = ((userInfo as NSDictionary).value(forKey: "extraPayLoad") as! NSDictionary).value(forKey: "d_t") as! String as NSString?
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
    func repositionBadge(tabIndex: Int){
        
        for badgeView in self.tabBarController!.tabBar.subviews[tabIndex].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
            }
        }
    }
    func setUpUI()
    {
        if isEnglish {
            
            self.imgLogo.image = UIImage(named: "ic_top_logo.png")
            
            self.btnMen.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 16.0)
            
            self.btnWomen.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 16.0)
            
            self.btnKids.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 16.0)
            
            self.viewTop.transform = CGAffineTransform.identity
            self.btnWomen.transform = CGAffineTransform.identity
            self.btnMen.transform = CGAffineTransform.identity
            self.btnKids.transform = CGAffineTransform.identity
            self.viewBanner.transform = CGAffineTransform.identity
            
            for item  in self.viewBanner.subviews {
                
                if item.isKind(of: UIImageView.self) {
                    
                    let img:UIImageView = item as! UIImageView
                    img.transform = CGAffineTransform.identity
                }
            }
            
        }
        else
        {
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            
            self.btnMen.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
            
            self.btnWomen.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
            
            self.btnKids.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnMen.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnWomen.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnKids.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewBanner.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            for item  in self.viewBanner.subviews {
                
                if item.isKind(of: UIImageView.self) {
                    
                    let img:UIImageView = item as! UIImageView
                    img.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
                }
            }
        }
        
        self.btnMen.setTitle(appDel.mapping?.string(forKey: "Men").uppercased(), for: UIControlState.normal)
        self.btnWomen.setTitle(appDel.mapping?.string(forKey: "Women").uppercased(), for: UIControlState.normal)
        self.btnKids.setTitle(appDel.mapping?.string(forKey: "Kids").uppercased(), for: UIControlState.normal)
        
    }
    
    func getBanners()
    {
        HUD?.show(true)
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        /*manager.requestSerializer.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjM3MjVhZTA0MWVjNzNkZDIxMmMwNWUyOTYxNWIzNmFhNzNiNWI4NjVlMTdlYTQxYWZkYmUyZWZmMDRiZTMwNjg0M2FjYjJiZTY3OGQ4ZjAxIn0.eyJhdWQiOiIxIiwianRpIjoiMzcyNWFlMDQxZWM3M2RkMjEyYzA1ZTI5NjE1YjM2YWE3M2I1Yjg2NWUxN2VhNDFhZmRiZTJlZmYwNGJlMzA2ODQzYWNiMmJlNjc4ZDhmMDEiLCJpYXQiOjE0NzI1NDY4OTAsIm5iZiI6MTQ3MjU0Njg5MCwiZXhwIjo0NjI4MjIwNDkwLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Iwrh6o23dnzW8m9moSGODfMFYP44Lx80iSzboI337NK5MaYN0MEzsdyjXSn8WJEdHF9wVWNYBkkGcxgyHv-jv8ORzcaWpFdmrX-miRbMXBJFNtaPu0nIKn89u0EiCVoaLRssP0nXcn4PUdQCnyFexRzqAjV_QThFYGVf67_Cf2YbzdB1o0uFK9lkTzmwEiCgwAh5z_zqXdCBdNHPUZq4nZsHgY44Zl02HiMMdF8jfEIwNmj0O-wM-cO50cAlEId-pDLNfYqKh8y9OB2k3gRTv-l538NAg8QAcMBRhvESi2NPSXSX0EsrXpI8mItJg2piBUt_D_2ZRDcRclgi4iaNzjOAGfjOEj1mUvhI0_2LrAIyNfgYq7bixLrDV6iji8DzkgL6Hy141TntAqedk-_-L1cyp845b7qc-45x5LlGgJlxJX-xFZcGOV0nj02xHL5crBxBTAw8Uvjb0hSI86lQNcpAd8_HSInV61ZzoteeGZuwSoezu4Jb-34uX0FLh_CkMjsSB9xLTttJhvagCaahAEevkl5f1VxxX4ha-KHBWWsVY4j2z8NGP5tqCFMjcJpFk9L7VFaekhSD3HJS_HrIYItsp6z99d1mno6FeWCTyPtdkqtvVXMm6QjLW7EG14HQkLJBJgEk0rzFk2b7HC5TX6VZFoJsk5bbvqig4biKWXw", forHTTPHeaderField: "Authorization")*/
        
        manager.get("\(API_URL)/v1/screen/banners/1", parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                
                print(jsonResult)
                
                if jsonResult.value(forKey: "success") as! Int == 1
                {
                    self.arrBanners = jsonResult.value(forKey: "data") as! NSMutableArray
                }
                
                print(self.arrBanners )
                

                for view in self.viewBanner.subviews
                {
                    if view.isKind(of: UIImageView.self)
                    {
                        let imgView:UIImageView = view as! UIImageView
                        
                        imgView.isUserInteractionEnabled = true
                        
                        imgView.sd_setImage(with: NSURL(string: (self.arrBanners.object(at: imgView.tag) as! NSMutableDictionary).value(forKey: "img") as! String) as URL!, placeholderImage: nil)
                        
                       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.bannedTapped(_:)))
                       tapGesture.accessibilityValue = String(format: "%d", imgView.tag)
                       imgView.addGestureRecognizer(tapGesture)
                    }
                }
                
                if self.appDel.categoryKeys.count > 0
                {
                    self.HUD?.hide(true)
                }
                else
                {
                    self.appDel.getCategories()
                }
                
                
                
                // use jsonData
            } catch let err{
                // report error
                
                self.HUD?.hide(true)
                
                print(err)
            }
            
            }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                self.HUD?.hide(true)
                
                
        })

    }
    
    func bannedTapped(_ sender: UITapGestureRecognizer)
    {
        let tap:UITapGestureRecognizer = sender 
        
        print(tap.accessibilityValue)
        let strIndex:String = tap.accessibilityValue!
        let index:Int? = Int(strIndex)
        
        let dict:NSMutableDictionary = self.arrBanners.object(at: index!) as! NSMutableDictionary
        
        if dict.value(forKey: "search_criteria") as? String != nil {
            // do something with value
            
            
            if isEnglish {
                
                let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                appDel.filterSortIndex = 2
                appDel.isGridSelected = true
                obj.dictBanner = self.arrBanners.object(at: index!) as! NSMutableDictionary
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                let obj = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                appDel.filterSortIndex = 2
                appDel.isGridSelected = true
                obj.dictBanner = self.arrBanners.object(at: index!) as! NSMutableDictionary
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
    
    func setTableFrame()
    {
        if appDel.categoryKeys.count > 0 {
            
            let str:String = appDel.categoryKeys.object(at: 0) as! String
            
            self.tblHeight.constant =  CGFloat(44*(appDel.dictCategory.value(forKey: str) as! NSMutableArray).count) + (CGFloat(appDel.dictCategory.allKeys.count + 1))*44
            
            // self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.tableView.frame.origin.y, width: self.tableView.frame.size.width, height: CGFloat(44*(appDel.dictCategory.value(forKey: str) as! NSMutableArray).count) + (CGFloat(appDel.dictCategory.allKeys.count + 1))*44)
            
            print(" \(appDel.dictCategory.allKeys.count) \(self.tableView.frame)")
            
            //self.scrlView.contentSize = CGSize(width: 0, height: self.tableView.frame.origin.y + self.tableView.frame.size.height)
        }
       
    }
    func reloadCategories(_ pnotification:Notification)
    {
        self.HUD?.hide(true)
        
        menu = ModelBuilder.buildMenu()
        
        self.tableView.reloadData()
        
        self.setTableFrame()
    }
    func getHeight(_ pnotification:Notification)
    {
        print(pnotification.object ?? "")
        
        let count:CGFloat =  CGFloat(pnotification.object as! Int)
        
         self.tblHeight.constant =   44*count + (CGFloat(appDel.dictCategory.allKeys.count) + 1)*44
        
       // self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.tableView.frame.origin.y, width: self.tableView.frame.size.width, height: 44*count + (CGFloat(appDel.dictCategory.allKeys.count) + 1)*44)
        
        print("\(count) \(appDel.dictCategory.allKeys.count) \(self.tableView.frame)")
        
        
        //self.scrlView.contentSize = CGSize(width: 0, height: self.tableView.frame.origin.y + self.tableView.frame.size.height)

        
    }
    
    //MARK:- Wenview delegate method
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        print(request.url?.absoluteString ?? "")
        
        let dictToPass:NSMutableDictionary = NSMutableDictionary()
        
        let strBannerUrl:String = (request.url?.absoluteString)!
        
        if strBannerUrl.contains("?") == true {
            
            let arr:NSArray = strBannerUrl.components(separatedBy: "?") as NSArray
            
            if arr.count > 1 {
                
                let str:String = arr.object(at: 1) as! String
                
                let arrParameter:NSArray = str.components(separatedBy: "&") as NSArray
                
                for i in 0..<arrParameter.count
                {
                    let strParam:String = arrParameter.object(at: i) as! String
                    
                    let arrFinalParameter:NSArray = strParam.components(separatedBy: "=") as NSArray
                    
                    if arrFinalParameter.count > 1 {
                        
                        if arrFinalParameter.object(at: 0) as! String == "brand" {
                            
                            let dictFilterBody:NSMutableDictionary = NSMutableDictionary()
                            
                            if arrFinalParameter.object(at: 1) as? String != "null"
                            {
                                dictFilterBody.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                            }
                            else
                            {
                               // dictFilterBody.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                            }
                            
                            dictToPass.setValue(dictFilterBody, forKey: "filterdata")
                            
                        }
                        else
                        {
                            if arrFinalParameter.object(at: 1) as? String != "null"
                            {
                                dictToPass.setValue(arrFinalParameter.object(at: 1) as? String, forKey: arrFinalParameter.object(at: 0) as! String)
                            }
                            else
                            {
                                dictToPass.setValue("", forKey: arrFinalParameter.object(at: 0) as! String)
                            }
                        }
                    }
                    
                }
            }
            
            print(dictToPass)
            
            
            if isEnglish {
                
                self.isInPushState = true
                let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                appDel.filterSortIndex = 2
                appDel.isGridSelected = true
                obj.dictBanner = dictToPass
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else
            {
                self.isInPushState = true
                let obj = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
                appDel.filterSortIndex = 2
                appDel.isGridSelected = true
                obj.dictBanner = dictToPass
                let transition = CATransition()
                transition.duration = 0.45
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                navigationController?.view?.layer.add(transition, forKey: nil)
                navigationController?.pushViewController(obj, animated: false)
                
            }

        }
        
        
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.HUD?.show(true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        if self.isInPushState == true {
            
            self.isInPushState = false
        }
        else
        {
            self.HUD?.hide(true)
        }
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        if self.isInPushState == true {
            
            self.isInPushState = false
        }
        else
        {
            self.HUD?.hide(true)
        }

        
    }

    
    
    //MARK:- Action zones
    @IBAction func buttonPress(_ sender: AnyObject)
    {
        let btn:UIButton = sender as!UIButton
        
        print(btn.tag)
        
        if isEnglish {
            
            let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
            obj.isFromCategorySelection = true
            appDel.filterSortIndex = 2
            appDel.isGridSelected = true
            obj.strSelectedCategoryId = String(format:"%d",btn.tag)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            let obj = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
            obj.isFromCategorySelection = true
            appDel.filterSortIndex = 2
            appDel.isGridSelected = true
            obj.strSelectedCategoryId = String(format:"%d",btn.tag)
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            navigationController?.view?.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(obj, animated: false)
            
        }
        
    }
    @IBAction func btnWomenAction(_ sender: AnyObject)
    {
        FIRAnalytics.logEvent(withName: "Women_Banner", parameters: ["name":"Women_Banner"])
        
        self.btnMen.isSelected = false
        self.btnWomen.isSelected = true
        self.btnKids.isSelected = false
        
        /*var strURL:String = ""
        
        if isEnglish
        {
            strURL = "\(BANNER_URL)/mobile/banners/en"
        }
        else
        {
            strURL = "\(BANNER_URL)/mobile/banners/ar"
        }
        
        let url:URL = URL(string: strURL)!
        let urlreq:URLRequest = URLRequest(url: url)
        self.wbView.loadRequest(urlreq)*/
        
        self.wbMen.isHidden = true
        self.wbKids.isHidden = true
        self.wbView.isHidden = false
        
        var animDuration = 0.0
        
        animDuration = 0.3
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        self.sepLeading.constant = 0
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
       
    }
    
    @IBAction func btnMenAction(_ sender: AnyObject)
    {
        FIRAnalytics.logEvent(withName: "Men_Banner", parameters: ["name":"Men_Banner"])
        
        self.btnMen.isSelected = true
        self.btnWomen.isSelected = false
        self.btnKids.isSelected = false
        
       /* var strURL:String = ""
        
        if isEnglish
        {
            strURL = "\(BANNER_URL)/mobile/men-banners/en"
        }
        else
        {
            strURL = "\(BANNER_URL)/mobile/men-banners/ar"
        }
        
        let url:URL = URL(string: strURL)!
        let urlreq:URLRequest = URLRequest(url: url)
        self.wbView.loadRequest(urlreq) */
        
        self.wbMen.isHidden = false
        self.wbKids.isHidden = true
        self.wbView.isHidden = true
        
        var animDuration = 0.0
        
        animDuration = 0.3
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        self.sepLeading.constant = UIScreen.main.bounds.size.width/3
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    @IBAction func btnKidsAction(_ sender: AnyObject)
    {
        FIRAnalytics.logEvent(withName: "Kids_Banner", parameters: ["name":"Kids_Banner"])
        
        self.btnMen.isSelected = false
        self.btnWomen.isSelected = false
        self.btnKids.isSelected = true
        
        /*var strURL:String = ""
        
        if isEnglish
        {
            strURL = "\(BANNER_URL)/mobile/kids-banners/en"
        }
        else
        {
            strURL = "\(BANNER_URL)/mobile/kids-banners/ar"
        }
        
        let url:URL = URL(string: strURL)!
        let urlreq:URLRequest = URLRequest(url: url)
        self.wbView.loadRequest(urlreq)*/
        
        self.wbMen.isHidden = true
        self.wbKids.isHidden = false
        self.wbView.isHidden = true
        
        var animDuration = 0.0
        
        animDuration = 0.3
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        self.sepLeading.constant = 2*(UIScreen.main.bounds.size.width/3)
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    
    override func model() -> [RRNCollapsableSectionItemProtocol]? {
        return menu
    }
    
    override func sectionHeaderNibName() -> String? {
        return "MenuSectionHeaderView"
    }
    
    override func singleOpenSelectionOnly() -> Bool {
        return true
    }
    
    override func collapsableTableView() -> UITableView? {
        return tableView
    }
}

extension HomeViewController {
    
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let menuSection = self.model()?[(indexPath as NSIndexPath).section]
        
        print(menuSection?.items)
        
        let arr = menuSection!.items as NSArray
        
        print(appDel.setFont((cell.lblTitle.font?.pointSize)!))
        
        print(arr)
        
        cell.setUpUI()
        
        cell.lblTitle.font = UIFont(name: appDel.strFont, size: appDel.setFont(17.0))
        
        let str:String = (arr.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as! String
        
        cell.lblTitle.text = str
        
        
        cell.lblTitle.textColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        cell.contentView.layoutIfNeeded()
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        let menuSection = self.model()?[(indexPath as NSIndexPath).section]
        
        print(menuSection?.items ?? "")
        
        let arr = menuSection!.items as NSArray
        
        print((arr.object(at: indexPath.row) as! NSDictionary))
        
        if isEnglish {
            
            let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
            appDel.filterSortIndex = 2
            appDel.isGridSelected = true
            obj.isFromCategorySelection = true
            obj.strSelectedCategoryId = String(format:"%d",(arr.object(at: indexPath.row) as! NSDictionary).value(forKey: "id") as! Int)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            let obj:CategoryListViewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
            appDel.filterSortIndex = 2
            appDel.isGridSelected = true
            obj.isFromCategorySelection = true
            obj.strSelectedCategoryId = String(format:"%d",(arr.object(at: indexPath.row) as! NSDictionary).value(forKey: "id") as! Int)
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

