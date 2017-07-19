//
//  BasicStuff.swift
//  eventN3
//
//  Created by haresh on 28/09/16.
//  Copyright © 2016 haresh. All rights reserved.
//

import UIKit

let Default = UserDefaults.standard
let MainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let PopupStoryBoard = UIStoryboard(name: "popup", bundle: Bundle.main)

class BasicStuff: NSObject {
    static let basic = BasicStuff()
    
    var isNetworkRechable:Bool = false
    
    
    private var rechability:Reachability?
    
    override init() {
        super.init()
        rechability = Reachability()
        isNetworkRechable = (rechability?.isReachable)!
        rechability?.whenReachable = { reachability in
            self.isNetworkRechable = true
        }
        rechability?.whenUnreachable = { reachability in
            self.isNetworkRechable = false
        }
        
        /*if (rechability?.isReachableViaWiFi)! {
          //  let frame:CGRect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
           // var statusBarFrame: CGRect = UIApplication.shared.statusBarFrame
            //UIApplication.shared.isStatusBarHidden = true
            UIApplication.shared.isStatusBarHidden = false

        }
        else{
            UIApplication.shared.isStatusBarHidden = false

        }*/
    }
    func restartAnimation()
    {
        let loaderView: UIView = AppDelegate.shared.window!.viewWithTag(2222)!
        
        if loaderView.isHidden == false
        {
            var imgLoader: UIImageView = UIImageView()
            
            for subview in loaderView.subviews {
                
                if subview.isKind(of: UIImageView.self)
                {
                    let img:UIImageView = subview as! UIImageView
                    
                    if img.tag == 1111 {
                        imgLoader = img as UIImageView
                    }
                }
            }
            
            imgLoader.layer.removeAnimation(forKey: "Spin")
            let fullRotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
            fullRotation.fromValue = Int(0)
            fullRotation.toValue = Int((((360 * M_PI) / 180)))
            fullRotation.duration = 0.6
            fullRotation.repeatCount = 10000
            imgLoader.layer.add(fullRotation, forKey: "Spin")
        }
    }
    func addHUD()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.restartAnimation), name: NSNotification.Name(rawValue: "restartAnimation"), object: nil)
        
        if AppDelegate.shared.window!.viewWithTag(2222) == nil
        {
            var loaderView: UIView = UIView()
            loaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            loaderView.backgroundColor = UIColor.clear
            let lblOverLay: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: loaderView.frame.size.width, height: loaderView.frame.size.height))
            lblOverLay.backgroundColor = UIColor.black
            lblOverLay.alpha = 0.3
            loaderView.addSubview(lblOverLay)
            let img: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
            img.image = UIImage(named: "bg_preloader.png")
            loaderView.addSubview(img)
            img.tag = 1111
            img.center = loaderView.center
            loaderView.tag = 2222
            AppDelegate.shared.window!.addSubview(loaderView)
            loaderView.isHidden = true
        }
    }
    
    class func ShowAlert(title:String,message:String) {
        
        
       /* if isEnglish{
            let attributedStrTitle = NSMutableAttributedString(string: "Masakin")
            let myAttributeTitle = [ NSFontAttributeName: UIFont(name: "Myriad Pro", size:  18.0)! ]
            attributedStrTitle.addAttributes(myAttributeTitle, range: NSRange(location: 0, length: 6))
            
            let strOK:String = "OK"
            let attributedStrTOK = NSMutableAttributedString(string: "OK")
            let myAttributeOK = [ NSFontAttributeName: UIFont(name: "Myriad Pro", size:  18.0)! ]
            attributedStrTOK.addAttributes(myAttributeOK, range: NSRange(location: 0, length: strOK.characters.count))
            
            
            let alert:UIAlertView = UIAlertView(title: attributedStrTitle.string, message: "", delegate: nil, cancelButtonTitle: attributedStrTOK.string)
            let lbl = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(200)))
            let attributedStr = NSMutableAttributedString(string: message)
            let myAttribute = [ NSFontAttributeName: UIFont(name: "Myriad Pro", size: 18.0)! ]
            attributedStr.addAttributes(myAttribute, range: NSRange(location: 0, length: message.characters.count))
            lbl.attributedText = attributedStr
            lbl.textAlignment = .center
            alert .setValue(lbl, forKey: "accessoryView")
            alert.show()
            
            
        }
        else{
            let attributedStrTitle = NSMutableAttributedString(string: "مسـاكـن")
            let myAttributeTitle = [ NSFontAttributeName: UIFont(name: "CoconNextArabic-Regular", size: 18.0)! ]
            attributedStrTitle.addAttributes(myAttributeTitle, range: NSRange(location: 0, length: 5))
            
            let alert:UIAlertView = UIAlertView(title: attributedStrTitle.string, message: "", delegate: nil, cancelButtonTitle: LocalizedString(key:"OK"))
            let lbl = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(200)))
            let attributedStr = NSMutableAttributedString(string: message)
            let myAttribute = [ NSFontAttributeName: UIFont(name: "CoconNextArabic-Regular", size: 18.0)! ]
            attributedStr.addAttributes(myAttribute, range: NSRange(location: 0, length: message.characters.count))
            lbl.attributedText = attributedStr
            lbl.textAlignment = .center
            alert .setValue(lbl, forKey: "accessoryView")
            alert.show()
        }*/
        
        

        UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: LocalizedString(key:"OK")).show()
    }

    func stopNotifier() {
        isNetworkRechable = false
        rechability = nil
    }
    func getCountryCode() {
       /* let sendDict = NSMutableDictionary()
        sendDict.setValue(SelectedLang, forKey: "lang")
        SVProgressHUD.show()
        let manager  = ServiceCall(URL: API_Country_Code)
        manager.setAuthorization(username: AuthUserName, password: AuthPassword)
        manager.setContentType(contentType: .MultiPartForm)
        manager.POST(parameters:sendDict) { (success:Bool, obj:Any) in
            
            SVProgressHUD.dismiss()
            
            if success {
                
                let responceDict = obj as! NSDictionary
                
                if responceDict.value(forKey: "flag") as! NSNumber  == 1 {
                    
                    let countryCodelist = responceDict.value(forKey: "data") as! NSArray
                    for item in countryCodelist {
                        countryCodeListArray.add(item)
                    }
                }
                    
                else {
                    BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: responceDict.value(forKey: "msg") as! String)
                }
            }
            else {
                BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: (obj as! String))
            }
        }*/
    }
    
    
    func getMainCityList() {
        /*let sendDict = NSMutableDictionary()
        sendDict.setValue(SelectedLang, forKey: "lang")
        SVProgressHUD.show()
        let manager  = ServiceCall(URL: API_Main_CityList)
        manager.setAuthorization(username: AuthUserName, password: AuthPassword)
        manager.setContentType(contentType: .MultiPartForm)
        manager.POST(parameters:sendDict) { (success:Bool, obj:Any) in
            
            SVProgressHUD.dismiss()
            
            if success {
                
                let responceDict = obj as! NSDictionary
                
                if responceDict.value(forKey: "flag") as! NSNumber  == 1 {
                    
                    let citylist = responceDict.value(forKey: "data") as! NSArray
                    for city in citylist {
                        mainCityListArray.add(city)
                    }
                }
                    
                else {
                    BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: responceDict.value(forKey: "msg") as! String)
                }
            }
            else {
                BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: (obj as! String))
            }
        }*/
    }

    func getCityList() {
       /* let sendDict = NSMutableDictionary()
        sendDict.setValue(SelectedLang, forKey: "lang")
        SVProgressHUD.show()
        let manager  = ServiceCall(URL: API_CityList)
        manager.setAuthorization(username: AuthUserName, password: AuthPassword)
        manager.setContentType(contentType: .MultiPartForm)
        manager.POST(parameters:sendDict) { (success:Bool, obj:Any) in
            
            SVProgressHUD.dismiss()
            
            if success {
                
                let responceDict = obj as! NSDictionary
                
                if responceDict.value(forKey: "flag") as! NSNumber  == 1 {
                    
                    let citylist = responceDict.value(forKey: "data") as! NSArray
                    for city in citylist {
                        cityListArray.add(city)
                    }
                }
                    
                else {
                    BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: responceDict.value(forKey: "msg") as! String)
                }
            }
            else {
                BasicStuff.ShowAlert(title: LocalizedString(key: "Masakin"), message: (obj as! String))
            }
        }*/
    }
    
    deinit {
        stopNotifier()
    }
    
}

class UserData: NSObject,NSCoding {
    var accessToken:String
    var userType:String
    //User
    var countryCode:String
    var email:String
    var mobileNumber:String
    var userID:String
    var userName:String
    //Agent
    var agentID:String
    var agentEmail:String
    var agentName:String
    
    init(userType:Bool,saveDict:NSDictionary) {
        
        // userType == 0 - user ...... userType == 1 - agent
        
        let accessToken = saveDict.value(forKey: "access_token")
        let countryCode = saveDict.value(forKey: "country_code")
        let email = saveDict.value(forKey: "email")
        let mobileNumber = saveDict.value(forKey: "mobile_number")
        let userID = saveDict.value(forKey: "user_id")
        let userName = saveDict.value(forKey: "username")
        let agentID = saveDict.value(forKey: "agent_id")
        let agentEmail = saveDict.value(forKey: "agent_email")
        let agentName = saveDict.value(forKey: "agent_name")
        
        self.userType = userType ? "1" : "0"
        self.accessToken = accessToken != nil ? accessToken as! String : ""
        self.countryCode = countryCode != nil ? countryCode as! String : ""
        self.email = email != nil ? email as! String : ""
        self.mobileNumber = mobileNumber != nil ? mobileNumber as! String : ""
        self.userID = userID != nil ? userID as! String : ""
        self.userName = userName != nil ? userName as! String : ""
        self.agentID = agentID != nil ? agentID as! String : ""
        self.agentEmail = agentEmail != nil ? agentEmail as! String : ""
        self.agentName = agentName != nil ? agentName as! String : ""
    }
    

    public convenience required init?(coder aDecoder: NSCoder) {
        
        let accessToken = aDecoder.decodeObject(forKey: "accessToken") as! String
        let countryCode = aDecoder.decodeObject(forKey: "countryCode") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as! String
        let userID = aDecoder.decodeObject(forKey: "user_id") as! String
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        let agentID = aDecoder.decodeObject(forKey: "agent_id") as! String
        let agentemail = aDecoder.decodeObject(forKey: "agent_email") as! String
        let agentName = aDecoder.decodeObject(forKey: "agent_name") as! String
        
        let userType = aDecoder.decodeObject(forKey: "userType") as! String
        
        let dict  = ["access_token":accessToken,
                     "country_code":countryCode,
                     "email":email,
                     "mobile_number":mobileNumber,
                     "user_id":userID,
                     "username":userName,
                     "agent_id":agentID,
                     "agent_email":agentemail,
                     "agent_name":agentName]

        self.init(userType:userType  == "1" ? true : false,saveDict:dict as NSDictionary)
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.accessToken, forKey: "accessToken")
        aCoder.encode(self.countryCode, forKey: "countryCode")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.mobileNumber, forKey: "mobileNumber")
        aCoder.encode(self.userID, forKey: "user_id")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.agentID, forKey: "agent_id")
        aCoder.encode(self.agentEmail, forKey: "agent_email")
        aCoder.encode(self.agentName, forKey: "agent_name")
        aCoder.encode(self.userType, forKey: "userType")
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        Default.set(data, forKey: "SaveData")
        Default.synchronize()
    }
    class func loadData() -> UserData? {
        
        if userData != nil {
            return userData
        }
        else if Default.value(forKey:"SaveData") != nil {
            let data:Data = Default.value(forKey:"SaveData") as! Data
            let saveData:UserData = NSKeyedUnarchiver.unarchiveObject(with: data) as! UserData
            return saveData
        }
        else {
            return nil
        }
    }
    class func removeUserData() {
        userData = nil
        Default.removeObject(forKey: "SaveData")
        Default.synchronize()
    }
    class func save(userType:Bool,data:NSDictionary) {
        
        userData = UserData(userType: userType, saveDict: data)
            
            /*UserData(userID: userID != nil ? userID as! String : "",
                            userName: data.value(forKey: "username") as! String,
                            accesToken: data.value(forKey: "access_token") as! String,
                            email: email != nil ? email as! String : "",
                            mobileNumber: data.value(forKey: "mobile_number") as! String,
                            countryCode: data.value(forKey: "country_code") as! String)*/

        userData.save()
    }
}

//MARK:- extern inline functions
func getDefaultDeviceToken() -> String {
    if Default.value(forKey: Key_DeviceToken) != nil {
        return Default.value(forKey: Key_DeviceToken) as! String
    }
    else {
     return "Not Found"
    }
    
}
func LocalizedString(key:String) -> String
{
    let language:String!
    
    if isEnglish
    {
        language = "Base"
    }
    else
    {
        language = "ar"
    }
    let path = Bundle.main.path(forResource: language, ofType: "lproj")
    let bundle = Bundle(path: path!)
    
    return (bundle?.localizedString(forKey: key, value: "", table: nil))!
}
func setLanguage(lang : Language)
{
    switch lang
    {
    case .English:
        isEnglish = true
        SelectedLang = "0"
        Default.set(English, forKey: LANG_KEY)
        break
    case .Arabic:
        isEnglish = false
        SelectedLang = "1"
        Default.set(Arabic, forKey: LANG_KEY)
        break
    case .Default:
        if Default.value(forKey: LANG_KEY) == nil
        {
            isEnglish = true
            SelectedLang = "0"
            Default.set(English, forKey: LANG_KEY)
        }
        else if Default.string(forKey: LANG_KEY) == "en"
        {
            isEnglish = true
            SelectedLang = "0"
            Default.set(English, forKey: LANG_KEY)
        }
        else
        {
            isEnglish = false
            SelectedLang = "1"
            Default.set(Arabic, forKey: LANG_KEY)
        }
        break
    }
    
    Default.synchronize()
}

//MARK:- Extension

extension UIColor {
    
    convenience init(hexString:String)
    {
        let hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
}
extension UIView {
    func makeCornerRadius(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    func makeBoarder(color: UIColor , width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}
extension UITextField {
    /*func setCityDropDown() {
        let cityArray = NSMutableArray()
   
        for item in cityListArray {
            let dict = item as! NSDictionary
            
            if isEnglish {
                cityArray.add(dict.value(forKey: "city_name") as! String)
            }
            else {
                cityArray.add(dict.value(forKey: "city_ar_name") as! String)
            }
        }
        
    
       // self.setDropDown(delegate: nil, array: cityArray)
    }
    func setAreaDropDown() {
        let areaArray = NSMutableArray()
        for item in areaListArray {
            let dict = item as! NSDictionary
            
            if isEnglish {
                areaArray.add(dict.value(forKey: "area_name") as! String)
            }
            else {
                areaArray.add(dict.value(forKey: "area_ar_name") as! String)
            }
        }
        //self.setDropDown(delegate: nil, array: areaArray)
    }
   
    func setDistrictDropDown() {
        let districtArray = NSMutableArray()
        for item in districtListArray {
            let dict = item as! NSDictionary
            
            if isEnglish {
                districtArray.add(dict.value(forKey: "area_name") as! String)
            }
            else {
                districtArray.add(dict.value(forKey: "area_ar_name") as! String)
            }
        }
        //self.setDropDown(delegate: nil, array: districtArray)
    }*/
    }


