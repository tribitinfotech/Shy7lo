//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class GuestLoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblNotaMember: UILabel!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnStaticContinueAsGuest: UIButton!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var lblStaticOR: UILabel!
    @IBOutlet weak var btnStaticSignIn: UIButton!
    @IBOutlet weak var lblLoginToShyAccount: UILabel!
    @IBOutlet weak var txtGuestMail: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnFP: UIButton!
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAnalytics.logEvent(withName: "Checkout_login_guest", parameters: ["name":"Checkout_login_guest"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDel.isLanguageChanged = false
        
        if isEnglish {
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            
            self.lblNotaMember.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.txtGuestMail.font = UIFont(name: appDel.strFont, size: 17.0)
            
            self.txtEmail.font = UIFont(name: appDel.strFont, size: 17.0)
            
            self.txtPassword.font = UIFont(name: appDel.strFont, size: 17.0)
            
            self.btnStaticContinueAsGuest.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 15.0)
            
            self.lblStaticOR.font = UIFont(name: appDel.strFont, size: 11.0)
            
            self.lblLoginToShyAccount.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.btnStaticSignIn.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 15.0)
            
            self.btnFP.titleLabel?.font = UIFont(name: appDel.strFont, size: 10.0)
            
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
            self.lblNotaMember.textAlignment = .left
            self.txtGuestMail.textAlignment = .left
            self.lblLoginToShyAccount.textAlignment = .left
            self.txtEmail.textAlignment = .left
            self.txtPassword.textAlignment = .left
            
            
        }
        else
        {
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            
            self.lblNotaMember.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.txtGuestMail.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            
            self.txtEmail.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            
            self.txtPassword.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            
            self.btnStaticContinueAsGuest.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 15.0)
            
            self.lblStaticOR.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            
            self.lblLoginToShyAccount.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.btnStaticSignIn.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 15.0)
            
            self.btnFP.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 10.0)
            
            self.lblNotaMember.textAlignment = .right
            self.txtGuestMail.textAlignment = .right
            self.lblLoginToShyAccount.textAlignment = .right
            self.txtEmail.textAlignment = .right
            self.txtPassword.textAlignment = .right
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        }
        
        self.lblNotaMember.text = appDel.mapping?.string(forKey: "Not a member")
        self.txtGuestMail.placeholder = appDel.mapping?.string(forKey: "Email address")
        self.btnStaticContinueAsGuest.setTitle(appDel.mapping?.string(forKey: "Continue as guest"), for: UIControlState.normal)
        self.lblStaticOR.text = appDel.mapping?.string(forKey: "OR")
        self.lblLoginToShyAccount.text = appDel.mapping?.string(forKey: "Login to your shy7lo account")
        
        self.txtEmail.placeholder = appDel.mapping?.string(forKey: "Email address")
        self.txtPassword.placeholder = appDel.mapping?.string(forKey: "Password")
        
        self.btnStaticSignIn.setTitle(appDel.mapping?.string(forKey: "Sign In"), for: UIControlState.normal)
        
        self.btnFP.setTitle(appDel.mapping?.string(forKey: "Forgot password ?"), for: UIControlState.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.customizeTextfield(self.txtGuestMail)
        self.customizeTextfield(self.txtEmail)
        self.customizeTextfield(self.txtPassword)
       
        
        // Do any additional setup after loading the view.
    }

    //MARK:- Action zones
    
    @IBAction func btnFPAction(_ sender: AnyObject)
    {
        
    }
    @IBAction func btnSignInAction(_ sender: AnyObject)
    {
        if self.txtEmail.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter email"))!)
            return
        }
        if self.txtPassword.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter password"))!)
            return
        }
        if self.isValidEmailAddress(emailAddressString: self.txtEmail.text!) == false {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter valid email address"))!)
            return
        }
        
        self.HUD?.show(true)
      
        let str:String = String(format:"\(API_URL)/v1/customer/login")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(self.txtEmail.text, forKey: "email")
        parameter.setValue(self.txtPassword.text, forKey: "password")
        parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
        
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
                // use jsonData
            } catch {
                // report error
            }
            
            
            
            UserDefaults.standard.setValue(self.txtEmail.text, forKey: "userEmail")
            
            UserDefaults.standard.synchronize()
            print(jsonResult)
            
            DispatchQueue.main.async()
                {
                    
                self.HUD?.hide(true)
                    
                  if let dict = jsonResult.value(forKey: "data") as? NSDictionary
                  {
                    if jsonResult.value(forKey: "success") as! Int == 1
                    {
                        
                        self.appDel.createEmptyCartForUser(Auth:  (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "token") as! String, needToPost: false)
                        
                        UserDefaults.standard.setValue(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "id"), forKey: "userDetail")
                        
                         UserDefaults.standard.setValue("\(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "firstname")!) \(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "lastname")!)", forKey: "userName")
                        
                         UserDefaults.standard.set(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "cart_count"), forKey: "badge")
                        
                        if UserDefaults.standard.integer(forKey: "badge") != 0
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                        }
                        else
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                        }
                        
                        self.repositionBadge(tabIndex: 3)
                        
                        UserDefaults.standard.synchronize()
                        
                        if isEnglish {
                            
                            let check:CheckOutViewController = CheckOutViewController(nibName: "CheckOutViewController", bundle: nil)
                            check.isComingFromGuest = true
                            self.navigationController?.pushViewController(check, animated: true)
                        }
                        else
                        {
                            let check:CheckOutViewController = CheckOutViewController(nibName: "CheckOutViewController", bundle: nil)
                            check.isComingFromGuest = true
                            let transition = CATransition()
                            transition.duration = 0.45
                            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                            transition.type = kCATransitionPush
                            transition.subtype = kCATransitionFromLeft
                            self.navigationController?.view?.layer.add(transition, forKey: nil)
                            self.navigationController?.pushViewController(check, animated: false)
                            
                        }
                    }
                    else
                    {
                        self.appDel.showAlert(title: (jsonResult.value(forKey: "message") as! String))
                    }

                  }
                    else
                  {
                      self.appDel.showAlert(title: (jsonResult.value(forKey: "message") as! String))
                    }
                    
            }

        }
        task.resume()
        
    }
    @IBAction func btnBackAction(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnContinueAsGuestAction(_ sender: AnyObject)
    {
        if self.txtGuestMail.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter email"))!)
            return
        }
        if self.isValidEmailAddress(emailAddressString: self.txtGuestMail.text!) == false {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter valid email address"))!)
            return
        }
        
        UserDefaults.standard.setValue(self.txtGuestMail.text?.replacingOccurrences(of: " ", with: ""), forKey: "userEmail")
        UserDefaults.standard.synchronize()
        
        if isEnglish {
            
            let check:CheckOutViewController = CheckOutViewController(nibName: "CheckOutViewController", bundle: nil)
            check.isComingFromGuest = true
            self.navigationController?.pushViewController(check, animated: true)
        }
        else
        {
            let check:CheckOutViewController = CheckOutViewController(nibName: "CheckOutViewController", bundle: nil)
            check.isComingFromGuest = true
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            navigationController?.view?.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(check, animated: false)
            
        }
    }
    
    //MARK:- Textfield method
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
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
    func isValidEmailAddress(emailAddressString: String) -> Bool
    {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    func customizeTextfield( _ textfield:UITextField)
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
    func convertToDictionary(text: String) -> NSMutableDictionary {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSMutableDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return NSMutableDictionary()
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
