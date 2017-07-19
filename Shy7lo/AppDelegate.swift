//
//  AppDelegate.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/08/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseAnalytics
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate,NSURLConnectionDelegate,UIAlertViewDelegate {

    static let shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isFromProductList:Bool?
    
    var isListVewAppear:Bool = false
    
    var isLoginSignUpPresent:Bool?
    
    var isComingFromForceQuit:Bool?
    
    var dictPush:NSDictionary?
    
    var isUserLogout:Bool?
    
    var isForCategory:Bool?
    
    var isLanguageChanged:Bool?
    
    var tabSelectedIndex:NSInteger?
    
    var window: UIWindow?
    
    var HUD : MBProgressHUD?
    
    var isFromFavouriteSignIn:Bool = false
    
    var dataVal = NSMutableData()
    
    var nav:UINavigationController?

    var tabBarController:UITabBarController?
    
    var nav1:UINavigationController?
    var nav2:UINavigationController?
    var nav3:UINavigationController?
    var nav4:UINavigationController?
    var nav5:UINavigationController?
    
    var strFont:String = ""
    var strFont_Bold:String = ""
    
    var strFontKufi:String = ""
    var strFontKufi_Bold:String = ""
        
    var visibleIndex:NSInteger?
    
    var filterSortIndex:NSInteger = 0
    var isGridSelected:Bool = false
    
    var mapping: StringMapping?
    
    var dictCategory:NSMutableDictionary = NSMutableDictionary()
    var categoryKeys:NSMutableArray = NSMutableArray()
    var categoryIds:NSMutableArray = NSMutableArray()
    
    var arrCurrentProductImages:NSMutableArray = NSMutableArray()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame:UIScreen.main.bounds)
        
        mapping = StringMapping.shared()
        
        let objLand:UIViewController?
        
        var strNib:String = "LandingViewController"
        
       /* if UIDevice.current.userInterfaceIdiom == .pad {
            
            strNib = "LandingViewController_iPad"
        } */
        
        if let code = UserDefaults.standard.value(forKey: "countryCode") as? String {
            
            UserDefaults.standard.setValue(code.replacingOccurrences(of: "+", with: ""), forKey: "countryCode")
            UserDefaults.standard.synchronize()
            print(UserDefaults.standard.value(forKey: "countryCode") ?? "")
        }
        
        objLand = LandingViewController(nibName: strNib, bundle:nil)
        
        self.nav = UINavigationController(rootViewController: objLand!)
        
        self.nav?.isNavigationBarHidden = true
        
        self.nav = UINavigationController(rootViewController: objLand!)
        
        self.nav?.isNavigationBarHidden = true
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        if UserDefaults.standard.value(forKey: "FirstTime") == nil
        {
            setLanguage(lang: .Arabic)
            UserDefaults.standard.set(nil, forKey: "badge")
            UserDefaults.standard.set("", forKey: "user_authorization")
            UserDefaults.standard.set(false, forKey: "landingShow")
            UserDefaults.standard.set(true, forKey: "FirstTime")
            UserDefaults.standard.synchronize()
        }
        else{
            
            setLanguage(lang: .Default)
        }
        
        if launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil
        {
            var userInfo: NSDictionary!
            userInfo = launchOptions! as NSDictionary
            userInfo = userInfo.object(forKey: "UIApplicationLaunchOptionsRemoteNotificationKey") as! NSDictionary
            
            NSLog("userinfo == \(userInfo)")
            
            self.isComingFromForceQuit = true
            
            self.dictPush = NSDictionary()
            self.dictPush = userInfo
            
        }
        
        self.loadBannersInAdvance()
        
        self.checkVesrionAvailability()
        
         if UserDefaults.standard.bool(forKey: "landingShow")  == true
         {

            if isEnglish {

                if (NSLocale.preferredLanguages[0] ).contains("ar") == true
                {
                    self.setUpTabbarForArabic()
                    self.tabBarController?.selectedIndex = 4
                }
                else
                {
                    self.setUpTabbarForEnglish()
                    self.tabBarController?.selectedIndex = 0
                }
                
                
                self.strFont = "Tahoma"
                self.strFont_Bold = "Tahoma-Bold"
                
                self.mapping = StringMapping.shared()
                
                self.mapping?.setLanguage()
                
            }
            else
            {
                if (NSLocale.preferredLanguages[0] ).contains("ar") == true
                {
                    self.setUpTabbarForArabic()
                    self.tabBarController?.selectedIndex = 4
                }
                else
                {
                    self.setUpTabbarForEnglish()
                    self.tabBarController?.selectedIndex = 0
                }
                
                
                self.strFont = "Tahoma"
                self.strFont_Bold = "Tahoma-Bold"
                
                self.strFontKufi = "Tahoma"
                self.strFontKufi_Bold = "Tahoma-Bold"
                
                self.mapping = StringMapping.shared()
                
                self.mapping?.setLanguage()
            }
            
             self.window?.rootViewController = self.tabBarController
            
            
         }
         else
         {
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                self.setUpTabbarForArabic()
            }
            else
            {
                self.setUpTabbarForEnglish()
            }
            
             self.window?.rootViewController = self.nav
         }
 
        
        
        self.window?.makeKeyAndVisible()
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        
        registerForPushNotifications(application: application)
        
        
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return true
        }
        gai.tracker(withTrackingId: "UA-51821699-1")
        // Optional: automatically report uncaught exceptions.
        gai.trackUncaughtExceptions = true
        
        // Optional: set Logger to VERBOSE for debug information.
        // Remove before app release.
        gai.logger.logLevel = .verbose;
        
        FIRApp.configure()
        
        FIRAnalytics.logEvent(withName: "Splash", parameters: ["name":"Splash"])
                
        // Override point for customization after application launch.
        return true
    }
    
    //MARK:- Register token
    func checkVesrionAvailability()
    {
        
        let str:String = String(format:"\(API_URL)/v1/app/version")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        parameter.setValue("ios", forKey: "device_type")
        
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
            
            
            var jsonResult = NSDictionary()
            
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print(jsonResult)
                
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                {
                    print(version)
                    
                    if version != (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "version") as! String
                    {
                        UserDefaults.standard.setValue((jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "version") as! String, forKey: "appstoreVersion")
                        UserDefaults.standard.synchronize()
                        
                        if let lastSyncDate = UserDefaults.standard.value(forKey: "lastSyncDate") as? String
                        {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd.MM.yyyy"
                            
                            let strLastSync:String = UserDefaults.standard.value(forKey: "lastSyncDate") as! String
                            
                            let date = Date()
                            let result = formatter.string(from: date)
                            
                            let lastSyncDate:NSDate = formatter.date(from: strLastSync)! as NSDate
                            let currentDate:NSDate = formatter.date(from: result)! as NSDate
                            
                            var needToShowAlert:Bool = false
                            
                            switch lastSyncDate.compare(currentDate as Date) {
                            case .orderedAscending     :   needToShowAlert = true
                            case .orderedDescending    :   needToShowAlert = false
                            case .orderedSame          :   needToShowAlert = false
                            }
                            
                            if needToShowAlert == true {
                                
                                //show alert
                                DispatchQueue.main.async()
                                    {
                                        self.perform(#selector(self.showUpdateAlert), with: nil, afterDelay: 3)
                                }
                                
                                
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd.MM.yyyy"
                                let result = formatter.string(from: date)
                                
                                UserDefaults.standard.set(result, forKey: "lastSyncDate")
                                UserDefaults.standard.synchronize()
                            }
                            
                        }
                        else
                        {
                            //show alert of update
                            
                            DispatchQueue.main.async()
                                {
                                    self.perform(#selector(self.showUpdateAlert), with: nil, afterDelay: 3)
                            }
                            
                            let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd.MM.yyyy"
                            let result = formatter.string(from: date)
                            
                            UserDefaults.standard.set(result, forKey: "lastSyncDate")
                            UserDefaults.standard.synchronize()
                        }
                    }
                    else
                    {
                        UserDefaults.standard.setValue((jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "version") as! String, forKey: "appstoreVersion")
                        UserDefaults.standard.synchronize()
                    }

                }
                
                // use jsonData
            } catch {
                // report error
            }
            
            DispatchQueue.main.async()
                {
            }
            
            print(jsonResult)
            
        }
        task.resume()

    }
    func showUpdateAlert()
    {
        let alertTest = UIAlertView()
        alertTest.delegate = self
        
        alertTest.message = self.mapping?.string(forKey: "updateMessage")
        alertTest.addButton(withTitle: self.mapping?.string(forKey: "Upgrade"))
        alertTest.addButton(withTitle: self.mapping?.string(forKey: "Cancel"))
        alertTest.title = (self.mapping?.string(forKey: "Shy7lo"))!
        alertTest.tag = 99
        alertTest.show()

    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        
        if alertView.tag == 99 {
            
            switch buttonIndex
            {
            case 0:
                //upgrade
                let str:String = "itms://itunes.apple.com/us/app/shy7lo-online-fashion-shopping-%D8%AA%D8%B3%D9%88%D9%82-%D8%A7%D8%B2%D9%8A%D8%A7%D8%A1-%D8%B4%D9%8A-%D8%AD%D9%84%D9%88/id1125434285?ls=1&mt=8"
                UIApplication.shared.openURL(URL(string: str)!)
                break
            case 1:
                //cancel
                break
            default:
                break
            }
        }
        
    }
   
    func registerToken()
    {
        
        HUD?.show(true)
        
        let str:String = String(format:"\(API_URL)/v1/device/notification/add")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        
        parameter.setValue(UserDefaults.standard.value(forKey: "deviceToken") as! String, forKey: "device_token")
        parameter.setValue("ios", forKey: "device_type")
      
        self.showAlert(title: UserDefaults.standard.value(forKey: "deviceToken") as! String)
        
        NSLog("token == %@",parameter)
        
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
            
            
            var jsonResult = NSDictionary()
            
            do {
                jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print(jsonResult)
                
                // use jsonData
            } catch {
                // report error
            }
            
            DispatchQueue.main.async()
                {
            }
            
            print(jsonResult)
            
        }
        task.resume()
    }
    //MARK:- Push notification methods
    
    // Called when APNs has assigned the device a unique token
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings)
    {
        
        if notificationSettings.types != .none
        {
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        NSLog("APNs registration Key: \(deviceTokenString)")
        
        UserDefaults.standard.setValue(deviceTokenString, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
        self.registerToken()
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
        
        //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getToken"), object: nil)
        
        UserDefaults.standard.setValue("", forKey: "deviceToken")
        UserDefaults.standard.synchronize()
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        if UIApplication.shared.applicationState == UIApplicationState.background || UIApplication.shared.applicationState == UIApplicationState.inactive
        {
            
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userNavigate"), object: userInfo)
            
        }
        else
        {
            //self.showAlert(title: (((userInfo as NSDictionary).value(forKey: "aps") as! NSDictionary).value(forKey: "alert") as! NSDictionary).value(forKey: "title") as! String)
        }
        
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any])
    {
        // Print notification payload data
        print("Push notification received: \(data)")
        
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let dict = response.notification.request.content.userInfo as! NSDictionary
        print(dict)
        
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler([.badge, .alert, .sound])
        
    }
    /*func PushMethod() {
     
     if #available(iOS 10, *)
     {
     UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound])
     { (granted, error) in
     
     if granted
     {
     UIApplication.shared.registerForRemoteNotifications()
     }
     else
     {
     UserDefaults.standard.setValue("", forKey: "deviceToken")
     UserDefaults.standard.synchronize()
     
     //push
     
     }
     
     }
     
     }
     // iOS 9 support
     else if #available(iOS 9, *)
     {
     UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
     }
     // iOS 8 support
     else if #available(iOS 8, *)
     {
     UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
     UIApplication.shared.registerForRemoteNotifications()
     }
     // iOS 7 support
     else
     {
     UIApplication.shared.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
     }
     
     
     }*/
    
    func registerForPushNotifications(application: UIApplication)
    {
        
        // iOS 10 support
        if #available(iOS 10, *)
        {
            
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound])
            { (granted, error) in
                
                if granted
                {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                else
                {
                    UserDefaults.standard.setValue("", forKey: "deviceToken")
                    UserDefaults.standard.synchronize()
                    
                }
                
            }
            
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            UIApplication.shared.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
    }

  
    
    //MARK:- Tabbar delegate method
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        print(self.tabBarController?.selectedIndex ?? "")
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print(self.tabBarController?.selectedIndex ?? "")
        
        let nav:UINavigationController = viewController as! UINavigationController
        
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
    }
    //MARK:- private methods
    
    func createEmptyCart()
    {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        //manager.requestSerializer.setValue("Bearer 8ilvs6ke53k10gqxsyr022ok28umaqxr", forHTTPHeaderField: "Authorization")
        
        manager.post("\(API_URL)/v1/checkout/cart/guest-carts", parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
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
                        let strCartId:String = (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "cart_id") as! String
                        UserDefaults.standard.set(strCartId, forKey: "guest_cart_id")
                        UserDefaults.standard.synchronize()
                        
                        if self.isUserLogout == true
                        {
                            self.isUserLogout = false
                        }
                        else
                        {
                             NotificationCenter.default.post(name: Notification.Name("orderPlaced"), object: nil)
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
            
        }) { (operation: AFHTTPRequestOperation?,
            error) in
            
            print("Error: " + (error?.localizedDescription)!)
        }
        
        
        
    }
    func createEmptyCartForUser(Auth:String,needToPost:Bool)
    {
        
        UserDefaults.standard.setValue(Auth, forKey: "user_authorization")
        UserDefaults.standard.synchronize()
        
        if needToPost == true
        {
            NotificationCenter.default.post(name: Notification.Name("orderPlaced"), object: nil)
        }
        else if self.isFromFavouriteSignIn == true
        {
            self.isFromFavouriteSignIn = false
            
            NotificationCenter.default.post(name: Notification.Name("signInFromFavourite"), object: nil)
        }
        
       /* let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        manager.requestSerializer.setValue("Bearer \(Auth)", forHTTPHeaderField: "Authorization")
        
        manager.post("\(API_URL)/v1/checkout/cart/user", parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //print(jsonResult)
                    
                    let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                    
                    if flag == "1"
                    {
                       // let strCartId:String = (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "cart_id") as! String
                        
                        let strCartId:String = jsonResult.value(forKey: "data") as! String
                        
                        UserDefaults.standard.setValue(Auth, forKey: "user_authorization")
                        UserDefaults.standard.set((strCartId).replacingOccurrences(of: "\"", with: ""), forKey: "user_cart_id")
                        UserDefaults.standard.synchronize()
                        
                        if needToPost == true
                        {
                            NotificationCenter.default.post(name: Notification.Name("orderPlaced"), object: nil)
                        }
                        else if self.isFromFavouriteSignIn == true
                        {
                            self.isFromFavouriteSignIn = false
                            
                            NotificationCenter.default.post(name: Notification.Name("signInFromFavourite"), object: nil)
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
            
        }) { (operation: AFHTTPRequestOperation?,
            error) in
            
            print("Error: " + (error?.localizedDescription)!)
        }*/
  
    }

    
    func loadBannersInAdvance()
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
                
                for i in 0 ..< (jsonResult.value(forKey: "data") as! NSMutableArray).count
                {
                    let img:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                    
                    img.sd_setImage(with: NSURL(string: ((jsonResult.value(forKey: "data") as! NSMutableArray).object(at: i) as! NSMutableDictionary).value(forKey: "img") as! String) as URL!, placeholderImage: nil)
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
    
    func getCategories()
    {
        
 
     
 
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        manager.get("\(API_URL)/v1/catalog", parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print(jsonResult)
                
               let arrTempCat = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "children_data") as! NSMutableArray
                
                for i in 0 ..< arrTempCat.count
                {
                    let dict:NSMutableDictionary = arrTempCat.object(at: i) as! NSMutableDictionary
                    
                    self.dictCategory.setValue(dict.value(forKey: "children_data") as! NSMutableArray, forKey:dict.value(forKey: "name") as! String)
                    
                    self.categoryKeys.add(dict.value(forKey: "name") as! String)
                    self.categoryIds.add((dict.value(forKey: "id") as! NSNumber).stringValue)
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadCategories"), object:nil)
                
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
    func setUpTabbarForArabic()
    {
        self.tabBarController = UITabBarController()
        
        let viewController1:UIViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let viewController2:UIViewController = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
        let viewController3:UIViewController = ShoppingBagViewController(nibName: "ShoppingBagViewController", bundle: nil)
        let viewController4:UIViewController = SearchListViewController(nibName: "SearchListViewController", bundle: nil)
        let viewController5:UIViewController = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
        
        nav1 = UINavigationController(rootViewController: viewController1) as UINavigationController
        nav2 = UINavigationController(rootViewController: viewController2) as UINavigationController
        nav3 = UINavigationController(rootViewController: viewController3) as UINavigationController
        nav4 = UINavigationController(rootViewController: viewController4) as UINavigationController
        nav5 = UINavigationController(rootViewController: viewController5) as UINavigationController
        
        /*** 1 ***/
        var tabImage:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_shape-375"
        }
        else
        {
            tabImage = "ic_shape"
        }
        
        var tabImageSelected:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected = "ic_shape_selected-375"
        }
        else
        {
            tabImageSelected = "ic_shape_selected"
        }
        
        var musicImage:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel:UIImage = UIImage(named: String(format: "%@",tabImageSelected!))!
        
        musicImage = musicImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel = musicImageSel.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav1?.tabBarItem = UITabBarItem (title: "", image: musicImage, selectedImage: musicImageSel)
        
        
        /*** 2 ***/
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_wishlish-375"
        }
        else
        {
            tabImage = "ic_wishlish"
        }
        
        var tabImageSelected1:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected1 = "ic_wishlish_selected-375"
        }
        else
        {
            tabImageSelected1 = "ic_wishlish_selected"
        }
        
        var musicImage1:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel1:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel1:UIImage = UIImage(named: String(format: "%@",tabImageSelected1!))!
        
        musicImage1 = musicImage1.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel1 = musicImageSel1.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav2?.tabBarItem = UITabBarItem (title: "", image: musicImage1, selectedImage: musicImageSel1)
        
        /*** 3 ***/
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_shopping_bag-375"
        }
        else
        {
            tabImage = "ic_shopping_bag"
        }
        
        var tabImageSelected2:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected2 = "ic_shopping_bag_selected-375"
        }
        else
        {
            tabImageSelected2 = "ic_shopping_bag_selected"
        }
        
        var musicImage2:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel2:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel2:UIImage = UIImage(named: String(format: "%@",tabImageSelected2!))!
        
        musicImage2 = musicImage2.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel2 = musicImageSel2.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav3?.tabBarItem = UITabBarItem (title: "", image: musicImage2, selectedImage: musicImageSel2)
        
        /*** 4 ***/
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_search-375"
        }
        else
        {
            tabImage = "ic_search"
        }
        
        var tabImageSelected3:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected3 = "ic_search_selected-375"
        }
        else
        {
            tabImageSelected3 = "ic_search_selected"
        }
        
        var musicImage3:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel3:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel3:UIImage = UIImage(named: String(format: "%@",tabImageSelected3!))!
        
        musicImage3 = musicImage3.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel3 = musicImageSel3.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav4?.tabBarItem = UITabBarItem (title: "", image: musicImage3, selectedImage: musicImageSel3)
        
        /*** 5 ***/
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_user-375"
        }
        else
        {
            tabImage = "ic_user"
        }
        
        var tabImageSelected4:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected4 = "ic_user_selected-375"
        }
        else
        {
            tabImageSelected4 = "ic_user_selected"
        }
        
        var musicImage4:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel4:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel4:UIImage = UIImage(named: String(format: "%@",tabImageSelected4!))!
        
        musicImage4 = musicImage4.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel4 = musicImageSel4.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav5?.tabBarItem = UITabBarItem (title: "", image: musicImage4, selectedImage: musicImageSel4)
        
        nav1?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav2?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav3?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav4?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav5?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        
        let arr:NSArray = NSArray(objects: nav5!,nav4!,nav3!,nav2!,nav1!)
        
        self.tabBarController?.viewControllers = arr as? [UIViewController]
        
        self.tabBarController?.tabBar.backgroundImage = UIImage(named: "bg_tab.png")
        
        print("\(UIScreen.main.bounds.size.height)")
        
        // self.tabBarController?.tabBar.backgroundImage = UIImage(named: "bg_tabbar.png")
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
        var tabFrame = self.tabBarController?.tabBar.frame
        tabFrame?.size.height = 49
        
        if UIApplication.shared.statusBarFrame.height > 20 {
            tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 69
        }
        else
        {
            tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 49
        }
        
        // self.tabBarController?.tabBar.frame = tabFrame? as! CGRect
        let tempFrame:CGRect = tabFrame!
        self.tabBarController?.tabBar.frame = tempFrame
        self.tabBarController?.tabBar.autoresizesSubviews = false
        self.tabBarController?.tabBar.clipsToBounds = true
        self.tabBarController?.delegate = self
    }
    func setUpTabbarForEnglish()
    {
        self.tabBarController = UITabBarController()
        
        let viewController1:UIViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let viewController2:UIViewController = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
        let viewController3:UIViewController = ShoppingBagViewController(nibName: "ShoppingBagViewController", bundle: nil)
        let viewController4:UIViewController = SearchListViewController(nibName: "SearchListViewController", bundle: nil)
        let viewController5:UIViewController = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
        
        nav1 = UINavigationController(rootViewController: viewController1) as UINavigationController
        nav2 = UINavigationController(rootViewController: viewController2) as UINavigationController
        nav3 = UINavigationController(rootViewController: viewController3) as UINavigationController
        nav4 = UINavigationController(rootViewController: viewController4) as UINavigationController
        nav5 = UINavigationController(rootViewController: viewController5) as UINavigationController
        
        /*** 1 ***/
        var tabImage:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_shape-375"
        }
        else
        {
            tabImage = "ic_shape"
        }
        
        var tabImageSelected:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected = "ic_shape_selected-375"
        }
        else
        {
            tabImageSelected = "ic_shape_selected"
        }
        
        var musicImage:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel:UIImage = UIImage(named: String(format: "%@",tabImageSelected!))!
        
        musicImage = musicImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel = musicImageSel.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav1?.tabBarItem = UITabBarItem (title: "", image: musicImage, selectedImage: musicImageSel)
        
        
        /*** 2 ***/
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_wishlish-375"
        }
        else
        {
            tabImage = "ic_wishlish"
        }
        
        var tabImageSelected1:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected1 = "ic_wishlish_selected-375"
        }
        else
        {
            tabImageSelected1 = "ic_wishlish_selected"
        }
        
        var musicImage1:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel1:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel1:UIImage = UIImage(named: String(format: "%@",tabImageSelected1!))!
        
        musicImage1 = musicImage1.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel1 = musicImageSel1.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav2?.tabBarItem = UITabBarItem (title: "", image: musicImage1, selectedImage: musicImageSel1)
        
        /*** 3 ***/
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_shopping_bag-375"
        }
        else
        {
            tabImage = "ic_shopping_bag"
        }
        
        var tabImageSelected2:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected2 = "ic_shopping_bag_selected-375"
        }
        else
        {
            tabImageSelected2 = "ic_shopping_bag_selected"
        }
        
        var musicImage2:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel2:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel2:UIImage = UIImage(named: String(format: "%@",tabImageSelected2!))!
        
        musicImage2 = musicImage2.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel2 = musicImageSel2.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav3?.tabBarItem = UITabBarItem (title: "", image: musicImage2, selectedImage: musicImageSel2)
        
        /*** 4 ***/
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_search-375"
        }
        else
        {
            tabImage = "ic_search"
        }
        
        var tabImageSelected3:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected3 = "ic_search_selected-375"
        }
        else
        {
            tabImageSelected3 = "ic_search_selected"
        }
        
        var musicImage3:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel3:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel3:UIImage = UIImage(named: String(format: "%@",tabImageSelected3!))!
        
        musicImage3 = musicImage3.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel3 = musicImageSel3.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav4?.tabBarItem = UITabBarItem (title: "", image: musicImage3, selectedImage: musicImageSel3)
        
        /*** 5 ***/
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImage = "ic_user-375"
        }
        else
        {
            tabImage = "ic_user"
        }
        
        var tabImageSelected4:String?
        
        if UIScreen.main.bounds.size.height == 667
        {
            tabImageSelected4 = "ic_user_selected-375"
        }
        else
        {
            tabImageSelected4 = "ic_user_selected"
        }
        
        var musicImage4:UIImage = UIImage(named: tabImage!)!
        //var musicImageSel4:UIImage = UIImage(named: String(format: "%@_select",tabImage!))!
        var musicImageSel4:UIImage = UIImage(named: String(format: "%@",tabImageSelected4!))!
        
        musicImage4 = musicImage4.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        musicImageSel4 = musicImageSel4.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        nav5?.tabBarItem = UITabBarItem (title: "", image: musicImage4, selectedImage: musicImageSel4)
        
        nav1?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav2?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav3?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav4?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        nav5?.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        
        let arr:NSArray = NSArray(objects: nav1!,nav2!,nav3!,nav4!,nav5!)
        
        self.tabBarController?.viewControllers = arr as? [UIViewController]
        
        self.tabBarController?.tabBar.backgroundImage = UIImage(named: "bg_tab.png")
        
        print("\(UIScreen.main.bounds.size.height)")
        
        // self.tabBarController?.tabBar.backgroundImage = UIImage(named: "bg_tabbar.png")
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
        var tabFrame = self.tabBarController?.tabBar.frame
        tabFrame?.size.height = 49
        
        if UIApplication.shared.statusBarFrame.height > 20 {
             tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 69
        }
        else
        {
             tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 49
        }
        
       
        // self.tabBarController?.tabBar.frame = tabFrame? as! CGRect
        let tempFrame:CGRect = tabFrame!
        self.tabBarController?.tabBar.frame = tempFrame
        self.tabBarController?.tabBar.autoresizesSubviews = false
        self.tabBarController?.tabBar.clipsToBounds = true
        self.tabBarController?.delegate = self
    }

    func setFont(_ fontSize:CGFloat) -> CGFloat
    {
        print("\((fontSize*UIScreen.main.bounds.size.width)/320)")
        
        if UIScreen.main.bounds.size.width > 500
        {
             return (fontSize*UIScreen.main.bounds.size.width)/768
        }
        else
        {
             return (fontSize*UIScreen.main.bounds.size.width)/320
        }
        
       
    }

    func showAlert(title:String)
    {
        let alert:UIAlertView = UIAlertView(title: self.mapping?.string(forKey: "Shy7lo"), message: title, delegate: self, cancelButtonTitle: self.mapping?.string(forKey: "OK"))
        alert.show()
        
    }
    
    private func connection(_ connection: NSURLConnection, didReceive data: Data)
    {
        self.dataVal.append(data as Data)
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection)
    {
        var error: NSErrorPointer=nil
        
        var jsonResult = NSDictionary()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: dataVal as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            // use jsonData
        } catch {
            // report error
        }
        
        print(jsonResult)
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        
        print(oldStatusBarFrame)
        
        if self.tabBarController != nil
        {
            var tabFrame = self.tabBarController?.tabBar.frame
            tabFrame?.size.height = 49
            
            if UIApplication.shared.statusBarFrame.height > 20 {
                tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 69
            }
            else
            {
                tabFrame?.origin.y =  UIScreen.main.bounds.size.height - 49
            }
            
            
            // self.tabBarController?.tabBar.frame = tabFrame? as! CGRect
            let tempFrame:CGRect = tabFrame!
            self.tabBarController?.tabBar.frame = tempFrame
            self.tabBarController?.tabBar.autoresizesSubviews = false
            self.tabBarController?.tabBar.clipsToBounds = true
            self.tabBarController?.delegate = self
        }
        
       

    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        self.getCategories()
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

