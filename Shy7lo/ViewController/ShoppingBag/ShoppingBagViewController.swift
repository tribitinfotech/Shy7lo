//
//  ShoppingBagViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 03/09/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics
class ShoppingBagViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblStaticShoppingBag: UIButton!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnStaticCheckout: UIButton!
    @IBOutlet weak var lblStaticSubtotal: UILabel!
    @IBOutlet weak var btnStaticGoToProducts: UIButton!
    @IBOutlet weak var lblStaticShoppingBagInfo: UILabel!
    @IBOutlet weak var tblCart: UITableView!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblEstimateDelivery: UILabel!
    @IBOutlet weak var lblTotalProducts: UILabel!
    
    @IBOutlet weak var viewBottom: UIView!
    var arrCart:NSMutableArray = NSMutableArray()
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var HUD : MBProgressHUD?
    
    
    @IBOutlet weak var viewNoProducts: UIView!
    //MARK:- VIew life cycle
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAnalytics.logEvent(withName: "My_Cart", parameters: ["name":"My_Cart"])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDel.isLanguageChanged = false
        
        if isEnglish {
            
            self.lblStaticShoppingBag.titleLabel?.font = UIFont(name: appDel.strFont, size: 18.0)!
            self.lblStaticSubtotal.font = UIFont(name: appDel.strFont_Bold, size: 19.0)
            self.lblStaticShoppingBagInfo.font = UIFont(name: appDel.strFont, size: 19.0)
            
            self.btnStaticGoToProducts.titleLabel?.font = UIFont(name: appDel.strFont, size: 18.0)!
            
            self.btnStaticCheckout.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 17.0)!
            
            self.lblSubTotal.font = UIFont(name: appDel.strFont_Bold, size: 19.0)
            self.lblEstimateDelivery.font = UIFont(name: appDel.strFont, size: 15.0)
            self.lblTotalProducts.font = UIFont(name: appDel.strFont, size: 15.0)
            
            self.viewTop.transform = CGAffineTransform.identity
            self.lblStaticShoppingBag.transform = CGAffineTransform.identity
            
            self.lblStaticShoppingBag.contentHorizontalAlignment = .center
            
            
            self.viewBottom.transform = CGAffineTransform.identity
            
            self.lblStaticSubtotal.transform = CGAffineTransform.identity
            
            self.lblStaticSubtotal.textAlignment = .left
            
            self.lblEstimateDelivery.transform = CGAffineTransform.identity
            
            self.lblEstimateDelivery.textAlignment = .left
            
            self.lblSubTotal.transform = CGAffineTransform.identity
            
            self.lblSubTotal.textAlignment = .right
            
            self.lblTotalProducts.transform = CGAffineTransform.identity
            
            self.lblTotalProducts.textAlignment = .right
            
            self.btnStaticCheckout.transform = CGAffineTransform.identity
            
        }
        else
        {
            self.lblStaticShoppingBag.titleLabel?.font = UIFont(name: appDel.strFont, size: 18.0)!
            self.lblStaticSubtotal.font = UIFont(name: appDel.strFontKufi_Bold, size: 19.0)
            
            self.btnStaticGoToProducts.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: 18.0)!
            
            self.btnStaticCheckout.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)!
            
            self.lblSubTotal.font = UIFont(name: appDel.strFontKufi_Bold, size: 19.0)
            self.lblEstimateDelivery.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            self.lblTotalProducts.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblStaticShoppingBag.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticShoppingBag.contentHorizontalAlignment = .center
            
            
            self.viewBottom.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticSubtotal.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblStaticSubtotal.textAlignment = .right
            
            self.lblEstimateDelivery.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblEstimateDelivery.textAlignment = .right
            
            self.lblSubTotal.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblSubTotal.textAlignment = .left
            
            self.lblTotalProducts.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblTotalProducts.textAlignment = .left
            
            self.btnStaticCheckout.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)

           
            /* let paragraphStyle = NSMutableParagraphStyle()
             
             paragraphStyle.lineSpacing = -999
             paragraphStyle.alignment = NSTextAlignment.center
             let attrString1 = NSMutableAttributedString(string: self.lblStaticShoppingBagInfo.text!)
             attrString1.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString1.length))
             
             self.lblStaticShoppingBagInfo.attributedText = attrString1
             
             self.lblStaticShoppingBagInfo.textAlignment = NSTextAlignment.center */
        }
        
        
        self.lblStaticShoppingBag.setTitle(appDel.mapping?.string(forKey: "Shopping bag"), for: UIControlState.normal)
        
        self.lblStaticShoppingBagInfo.text = appDel.mapping?.string(forKey: "Empty bag")
        
        self.btnStaticGoToProducts.setTitle(appDel.mapping?.string(forKey: "Go to products"), for: UIControlState.normal)
        
        self.lblStaticSubtotal.text = appDel.mapping?.string(forKey: "Subtotal")
        
        self.btnStaticCheckout.setTitle(appDel.mapping?.string(forKey: "Checkout"), for: UIControlState.normal)
        
        
        self.getCartItems(showhud: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.tblCart.register(UINib(nibName: "cellCart", bundle: nil), forCellReuseIdentifier: "cellCart")
        
        self.navigationController?.isNavigationBarHidden = true

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 203;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 203;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCart", for: indexPath) as! cellCart
        
        let dict:NSMutableDictionary = self.arrCart.object(at: indexPath.row) as! NSMutableDictionary
        
        //let strURL:String = String(format: "%@%@",IMAGE_URL_CART,dict.value(forKey: "image") as! String)
        
        let strURL:String = String(format: "%@",dict.value(forKey: "image") as! String)
        
        cell.imgProduct.sd_setImage(with:  NSURL(string: strURL) as URL!, placeholderImage: UIImage(named: "image_placeholder.png"), options: SDWebImageOptions.lowPriority)
        
        if let brand = dict.value(forKey: "brand") as? String
        {
            cell.lblProductName.text = dict.value(forKey: "brand") as? String
        }
        else
        {
            cell.lblProductName.text = ""
        }
        
        
        
        cell.lblBrandName.text = dict.value(forKey: "name") as? String
        
        cell.lblPrice.adjustsFontSizeToFitWidth = true
        
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
                        
                        cell.lblOldPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPriceSeperator.isHidden = false
                        
                        cell.lblOldPrice.isHidden = false
                    }
                    else
                    {
                        cell.lblPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.black
                        
                        cell.lblPriceSeperator.isHidden = true
                        
                        cell.lblOldPrice.isHidden = true
                    }
                    
                }
                else
                {
                    cell.lblPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                    
                    cell.lblPrice.textColor = UIColor.black
                    
                    cell.lblPriceSeperator.isHidden = true
                    
                    cell.lblOldPrice.isHidden = true
                }
            }
            else
            {
                cell.lblPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                
                cell.lblPrice.textColor = UIColor.black
                
                cell.lblPriceSeperator.isHidden = true
                
                cell.lblOldPrice.isHidden = true
            }

        }
        else
        {
            cell.lblPrice.text = String(format: "%0.2f %@",(dict.value(forKey: "price") as! NSNumber).floatValue*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
            
            cell.lblPrice.textColor = UIColor.black
            
            cell.lblPriceSeperator.isHidden = true
            
            cell.lblOldPrice.isHidden = true
        }
        
        
        cell.lblQuantity.text =  String(format: "%@",(dict.value(forKey: "qty") as! NSNumber).stringValue)
        
        cell.viewRemove.layer.borderWidth = 1.0
        cell.viewRemove.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.viewFavourite.layer.borderWidth = 1.0
        cell.viewFavourite.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.btnRemove.tag = indexPath.row
        cell.btnFavourite.tag = indexPath.row
        
        cell.btnPlus.tag = indexPath.row
        cell.btnMinus.tag = indexPath.row
        cell.btnDetail.tag = indexPath.row
        
        cell.btnRemove.addTarget(self, action: #selector(btnRemoveAction(_:)), for: UIControlEvents.touchUpInside)
        cell.btnFavourite.addTarget(self, action: #selector(btnFavouriteAction(_:)), for: UIControlEvents.touchUpInside)
        cell.btnDetail.addTarget(self, action: #selector(btnDetailAction(_:)), for: UIControlEvents.touchUpInside)
        
        cell.btnPlus.addTarget(self, action: #selector(btnPlusAction(_:)), for: UIControlEvents.touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(btnMinusAction(_:)), for: UIControlEvents.touchUpInside)

        
        if UIScreen.main.bounds.size.width == 320
        {
            cell.quantityTrailing.constant = 4
        }
        else if UIScreen.main.bounds.size.width == 375
        {
            cell.quantityTrailing.constant = 20
        }
        else
        {
            cell.quantityTrailing.constant = 24
        }
        
        if dict.value(forKey: "product_type") as? String == "configurable" {
            
            let arr:NSMutableArray = (dict.value(forKey: "configure_option") as? NSMutableArray)!
            
            if arr.count > 0
            {
                for item in arr {
                    
                    let dict:NSMutableDictionary = item as! NSMutableDictionary
                    
                    if (dict.value(forKey: "option_label") as! String).lowercased().contains("size") == true {
                        
                         cell.btnSize.isHidden = false
                        
                         cell.btnSize.setTitle("\((appDel.mapping?.string(forKey: "Size_cart"))!) : \(dict.value(forKey: "option_value") as! String)", for: UIControlState.normal)
                        
                         break
                    }
                }
            }

        }
        else
        {
            cell.btnSize.isHidden = true
        }
        
        cell.btnSize.titleLabel?.adjustsFontSizeToFitWidth = true
        
        if isEnglish {
            
            cell.lblProductName.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            cell.lblBrandName.font = UIFont(name: appDel.strFont, size: 14.0)
            cell.btnSize.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 14.0)
            cell.lblPrice.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            cell.lblSaveForLater.font = UIFont(name: appDel.strFont, size: 15.0)
            cell.lblRemove.font = UIFont(name: appDel.strFont, size: 15.0)
            cell.lblQuantity.font = UIFont(name: appDel.strFont, size: 22.0)
        }
        else
        {
            cell.lblProductName.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            cell.lblBrandName.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            cell.btnSize.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 13.0)
            cell.lblPrice.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            cell.lblSaveForLater.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            cell.lblRemove.font = UIFont(name: appDel.strFontKufi, size: 15.0)
            cell.lblQuantity.font = UIFont(name: appDel.strFontKufi, size: 22.0)
        }
        
        cell.updateUI()
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //trailing space of quantity
        
        cell.contentView.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    //MARK:- Action zones
    @IBAction func btnMenuAction(_ sender: Any)
    {
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func btnGoToProductsAction(_ sender: AnyObject)
    {
        if (NSLocale.preferredLanguages[0] ).contains("ar") == true
        {
            self.tabBarController?.selectedIndex = 4
        }
        else
        {
            self.tabBarController?.selectedIndex = 0
        }
    }
    @IBAction func btnCheckOutAction(_ sender: AnyObject)
    {
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != ""
        {
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
            let guestLogin:GuestLoginViewController = GuestLoginViewController(nibName: "GuestLoginViewController", bundle: nil)
            self.navigationController?.pushViewController(guestLogin, animated: false)
        }
        
    }
    @IBAction func btnRemoveAction(_ sender: AnyObject)
    {
         print("remove")
        
        let btn:UIButton = sender as! UIButton
        
        self.HUD?.show(true)
        
        let dict:NSMutableDictionary = self.arrCart.object(at: btn.tag) as! NSMutableDictionary
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/delete-item")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "DELETE"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue((dict.value(forKey: "item_id") as! NSNumber).stringValue, forKey: "item_id")
            
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
                        self.getCartItems(showhud: false)
                }
                
            }
            task.resume()
        }
        else
        {
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/guest-carts/delete-item")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "DELETE"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            parameter.setValue((dict.value(forKey: "item_id") as! NSNumber).stringValue, forKey: "item_id")
            
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
                        self.getCartItems(showhud: false)
                }
                
            }
            task.resume()
        }
        
    }
    
    @IBAction func btnDetailAction(_ sender: AnyObject)
    {
        
        let btn:UIButton = sender as! UIButton
        
        print("%@",self.arrCart.object(at: btn.tag))
        
        if isEnglish {
            
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            
            if let strSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "parent_sku") as? String
            {
                obj.strProductSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "parent_sku") as! String as NSString?
            }
            else
            {
                obj.strProductSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
            }
            
            obj.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            if let strSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "parent_sku") as? String
            {
                obj.strProductSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "parent_sku") as! String as NSString?
            }
            else
            {
                obj.strProductSKU = (self.arrCart.object(at: btn.tag) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
            }
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
    @IBAction func btnFavouriteAction(_ sender: AnyObject)
    {
        
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrCart.object(at: btn.tag) as! NSMutableDictionary
        
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            HUD?.show(true)
            
            let str:String = String(format:"\(API_URL)/v1/customer/wishlist/additem")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            
            if let strSKU = dict.value(forKey: "parent_sku") as? String
            {
                parameter.setValue(dict.value(forKey: "parent_sku") as! String, forKey: "sku")
            }
            else
            {
                parameter.setValue(dict.value(forKey: "sku") as! String, forKey: "sku")
            }

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
                        var jsonResult:NSDictionary = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        print(jsonResult)
                        
                         self.HUD?.hide(true)
                        
                        if (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "status") as! Int == 1
                        {
                              self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Successfully added to wishlist"))!)
                        }
                        
                      
                }
                
            }
            task.resume()
        }
        else
        {
            appDel.showAlert(title: (appDel.mapping?.string(forKey: "You need to login first"))!)
        }
    }
    
    @IBAction func btnPlusAction(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrCart.object(at: btn.tag) as! NSMutableDictionary

        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            HUD?.show(true)
            
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/update")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(NSNumber(value: (dict.value(forKey: "item_id") as! NSNumber).intValue), forKey: "item_id")
            parameter.setValue(dict.value(forKey: "sku") as! String, forKey: "sku")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue + 1), forKey: "qty")
            
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
                        var jsonResult:NSDictionary = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        print(jsonResult)
                        
                        self.HUD?.hide(true)
                        
                        if (jsonResult.value(forKey: "success") as! NSNumber).stringValue == "1"
                        {
                            dict.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue + 1), forKey:"qty")
                            
                            self.tblCart.reloadData()
                            
                            self.calculateTotal()
                        }
                        else
                        {
                            self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "You have reached maximum quantity available"))!)
                        }
                        
                        
                }
                
            }
            task.resume()
        }
        else
        {
            HUD?.show(true)
            
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/guest-carts/update")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "item_id") as! NSNumber).intValue), forKey: "item_id")
            parameter.setValue(dict.value(forKey: "sku") as! String, forKey: "sku")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue + 1), forKey: "qty")
            
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
                        var jsonResult:NSDictionary = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        print(jsonResult)
                        
                        self.HUD?.hide(true)
                        
                        if (jsonResult.value(forKey: "success") as! NSNumber).stringValue == "1"
                        {
                            dict.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue + 1), forKey:"qty")
                            
                            self.tblCart.reloadData()
                            
                            self.calculateTotal()
                        }
                        else
                        {
                            self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "You have reached maximum quantity available"))!)
                        }
                        
                        
                }
                
            }
            task.resume()
        }
        
    }
    
    @IBAction func btnMinusAction(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrCart.object(at: btn.tag) as! NSMutableDictionary
        
        if (dict.value(forKey: "qty") as! NSNumber).intValue - 1 < 1 {
            
            return
        }
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            HUD?.show(true)
            
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/update")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(NSNumber(value: (dict.value(forKey: "item_id") as! NSNumber).intValue), forKey: "item_id")
            parameter.setValue(dict.value(forKey: "sku") as! String, forKey: "sku")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue - 1), forKey: "qty")
            
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
                        var jsonResult:NSDictionary = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        print(jsonResult)
                        
                        self.HUD?.hide(true)
                        
                        if (jsonResult.value(forKey: "success") as! NSNumber).stringValue == "1"
                        {
                            dict.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue - 1), forKey:"qty")
                            
                            self.tblCart.reloadData()
                            
                            self.calculateTotal()
                        }
                        else
                        {
                            self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "You have reached maximum quantity available"))!)
                        }
                        
                        
                }
                
            }
            task.resume()
        }
        else
        {
            HUD?.show(true)
            
            let str:String = String(format:"\(API_URL)/v1/checkout/cart/guest-carts/update")
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "item_id") as! NSNumber).intValue), forKey: "item_id")
            parameter.setValue(dict.value(forKey: "sku") as! String, forKey: "sku")
            parameter.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue - 1), forKey: "qty")
            
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
                        var jsonResult:NSDictionary = NSDictionary()
                        
                        do {
                            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                        print(jsonResult)
                        
                        self.HUD?.hide(true)
                        
                        if (jsonResult.value(forKey: "success") as! NSNumber).stringValue == "1"
                        {
                            dict.setValue(NSNumber(value: (dict.value(forKey: "qty") as! NSNumber).intValue - 1), forKey:"qty")
                            
                            self.tblCart.reloadData()
                            
                            self.calculateTotal()
                        }
                        else
                        {
                            self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "You have reached maximum quantity available"))!)
                        }
                        
                        
                }
                
            }
            task.resume()
        }
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
    
    func calculateTotal()
    {
        var totalProduct:NSInteger = 0
        var totalAmount:NSInteger = 0
        
        for items in self.arrCart
        {
            let dict:NSMutableDictionary = items as! NSMutableDictionary
            
            totalProduct = totalProduct + (dict.value(forKey: "qty") as! NSNumber).intValue
            
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
                            totalAmount = totalAmount + (NSInteger(Float(dict.value(forKey: "special_price") as! String)!) * (dict.value(forKey: "qty") as! NSNumber).intValue)
                        }
                        else
                        {
                             totalAmount = totalAmount + ((dict.value(forKey: "price") as! NSNumber).intValue * (dict.value(forKey: "qty") as! NSNumber).intValue)
                        }
                        
                    }
                    else
                    {
                         totalAmount = totalAmount + ((dict.value(forKey: "price") as! NSNumber).intValue * (dict.value(forKey: "qty") as! NSNumber).intValue)
                    }
                }
                else
                {
                     totalAmount = totalAmount + ((dict.value(forKey: "price") as! NSNumber).intValue * (dict.value(forKey: "qty") as! NSNumber).intValue)
                }
            }
            else
            {
               
                 totalAmount = totalAmount + ((dict.value(forKey: "price") as! NSNumber).intValue * (dict.value(forKey: "qty") as! NSNumber).intValue)
            }
            
           
        }
        
        self.lblSubTotal.text = String(format: "%0.2f %@",Float(totalAmount)*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
        
        if totalProduct > 1 {
            self.lblTotalProducts.text = String(format: "%d %@",totalProduct,(appDel.mapping?.string(forKey: "Products")!)!)
        }
        else
        {
            self.lblTotalProducts.text = String(format: "%d %@",totalProduct,(appDel.mapping?.string(forKey: "Product"))!)
        }
        
        
    }
    func getProductImage(index:NSInteger)
    {
        let dict:NSMutableDictionary = self.arrCart.object(at: index) as! NSMutableDictionary
        //8ilvs6ke53k10gqxsyr022ok28umaqxr
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
        manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        //manager.requestSerializer.setValue("Bearer o6esxf41wvdfp631bj23j229p1lk6ac6", forHTTPHeaderField: "Authorization")
        
        let str:String = String(format:"\(API_URL)/v1/catalog/products/image/%@",dict.value(forKey: "sku") as! String)
        
        manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
            
            print("responseObject = \(responseObject)")
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                
                print(jsonResult)
                
                
                if jsonResult.value(forKey: "success") as! Int == 1
                {
                    let arrImages = jsonResult.value(forKey: "data") as! NSMutableArray
                    
                    print(arrImages)
                    
                    if arrImages.count > 0
                    {
                        let dictImage:NSMutableDictionary = arrImages.object(at: 0) as! NSMutableDictionary
                        
                        dict.setValue(dictImage.value(forKey: "file") as! String, forKey: "image")
                        
                        if index == self.arrCart.count - 1
                        {
                            self.tblCart.isHidden = false
                            self.viewBottom.isHidden = false
                            
                            self.viewNoProducts.isHidden = true
                            
                            self.tblCart.reloadData()
                            
                            self.HUD?.hide(true)
                        }
                        else
                        {
                            self.getProductImage(index: index + 1)
                        }
                    }
                    else
                    {
                        if index == self.arrCart.count - 1
                        {
                            self.tblCart.isHidden = false
                            self.viewBottom.isHidden = false
                            
                            self.viewNoProducts.isHidden = true
                            
                            self.tblCart.reloadData()
                            
                            self.HUD?.hide(true)
                        }
                        else
                        {
                            self.getProductImage(index: index + 1)
                        }
                        
                        self.HUD?.hide(true)
                    }
                }
                else
                {
                    
                }
                
               
                
                
                // use jsonData
            } catch let err{
                // report error
                
                print(err)
            }
        
            }
            , failure: { (operation: AFHTTPRequestOperation?,
                error) in
                print("Error: " + (error?.localizedDescription)!)
                
                self.HUD?.hide(true)
                
        })

        
        
    }
    func getCartItems(showhud:Bool)
    {
        if showhud == true {
            self.HUD?.show(true)
        }
        var str1:String = ""
        
        if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
            
            str1 = String(format:"\(API_URL)/v1/checkout/cart/customer")
        
            var request = URLRequest(url: URL(string: str1)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            print(UserDefaults.standard.value(forKey: "user_authorization") as! String)
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                let auth = UserDefaults.standard.value(forKey: "user_authorization") as! String
                
                request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
            }
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            
            print(parameter)
            /*let dictSend:NSMutableDictionary = NSMutableDictionary()
             dictSend.setValue(parameter, forKey: "cartItem")*/
            
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
                
                do {
                    /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                     
                     print((string!).replacingOccurrences(of: "\"", with: ""))*/
                    
                    DispatchQueue.main.async()
                        {
                            
                            var jsonResult = NSDictionary()
                            
                            do {
                                jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                print(jsonResult)
                                
                                let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                                
                                if flag == "1"
                                {
                                    if let dict = (jsonResult.value(forKey: "data") as? NSMutableDictionary)?.value(forKey: "items") as? NSMutableArray
                                    {
                                        self.arrCart = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                                        
                                        print(self.arrCart)
                                        
                                        if self.arrCart.count == 0
                                        {
                                            self.HUD?.hide(true)
                                            
                                            self.tblCart.isHidden = true
                                            self.viewBottom.isHidden = true
                                            
                                            self.viewNoProducts.isHidden = false
                                            
                                            UserDefaults.standard.set(nil, forKey: "badge")
                                            UserDefaults.standard.synchronize()
                                            
                                            if UserDefaults.standard.integer(forKey: "badge") != 0
                                            {
                                                (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                                            }
                                            else
                                            {
                                                (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                                            }
                                            
                                        }
                                        else
                                        {
                                            //self.getProductImage(index: 0)
                                            
                                            UserDefaults.standard.set(self.arrCart.count, forKey: "badge")
                                            UserDefaults.standard.synchronize()
                                            
                                            self.HUD?.hide(true)
                                            
                                            self.tblCart.isHidden = false
                                            self.viewBottom.isHidden = false
                                            
                                            self.viewNoProducts.isHidden = true
                                            
                                            self.tblCart.reloadData()
                                            
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
                                        
                                        self.calculateTotal()
                                        
                                        self.lblEstimateDelivery.text = "\((self.appDel.mapping?.string(forKey: "Delivery"))!) 3-5 \((self.appDel.mapping?.string(forKey: "Days"))!)"
                                    }
                                    else
                                    {
                                        self.HUD?.hide(true)
                                        
                                        self.tblCart.isHidden = true
                                        self.viewBottom.isHidden = true
                                        
                                        self.viewNoProducts.isHidden = false
                                    }
                                }
                                else
                                {
                                    UserDefaults.standard.set(nil, forKey: "badge")
                                    UserDefaults.standard.synchronize()
                                    
                                    if UserDefaults.standard.integer(forKey: "badge") != 0
                                    {
                                        (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                                    }
                                    else
                                    {
                                        (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                                    }
                                }
                                
                                // use jsonData
                            } catch {
                                // report error
                            }
 
                    }
                    
                    
                    // use jsonData
                } catch let err{
                    // report error
                    
                    print(err)
                }
                
            }
            task.resume()
            
        }
        else
        {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            manager.requestSerializer.setValue("shy7lo", forHTTPHeaderField: "X-Website")
            manager.requestSerializer.setValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            let str:String = String(format:"\(API_URL)/v1/checkout/guest-carts/%@",UserDefaults.standard.value(forKey: "guest_cart_id") as! String)
            
            manager.get(str, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
                
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    print(jsonResult)
                    
                    if let dict = (jsonResult.value(forKey: "data") as? NSMutableDictionary)?.value(forKey: "items") as? NSMutableArray
                    {
                        self.arrCart = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                        
                        print(self.arrCart)
                        
                        if self.arrCart.count == 0
                        {
                            self.HUD?.hide(true)
                            
                            UserDefaults.standard.set(nil, forKey: "badge")
                            UserDefaults.standard.synchronize()
                            
                            if UserDefaults.standard.integer(forKey: "badge") != 0
                            {
                                (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                            }
                            else
                            {
                                (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                            }
                            
                            self.tblCart.isHidden = true
                            self.viewBottom.isHidden = true
                            
                            self.viewNoProducts.isHidden = false
                            
                        }
                        else
                        {
                           // self.getProductImage(index: 0)
                            
                            UserDefaults.standard.set(self.arrCart.count, forKey: "badge")
                            UserDefaults.standard.synchronize()
                            
                            if UserDefaults.standard.integer(forKey: "badge") != 0
                            {
                                (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                            }
                            else
                            {
                                (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                            }
                            
                            self.repositionBadge(tabIndex: 3)
                            
                           
                            
                            self.HUD?.hide(true)
                            
                            self.tblCart.isHidden = false
                            self.viewBottom.isHidden = false
                            
                            self.viewNoProducts.isHidden = true
                            
                            self.tblCart.reloadData()
                        }
                        
                        self.calculateTotal()
                        
                        self.lblEstimateDelivery.text = "\((self.appDel.mapping?.string(forKey: "Delivery"))!) 3-5 \((self.appDel.mapping?.string(forKey: "Days"))!)"
                    }
                    else
                    {
                        UserDefaults.standard.set(nil, forKey: "badge")
                        UserDefaults.standard.synchronize()
                        
                        if UserDefaults.standard.integer(forKey: "badge") != 0
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = String(format: "%d",UserDefaults.standard.integer(forKey: "badge"))
                        }
                        else
                        {
                            (self.tabBarController!.tabBar.items![2]).badgeValue = nil
                        }
                        
                        self.HUD?.hide(true)
                        
                        self.tblCart.isHidden = true
                        self.viewBottom.isHidden = true
                        
                        self.viewNoProducts.isHidden = false
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
