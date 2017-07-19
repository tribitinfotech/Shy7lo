//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class SignUpViewController: UIViewController,UITextFieldDelegate,TTTAttributedLabelDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    var isSomethingWrong:Bool = false
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selectedIndex:NSInteger?
    
    var objProfile:UserProfileViewController?
    
    var objFavourite:FavouriteViewController?
    
    var isFromFavourite:Bool?
    
    @IBOutlet weak var btnSIgnUp: UIButton!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var lblOr: UILabel!
    
    //SIgn Up
    
    
    @IBOutlet weak var viewMainSignUp: UIView!
    
    @IBOutlet weak var viewSignUp: UIView!
    
    @IBOutlet weak var lblStaticFirstName: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblTermsPolicy: TTTAttributedLabel!
    
    @IBOutlet weak var btnSubscribeCheckbox: UIButton!
    @IBOutlet weak var viewSubscribe: UIView!
    
    @IBOutlet weak var lblStaticSubscribe: UILabel!
    
    @IBOutlet weak var lblStaticName: UILabel!
    
    @IBOutlet weak var blStaticEmail: UILabel!
    
    @IBOutlet weak var lblStaticPassword: UILabel!
    
    @IBOutlet weak var lblStaticGender: UILabel!
    
    @IBOutlet weak var lblStaticTelephone: UILabel!
    
    @IBOutlet weak var txtSignUpName: UITextField!
    
    @IBOutlet weak var txtSignUpEmail: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtSignUpPassword: UITextField!
    
    @IBOutlet weak var txtSignUpGender: UITextField!
    
    @IBOutlet weak var txtSignUpTelephone: UITextField!
    
    //Sign In
    @IBOutlet weak var viewInnerSignIn: UIView!
    
    @IBOutlet weak var viewMainSignIn: UIView!
    
    
    @IBOutlet weak var txtLoginEmail: UITextField!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtLoginPassword: UITextField!
    
    @IBOutlet weak var btnPickerDone: UIButton!
    @IBOutlet weak var btnPickerCancel: UIButton!
    
    @IBOutlet weak var viewPickerTop: UIView!
    @IBOutlet weak var viewPickerBg: UIView!
    @IBOutlet weak var normalPicker: UIPickerView!
    
    var arrGender:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var imgLoader: UIImageView!
    @IBOutlet weak var viewPickerBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewLoader: UIView!
    
    override func viewWillDisappear(_ animated: Bool) {
        
        appDel.isLoginSignUpPresent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDel.isLoginSignUpPresent = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.dismissCon),
            name: NSNotification.Name(rawValue: "dismissSignUp"),
            object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(signInFromFavourite), name: Notification.Name("signInFromFavourite"), object: nil)
        
        self.arrGender.add(appDel.mapping?.string(forKey: "Male") ?? "")
        self.arrGender.add(appDel.mapping?.string(forKey: "Female") ?? "")
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.btnSignIn.backgroundColor = .clear
        self.btnSignIn.layer.cornerRadius = 0
        self.btnSignIn.layer.borderWidth = 1
        self.btnSignIn.layer.borderColor = UIColor.black.cgColor
        
        self.btnSIgnUp.backgroundColor = .clear
        self.btnSIgnUp.layer.cornerRadius = 0
        self.btnSIgnUp.layer.borderWidth = 1
        self.btnSIgnUp.layer.borderColor = UIColor.black.cgColor
        
        self.btnLogin.backgroundColor = .clear
        self.btnLogin.layer.cornerRadius = 0
        self.btnLogin.layer.borderWidth = 1
        self.btnLogin.layer.borderColor = UIColor.black.cgColor

        self.viewSignUp.backgroundColor = .clear
        self.viewSignUp.layer.cornerRadius = 0
        self.viewSignUp.layer.borderWidth = 1
        self.viewSignUp.layer.borderColor = UIColor.lightGray.cgColor
        
        self.viewInnerSignIn.backgroundColor = .clear
        self.viewInnerSignIn.layer.cornerRadius = 0
        self.viewInnerSignIn.layer.borderWidth = 1
        self.viewInnerSignIn.layer.borderColor = UIColor.lightGray.cgColor
        
        if isEnglish {
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity
            
            self.btnSignIn.titleLabel?.font = UIFont(name: appDel.strFont, size: 16.0)!
            self.btnSIgnUp.titleLabel?.font = UIFont(name: appDel.strFont, size: 16.0)!
            
            self.lblOr.font = UIFont(name: appDel.strFont, size: 11.0)
            self.lblTermsPolicy.font = UIFont(name: appDel.strFont, size: 13.0)
            
            self.viewSubscribe.transform = CGAffineTransform.identity
            self.btnSubscribeCheckbox.transform = CGAffineTransform.identity
            self.lblStaticSubscribe.transform = CGAffineTransform.identity
            
            self.lblStaticSubscribe.textAlignment = .left
            self.lblStaticSubscribe.font = UIFont(name: appDel.strFont, size: 13.0)
            
            self.btnRegister.titleLabel?.font = UIFont(name: appDel.strFont, size: 16.0)!
            
            self.viewSignUp.transform = CGAffineTransform.identity
            
            self.lblStaticName.transform = CGAffineTransform.identity
            self.blStaticEmail.transform = CGAffineTransform.identity
            self.lblStaticPassword.transform = CGAffineTransform.identity
            self.lblStaticGender.transform = CGAffineTransform.identity
            self.lblStaticTelephone.transform = CGAffineTransform.identity
            self.lblStaticFirstName.transform = CGAffineTransform.identity
            
            self.txtSignUpName.transform = CGAffineTransform.identity
            self.txtSignUpEmail.transform = CGAffineTransform.identity
            self.txtSignUpPassword.transform = CGAffineTransform.identity
            self.txtSignUpGender.transform = CGAffineTransform.identity
            self.txtSignUpTelephone.transform = CGAffineTransform.identity
            self.txtFirstName.transform = CGAffineTransform.identity
        
            self.lblStaticName.font = UIFont(name: appDel.strFont, size: 16.0)
            self.blStaticEmail.font = UIFont(name: appDel.strFont, size: 16.0)
            self.lblStaticPassword.font = UIFont(name: appDel.strFont, size: 16.0)
            self.lblStaticGender.font = UIFont(name: appDel.strFont, size: 16.0)
            self.lblStaticTelephone.font = UIFont(name: appDel.strFont, size: 16.0)
            self.lblStaticFirstName.font = UIFont(name: appDel.strFont, size: 16.0)
            
            self.txtSignUpName.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtSignUpEmail.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtSignUpPassword.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtSignUpGender.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtSignUpTelephone.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtFirstName.font = UIFont(name: appDel.strFont, size: 16.0)
            
            self.lblStaticName.textAlignment = .left
            self.blStaticEmail.textAlignment = .left
            self.lblStaticPassword.textAlignment = .left
            self.lblStaticGender.textAlignment = .left
            self.lblStaticTelephone.textAlignment = .left
            self.lblStaticFirstName.textAlignment = .left
            
            self.txtSignUpName.textAlignment = .left
            self.txtSignUpEmail.textAlignment = .left
            self.txtSignUpPassword.textAlignment = .left
            self.txtSignUpGender.textAlignment = .left
            self.txtSignUpTelephone.textAlignment = .left
            self.txtFirstName.textAlignment = .left
            
            self.txtLoginEmail.textAlignment = .left
            self.txtLoginPassword.textAlignment = .left
            
            self.txtLoginEmail.font = UIFont(name: appDel.strFont, size: 16.0)
            self.txtLoginPassword.font = UIFont(name: appDel.strFont, size: 16.0)

            self.btnLogin.titleLabel?.font = UIFont(name: appDel.strFont, size: 16.0)!
            self.btnForgotPassword.titleLabel?.font = UIFont(name: appDel.strFont, size: 11.0)!
            
            self.viewPickerTop.transform = CGAffineTransform.identity
            self.btnPickerDone.transform = CGAffineTransform.identity
            self.btnPickerCancel.transform = CGAffineTransform.identity
            
            self.btnPickerDone.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
            self.btnPickerCancel.titleLabel?.font = UIFont(name: appDel.strFont, size: 15.0)!
 
        }
        else
        {
            
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnSignIn.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 16.0)!
            self.btnSIgnUp.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 16.0)!
            
            self.btnRegister.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 16.0)!
            
            self.lblOr.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            self.lblTermsPolicy.font = UIFont(name: appDel.strFontKufi, size: 13.0)
            
            self.viewSubscribe.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnSubscribeCheckbox.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticSubscribe.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticSubscribe.textAlignment = .right
            self.lblStaticSubscribe.font = UIFont(name: appDel.strFontKufi, size: 10.0)
            
            self.viewSignUp.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.blStaticEmail.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticPassword.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticGender.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticTelephone.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticFirstName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.txtSignUpName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtSignUpEmail.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtSignUpPassword.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtSignUpGender.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtSignUpTelephone.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtFirstName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.blStaticEmail.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            self.lblStaticPassword.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.lblStaticGender.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.lblStaticTelephone.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.lblStaticFirstName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.txtSignUpName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtSignUpEmail.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtSignUpPassword.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtSignUpGender.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtSignUpTelephone.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtFirstName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.lblStaticName.textAlignment = .right
            self.blStaticEmail.textAlignment = .right
            self.lblStaticPassword.textAlignment = .right
            self.lblStaticGender.textAlignment = .right
            self.lblStaticTelephone.textAlignment = .right
            self.lblStaticFirstName.textAlignment = .right
            
            self.txtSignUpName.textAlignment = .right
            self.txtSignUpEmail.textAlignment = .right
            self.txtSignUpPassword.textAlignment = .right
            self.txtSignUpGender.textAlignment = .right
            self.txtSignUpTelephone.textAlignment = .right
            self.txtFirstName.textAlignment = .right
            
            self.txtLoginEmail.textAlignment = .right
            self.txtLoginPassword.textAlignment = .right
            
            self.txtLoginEmail.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            self.txtLoginPassword.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.btnLogin.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 16.0)!
            self.btnForgotPassword.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 11.0)!
            
            self.viewPickerTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnPickerDone.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnPickerCancel.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnPickerDone.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 14.0)!
            self.btnPickerCancel.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 14.0)!
            
        }
        
        
        self.lblOr.text = appDel.mapping?.string(forKey: "OR")
        
        self.btnSignIn.setTitle(appDel.mapping?.string(forKey: "Sign In"), for: UIControlState.normal)
        self.btnSIgnUp.setTitle(appDel.mapping?.string(forKey: "Sign Up"), for: UIControlState.normal)
        
        self.btnRegister.setTitle(appDel.mapping?.string(forKey: "Register"), for: UIControlState.normal)
        
        self.setupView(index: self.selectedIndex!)
        
        let detailString = String(format:"%@",(appDel.mapping?.string(forKey: "By joining you agree with our Terms and Privacy Policy"))!)
        let st = detailString as NSString
        
        self.lblTermsPolicy.text = st as String
        
        
        let strTerms:String = (appDel.mapping?.string(forKey: "Terms"))!
        let strPolicy:String = (appDel.mapping?.string(forKey: "Privacy Policy"))!
        
        let rangeArtistName = st.range(of: strTerms)
        let rangeOfVenue = st.range(of: strPolicy)
        
        let strArtist:NSString = NSString(format:"T")
        let strVenue:NSString = NSString(format:"P")
        
        self.lblTermsPolicy.numberOfLines = 0
        self.lblTermsPolicy.lineBreakMode = .byWordWrapping
        self.lblTermsPolicy.delegate = self
        
        self.lblTermsPolicy.addLink(toPhoneNumber:strArtist as String!, with: rangeArtistName)
        self.lblTermsPolicy.addLink(toPhoneNumber: strVenue as String!, with: rangeOfVenue)
        
        self.lblStaticSubscribe.text = appDel.mapping?.string(forKey: "Subscribe to the newsletter and get the latest fashion updates!")

        
        self.lblStaticName.text = appDel.mapping?.string(forKey: "First Name")
        self.lblStaticFirstName.text = appDel.mapping?.string(forKey: "Last Name")
        
        self.blStaticEmail.text = appDel.mapping?.string(forKey: "Email")
        self.lblStaticPassword.text = appDel.mapping?.string(forKey: "Password")
        self.lblStaticGender.text = appDel.mapping?.string(forKey: "Gender")
        self.lblStaticTelephone.text = appDel.mapping?.string(forKey: "Telephone")
        
        self.txtSignUpName.placeholder = appDel.mapping?.string(forKey: "First Name")
        self.txtFirstName.placeholder = appDel.mapping?.string(forKey: "Last Name")
        
        self.txtSignUpEmail.placeholder = appDel.mapping?.string(forKey: "Your email")
        self.txtSignUpPassword.placeholder = appDel.mapping?.string(forKey: "At least 6 characters")
        self.txtSignUpGender.placeholder = appDel.mapping?.string(forKey: "Your gender")
        self.txtSignUpTelephone.placeholder = appDel.mapping?.string(forKey: "Your telephone")
    
        self.txtLoginEmail.placeholder = appDel.mapping?.string(forKey: "Email address")
        self.txtLoginPassword.placeholder = appDel.mapping?.string(forKey: "Password")
        
        self.btnLogin.setTitle(appDel.mapping?.string(forKey: "Sign In"), for: UIControlState.normal)
        self.btnForgotPassword.setTitle(appDel.mapping?.string(forKey: "Forgot password ?"), for: UIControlState.normal)
        
         self.btnPickerDone.setTitle(appDel.mapping?.string(forKey: "Done"), for: UIControlState.normal)
         self.btnPickerCancel.setTitle(appDel.mapping?.string(forKey: "Cancel"), for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }

    
    //MARK:-Private Mehod
    
    func dismissCon(notification: NSNotification){
        self.dismiss(animated: false, completion: nil)
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
    func setupView(index:NSInteger)
    {
        if index == 0 {
            
            self.btnSIgnUp.setTitleColor(UIColor.white, for: .normal)
            self.btnSIgnUp.backgroundColor = UIColor.black
            
            self.btnSignIn.setTitleColor(UIColor.black, for: .normal)
            self.btnSignIn.backgroundColor = UIColor.white
            
            self.viewMainSignUp.isHidden = false
            self.viewMainSignIn.isHidden = true
            
        }
        else
        {
            self.btnSIgnUp.setTitleColor(UIColor.black, for: .normal)
            self.btnSIgnUp.backgroundColor = UIColor.white
            
            self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
            self.btnSignIn.backgroundColor = UIColor.black
            
            self.viewMainSignUp.isHidden = true
            self.viewMainSignIn.isHidden = false
        }
    }
    
    func show()
    {
        self.viewLoader.isHidden = false
        self.imgLoader.isHidden = false
        
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.fromValue = Int(0)
        fullRotation.toValue = Int(((360 * M_PI) / 180))
        fullRotation.duration = 0.6
        fullRotation.repeatCount = 10000
        imgLoader.layer.add(fullRotation, forKey: "Spin")
    }
    
    func hide()
    {
        self.viewLoader.isHidden = true
        self.imgLoader.isHidden = true
        
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.fromValue = Int(0)
        fullRotation.toValue = Int(((360 * M_PI) / 180))
        fullRotation.duration = 0.6
        fullRotation.repeatCount = 10000
        imgLoader.layer.add(fullRotation, forKey: "Spin")
    }
    
    //MARK:- UItextfield deleaget
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.txtSignUpGender
        {
            //btnPickerDone.tag = 100;
            
            self.view.endEditing(true)
            
            self.movePickerUp(animated: true)
            
            return false
            
        }
        
        self.movePickerDown(animated: false)
        
        return true
    }
    
    
    
    //MARK:- Attributed function
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWithPhoneNumber phoneNumber: String!) {
        
        if phoneNumber == "T" {
            print("Terms")
        }
        if phoneNumber == "P" {
           print("Policy")
        }
        
    }
    
    //MARK:- Private method
    func repositionBadge(tabIndex: Int)
    {
        
        for badgeView in self.tabBarController!.tabBar.subviews[tabIndex].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
            }
        }
    }
    func signInFromFavourite()
    {
        self.hide()
        
        self.dismiss(animated: false, completion: nil)
    }
    func movePickerUp( animated:Bool)
    {
        
       // var pickerFrame:CGRect = viewPickerBg.frame
        
        //pickerFrame.origin.y = UIScreen.main.bounds.size.height - pickerFrame.size.height;
        
        
        var animDuration = 0.0
        
        if animated
        {
            animDuration = 0.5
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        self.viewPickerBottom.constant = 0
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
    }
    
    func movePickerDown( animated:Bool)
    {
        
      //  var pickerFrame:CGRect = viewPickerBg.frame
        
       
        
        var animDuration = 0.0
        
        if animated
        {
            animDuration = 0.5
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animDuration)
        
        self.viewPickerBottom.constant = -5000
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
    }
    
    //MARK:- Action zones
    
    @IBAction func btnFPAction(_ sender: Any)
    {
        let obj:ForgotPasswordViewController = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.present(obj, animated: true, completion: nil)
    }
    @IBAction func btnLoginAction(_ sender: Any)
    {
        if self.txtLoginEmail.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter email"))!)
            return
        }
        if self.txtLoginPassword.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter password"))!)
            return
        }
        if self.isValidEmailAddress(emailAddressString: self.txtLoginEmail.text!) == false {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter valid email address"))!)
            return
        }
        
        self.show()
        
        let str:String = String(format:"\(API_URL)/v1/customer/login")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(self.txtLoginEmail.text, forKey: "email")
        parameter.setValue(self.txtLoginPassword.text, forKey: "password")
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
                self.hide()
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                self.isSomethingWrong = true
                
                if httpStatus.statusCode != 400
                {
                    DispatchQueue.main.async()
                        {
                            self.hide()
                            return
                    }
                   
                }
                else
                {
                    DispatchQueue.main.async()
                        {
                            self.hide()
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

            UserDefaults.standard.setValue(self.txtLoginEmail.text, forKey: "userEmail")
            
            UserDefaults.standard.synchronize()
            print(jsonResult)
            
            DispatchQueue.main.async()
                {

                    if self.isSomethingWrong == true
                    {
                        self.isSomethingWrong = false
                        
                        self.appDel.showAlert(title: "You did not sign in correctly or your account is temporarily disabled.")
                    }
                    else
                    {
                        if jsonResult.value(forKey: "success") as! Int == 1
                        {
                            
                            UserDefaults.standard.setValue(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "id"), forKey: "userDetail")
                            
                            UserDefaults.standard.setValue("\(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "firstname")!) \(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "lastname")!)", forKey: "userName")
                            
                            UserDefaults.standard.set(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "cart_count"), forKey: "badge")
                            
                            UserDefaults.standard.synchronize()
                            
                            if self.isFromFavourite == true
                            {
                                self.appDel.isFromFavouriteSignIn = true
                                
                                self.appDel.createEmptyCartForUser(Auth:  (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "token") as! String, needToPost: false)
                            }
                            else
                            {
                                self.appDel.createEmptyCartForUser(Auth:  (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "token") as! String, needToPost: false)
                                
                                self.hide()
                                
                                self.objProfile?.isFromLoginOrSignUp = true
                                
                                self.dismiss(animated: false, completion: nil)
                            }
                        }
                        else
                        {
                            self.hide()
                            
                            self.appDel.showAlert(title: (jsonResult.value(forKey: "message") as! String))
                        }

                    }
                    
            }
            
        }
        task.resume()
    }
    
    @IBAction func btnRegisterAccountAction(_ sender: Any)
    {
        self.view.endEditing(true)
        
        
        if self.txtSignUpName.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter name"))!)
            return
        }
        if self.txtFirstName.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter name"))!)
            return
        }
        if self.txtSignUpEmail.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter email"))!)
            return
        }
        if self.txtSignUpPassword.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter password"))!)
            return
        }
        if self.txtSignUpGender.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please select gender"))!)
            return
        }
        if self.txtSignUpTelephone.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter telephone"))!)
            return
        }
        if self.isValidEmailAddress(emailAddressString: self.txtSignUpEmail.text!) == false {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter valid email address"))!)
            return
        }
        if (self.txtSignUpPassword.text?.characters.count)! < 6
        {
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Password should be at least 6 characters"))!)
            return
        }
        
        self.show()
        
        let str:String = String(format:"\(API_URL)/v1/customer/register")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(self.txtSignUpName.text, forKey: "firstname")
        parameter.setValue(self.txtFirstName.text, forKey: "lastname")
        parameter.setValue(self.txtSignUpEmail.text, forKey: "email")
        parameter.setValue(self.txtSignUpPassword.text, forKey: "password")
        
        if !isEnglish
        {
            if self.txtSignUpGender.text == "ذكر"
            {
                parameter.setValue("male", forKey: "gender")
            }
            else
            {
                parameter.setValue("female", forKey: "gender")
            }
        }
        else
        {
            parameter.setValue(self.txtSignUpGender.text?.lowercased(), forKey: "gender")
        }
        
        parameter.setValue(self.txtSignUpTelephone.text, forKey: "telephone")
        
        if self.btnSubscribeCheckbox.isSelected == true
        {
             parameter.setValue(true, forKey: "subscribe")
        }
        else
        {
             parameter.setValue(false, forKey: "subscribe")
        }
        
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
                self.hide()
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                if httpStatus.statusCode == 400
                {
                    
                    DispatchQueue.main.async()
                        {
                            
                            self.hide()
                            return
                    }
                }
                else
                {
                    self.hide()
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
            
            
            
            UserDefaults.standard.setValue(self.txtSignUpEmail.text, forKey: "userEmail")
            
            UserDefaults.standard.synchronize()
            print(jsonResult)
            
            DispatchQueue.main.async()
                {
                    
                    if jsonResult.value(forKey: "success") as! Int == 1
                    {
                        self.appDel.createEmptyCartForUser(Auth:  (jsonResult.value(forKey: "data") as! NSDictionary).value(forKey: "token") as! String, needToPost: false)
                        
                        UserDefaults.standard.setValue(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "id"), forKey: "userDetail")
                        
                        UserDefaults.standard.setValue("\(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "firstname")!) \(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "customerDetails") as! NSMutableDictionary).value(forKey: "lastname")!)", forKey: "userName")
                        
                        UserDefaults.standard.set(nil, forKey: "badge")
                        
                        UserDefaults.standard.synchronize()
                        
                        if self.isFromFavourite == true
                        {
                            self.appDel.isFromFavouriteSignIn = true
                        }
                        else
                        {
                            self.objProfile?.isFromLoginOrSignUp = true
                            
                            self.dismiss(animated: false, completion: nil)
                            
                             self.hide()
                        }
                        
                       
                        
                    }
                    else
                    {
                         self.hide()
                        
                        self.appDel.showAlert(title: (jsonResult.value(forKey: "message") as! String))
                    }
            }
            
        }
        task.resume()
    }
    
    
    @IBAction func btnSubscribeCheckboxAction(_ sender: Any)
    {
        let btn:UIButton = sender as! UIButton
        
        if btn.isSelected == true {
            
            btn.isSelected = false
        }
        else{
            btn.isSelected = true
        }
    }
    @IBAction func btnDismissAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSignUpAction(_ sender: Any)
    {
        FIRAnalytics.logEvent(withName: "Sign_Up", parameters: ["name":"Sign_Up"])
        
        self.setupView(index: 0)
    }
    @IBAction func btnSignInAction(_ sender: Any)
    {
        self.setupView(index: 1)
        
        FIRAnalytics.logEvent(withName: "Sign_In", parameters: ["name":"Sign_In"])
    }
    @IBAction func btnPickerCancel_Click(sender: AnyObject)
    {
        self.movePickerDown(animated: true)
    }
    @IBAction func btnPickerDone_Click(sender: AnyObject)
    {
        self.txtSignUpGender.text = "\((self.arrGender.object(at: normalPicker.selectedRow(inComponent: 0)) as? String)!)"
        
        self.movePickerDown(animated: true)
    }
    //MARK: pickerview delegate method
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrGender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let str:String = self.arrGender.object(at: row) as! String
        
        return str
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let lblPickerCell:UILabel = UILabel()
        lblPickerCell.backgroundColor = UIColor.clear
        lblPickerCell.frame = CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 25)
        if isEnglish {
            lblPickerCell.font = UIFont(name: appDel.strFont, size: 19.0)
        }
        else
        {
            lblPickerCell.font = UIFont(name: appDel.strFontKufi, size: 19.0)
        }
        
        lblPickerCell.textColor = UIColor.darkGray
        lblPickerCell.textAlignment = NSTextAlignment.center
        lblPickerCell.text = self.arrGender.object(at: row) as? String
        
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
