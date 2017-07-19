//
//  GuestLoginViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 20/02/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class UserDashboardViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var wbView: UIWebView!
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        FIRAnalytics.logEvent(withName: "MyShy7lo_Account", parameters: ["name":"MyShy7lo_Account"])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
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
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)

        let strId:String = String(format:"%d",UserDefaults.standard.value(forKey: "userDetail")  as! Int)
        
        if isEnglish {
            
            let strUrl:String = String(format: "http://shy7lo.com/en/shy7locheckout/checkout/login/id/%@/token/5u8vv8q8s6244i523reTvs5w4f5r5ok4",strId)
            
           // let strUrl:String = String(format: "http://new.shylabs.com/en/shy7locheckout/checkout/login/id/%@/token/5u8vv8q8s6244i523reTvs5w4f5r5ok4",strId)
            
            let url:URL = URL(string: strUrl)!
            let urlreq:URLRequest = URLRequest(url: url)
            self.wbView.loadRequest(urlreq)
            
        }
        else
        {
            let strUrl:String = String(format: "http://shy7lo.com/ar/shy7locheckout/checkout/login/id/%@/token/5u8vv8q8s6244i523reTvs5w4f5r5ok4",strId)
            
          // let strUrl:String = String(format: "http://new.shylabs.com/ar/shy7locheckout/checkout/login/id/%@/token/5u8vv8q8s6244i523reTvs5w4f5r5ok4",strId)
            
            let url:URL = URL(string: strUrl)!
            let urlreq:URLRequest = URLRequest(url: url)
            self.wbView.loadRequest(urlreq)
            
        }

     //   self.wbView.scrollView.frame = self.wbView.frame
        
    //    self.wbView.scrollView.contentInset = UIEdgeInsetsMake(-64,0,0,0)
        
        // Do any additional setup after loading the view.
    }

    
   //MARK:- Action zones
    
    @IBAction func btnLogoutAction(_ sender: Any)
    {
        UserDefaults.standard.setValue("", forKey: "userDetail")
        
        UserDefaults.standard.setValue("", forKey: "userName")
        
        UserDefaults.standard.setValue("", forKey: "user_authorization")
        
        UserDefaults.standard.set("", forKey: "user_cart_id")
        
        UserDefaults.standard.synchronize()
        
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
    @IBAction func btnBackAction(_ sender: Any)
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
    
    
    //MARK:-Webview delegate method
    
    //MARK:- Wenview delegate method
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        print(request.url?.absoluteString ?? "")
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.HUD?.show(true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
          let items = "document.querySelector('.page-header').style.display ='none';"+"document.getElementById('maincontent').style.marginTop ='-120px';"
            + "document.querySelector('ul li.item:nth-of-type(8)').style.display ='none';"
            + "document.querySelector('.page-footer').style.display='none'"
        
        
        webView.stringByEvaluatingJavaScript(from: items)
        
        self.HUD?.hide(true)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        self.HUD?.hide(true)
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
