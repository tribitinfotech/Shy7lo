//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
   
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnApply: UIButton!
    
    @IBOutlet weak var lblSelectYourCountry: UILabel!
    
     var HUD : MBProgressHUD?
    
    @IBOutlet weak var imgLoader: UIImageView!
    @IBOutlet weak var viewLoader: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        FIRAnalytics.logEvent(withName: "Forgot_Password", parameters: ["name":"Forgot_Password"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        if isEnglish {
            
            self.imgTitle.image = UIImage(named: "ic_top_logo.png")
            self.viewTop.transform = CGAffineTransform.identity
            self.imgTitle.transform = CGAffineTransform.identity

            self.lblSelectYourCountry.textAlignment = .left
            
            self.lblSelectYourCountry.font = UIFont(name: appDel.strFont, size: 16.0)
            
            self.txtEmail.font = UIFont(name: appDel.strFont, size: 16.0)
            
            self.txtEmail.textAlignment = .left

        }
        else
        {
            self.imgTitle.image = UIImage(named: "logo_arabic.png")
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSelectYourCountry.textAlignment = .right
            
            self.lblSelectYourCountry.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.txtEmail.font = UIFont(name: appDel.strFontKufi, size: 16.0)
            
            self.txtEmail.textAlignment = .right
            
        }
        
        self.lblSelectYourCountry.text = appDel.mapping?.string(forKey: "Request new password")
        
        self.txtEmail.placeholder = appDel.mapping?.string(forKey: "Email")
        
        self.btnApply.setTitle(appDel.mapping?.string(forKey: "Request new password"), for: UIControlState.normal)
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)

        
        // Do any additional setup after loading the view.
    }

    //MARK:- Private method
    
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
    
    //MARK:- Action zones
    
    
    @IBAction func btnApplyAction(_ sender: Any)
    {
        if self.txtEmail.text == "" {
            
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "Please enter email"))!)
            return
        }
        
        
        self.show()
        
        let str:String = String(format:"\(API_URL)/v1/customer/password/forget")
        
        var request = URLRequest(url: URL(string: str)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(self.txtEmail.text, forKey: "email")
        
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
                DispatchQueue.main.async()
                    {
                        if httpStatus.statusCode != 400
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

            UserDefaults.standard.synchronize()
            print(jsonResult)
            
            DispatchQueue.main.async()
                {
                    
                    self.hide()
                    
                    if jsonResult.value(forKey: "success") as! Int == 1
                    {
                        
                        self.appDel.showAlert(title: "Password reset request successful,please check your mail")
                        
                    
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    else
                    {
                        self.appDel.showAlert(title: (jsonResult.value(forKey: "message") as! String))
                    }
            }
            
        }
        task.resume()
    }
    
    @IBAction func btnDismissAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
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
