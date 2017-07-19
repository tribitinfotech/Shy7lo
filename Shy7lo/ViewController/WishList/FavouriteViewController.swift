//
//  FavouriteViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 03/09/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class FavouriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {

    //MARK:- VIew life cycle
    
    @IBOutlet weak var viewFavourite: UIView!
    
    @IBOutlet weak var lblFavouriteInstruction: UILabel!
    
    @IBOutlet weak var btnGoToProducts: UIButton!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var tblFavourite: UITableView!
    
    var arrFavourite:NSMutableArray = NSMutableArray()
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.tblFavourite.register(UINib(nibName: "cellFavourite", bundle: nil), forCellReuseIdentifier: "cellFavourite")
        
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        FIRAnalytics.logEvent(withName: "Wishlist", parameters: ["name":"Wishlist"])
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.viewFavourite.isHidden = true
        
        if isEnglish
        {
            
            self.viewTop.transform = CGAffineTransform.identity
            
            self.btnTitle.transform = CGAffineTransform.identity
            
            self.btnTitle.titleLabel?.font = UIFont(name: appDel.strFont, size: 17.0)!
            
            self.btnTitle.contentHorizontalAlignment = .center
        }
        else
        {
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnTitle.titleLabel?.font = UIFont(name: appDel.strFont, size: 17.0)!
            
            self.btnTitle.contentHorizontalAlignment = .center
        }
        
        self.btnTitle.setTitle(appDel.mapping?.string(forKey: "WISHLIST"), for: UIControlState.normal)
        
        self.getFavourite(needToShowHud: true)
        
    }
    //MARK:- Uitableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrFavourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavourite", for: indexPath) as! cellFavourite
        
        let dict:NSMutableDictionary = self.arrFavourite.object(at: indexPath.row) as! NSMutableDictionary
        
        cell.setUpUI()
        //let strURL:String = String(format: "%@%@",IMAGE_URL_CART,dict.value(forKey: "image") as! String)
        
        let strURL:String = String(format: "%@",dict.value(forKey: "image") as! String)
        
        cell.imgProduct.sd_setImage(with:  NSURL(string: strURL) as URL!, placeholderImage: UIImage(named: "image_placeholder.png"), options: SDWebImageOptions.lowPriority)
        
        cell.lblProductName.text = dict.value(forKey: "name") as? String
        
        if let brand = dict.value(forKey: "brand") as? String
        {
            cell.lblBrandName.text = dict.value(forKey: "brand") as? String
        }
        else
        {
            cell.lblBrandName.text = ""
        }
        
        //cell.lblPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
        
        if let price = dict.value(forKey: "special_price") as? String
        {
            
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let fromdate = dict.value(forKey: "special_from_date") as? String
            {
                if let todate = dict.value(forKey: "special_to_date") as? String
                {
                    let dateFrom = dateFormatter.date(from: dict.value(forKey: "special_from_date") as! String)!
                    // Get a later date (after a couple of milliseconds)
                    let dateTo = dateFormatter.date(from: dict.value(forKey: "special_to_date") as! String)!
                    
                    if NSDate().isBetweeen(date: dateFrom as NSDate, andDate: dateTo as NSDate) == true
                    {
                        cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "special_price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.red
                        
                        cell.lblOldPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPriceSeperator.isHidden = false
                        
                        cell.lblOldPrice.isHidden = false
                    }
                    else
                    {
                        cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.black
                        
                        cell.lblPriceSeperator.isHidden = true
                        
                        cell.lblOldPrice.isHidden = true
                    }

                }
                else
                {
                    cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                    
                    cell.lblPrice.textColor = UIColor.black
                    
                    cell.lblPriceSeperator.isHidden = true
                    
                    cell.lblOldPrice.isHidden = true
                }
            }
            else
            {
                cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                
                cell.lblPrice.textColor = UIColor.black
                
                cell.lblPriceSeperator.isHidden = true
                
                cell.lblOldPrice.isHidden = true
            }
            
        }
        else
        {
            cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
            cell.lblPrice.textColor = UIColor.black
            
            cell.lblPriceSeperator.isHidden = true
            
            cell.lblOldPrice.isHidden = true
        }
        
        
        
        cell.btnClose.tag = indexPath.row
        
        cell.btnClose.addTarget(self, action: #selector(btnCloseAction(_:)), for: UIControlEvents.touchUpInside)
     
    
        if isEnglish {
            
            cell.lblProductName.font = UIFont(name: appDel.strFont, size: 17.0)
            cell.lblBrandName.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            cell.lblPrice.font = UIFont(name: appDel.strFont_Bold, size: 18.0)
            cell.lblOldPrice.font = UIFont(name: appDel.strFont_Bold, size: 18.0)
       
        }
        else
        {
            cell.lblProductName.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            cell.lblBrandName.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            cell.lblPrice.font = UIFont(name: appDel.strFontKufi_Bold, size: 18.0)
            cell.lblOldPrice.font = UIFont(name: appDel.strFontKufi_Bold, size: 18.0)
           
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //trailing space of quantity
        
        cell.contentView.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("%@",self.arrFavourite.object(at: indexPath.row))
        
        if isEnglish {
            
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            obj.strProductSKU = (self.arrFavourite.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
            obj.isFromFavourite = true
            obj.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            obj.strProductSKU = (self.arrFavourite.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
            obj.hidesBottomBarWhenPushed = true
            obj.isFromFavourite = true
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            navigationController?.view?.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(obj, animated: false)
            
        }
    }
    //MARK:- Private method
    
    func getFavourite(needToShowHud:Bool)
    {
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            if needToShowHud == true {
                self.HUD?.show(true)
            }
            
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
            manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            print(UserDefaults.standard.value(forKey: "user_authorization") as! String)
            
            manager.requestSerializer.setValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let str:String = String(format:"\(API_URL)/v1/customer/wishlist")
            
            manager.post(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
                
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    print(jsonResult)
                    
                    if let dict = (jsonResult.value(forKey: "data") as? NSMutableDictionary)?.value(forKey: "wishlistData") as? NSMutableArray
                    {
                        self.arrFavourite = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "wishlistData") as! NSMutableArray
                        
                        print(self.arrFavourite)
                        
                        if self.arrFavourite.count == 0
                        {
                            self.HUD?.hide(true)
                            
                            self.tblFavourite.isHidden = true
                            
                            self.viewFavourite.isHidden = false
                            
                            self.btnGoToProducts.tag = 2
                            
                            self.btnGoToProducts.setTitle(self.appDel.mapping?.string(forKey: "Go to products"), for: UIControlState.normal)
                            
                            self.lblFavouriteInstruction.text = self.appDel.mapping?.string(forKey: "Your wishlist is empty")
                            
                        }
                        else
                        {
                            // self.getProductImage(index: 0)
                            
                            self.viewFavourite.isHidden = true
                            
                            self.HUD?.hide(true)
                            
                            self.tblFavourite.isHidden = false
                            
                            self.tblFavourite.reloadData()
                        }
                        
                    }
                    else
                    {
                        self.HUD?.hide(true)
                        
                        self.tblFavourite.isHidden = true
                        
                        self.viewFavourite.isHidden = false
                        
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
        else
        {
             /*let alert:UIAlertView = UIAlertView(title: (appDel.mapping?.string(forKey: "Shy7lo"))!, message: (appDel.mapping?.string(forKey: "You need to login first"))!, delegate: self, cancelButtonTitle: appDel.mapping?.string(forKey: "Login Now"), otherButtonTitles: (appDel.mapping?.string(forKey: "OK"))!)
            
            alert.show()*/
            
            self.viewFavourite.isHidden = false
            
             self.tblFavourite.isHidden = true
            
            self.btnGoToProducts.tag = 1
            
            self.btnGoToProducts.setTitle(appDel.mapping?.string(forKey: "Login Now"), for: UIControlState.normal)
            
            self.lblFavouriteInstruction.text = appDel.mapping?.string(forKey: "You need to login first to get your wishlist")
            
        }

    }
    
    //MARK:- Alertview delegate
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        print(buttonIndex)
        
        if buttonIndex == 0
        {
            let obj:SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
            obj.selectedIndex = 1
            obj.objFavourite = self
            self.present(obj, animated: true, completion: nil)
        }
    }
    
    //MARK:- Action zone
    
    @IBAction func btnMenuAction(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func btnGoToProductAction(_ sender: Any)
    {
        if self.btnGoToProducts.tag == 1
        {
            let obj:SignUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
            obj.selectedIndex = 1
            obj.isFromFavourite = true
            obj.objFavourite = self
            self.present(obj, animated: true, completion: nil)
        }
        else{
            
            if (NSLocale.preferredLanguages[0] ).contains("ar") == true
            {
                self.tabBarController?.selectedIndex = 4
            }
            else
            {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    @IBAction func btnCloseAction(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrFavourite.object(at: btn.tag) as! NSMutableDictionary
        
        HUD?.show(true)
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            let str:String = String(format:"\(API_URL)/v1/customer/wishlist/deleteitem")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "DELETE"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(dict.value(forKey: "id") as! String, forKey: "item_id")
            
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
                
                DispatchQueue.main.async()
                    {
                        self.getFavourite(needToShowHud: false)
                }
                
            }
            task.resume()
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
