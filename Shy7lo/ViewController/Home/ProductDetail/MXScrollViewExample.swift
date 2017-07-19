// MXScrollViewExample.swift
//
// Copyright (c) 2015 Maxime Epain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import FirebaseAnalytics

class MXScrollViewExample: UIViewController, UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIWebViewDelegate,UIAlertViewDelegate {

    fileprivate var SpanichWhite : UIColor = UIColor(colorLiteralRed: 0.996, green: 0.992, blue: 0.941, alpha: 1) /*#fefdf0*/
    
    //var scrollView: MXScrollView!
    var isFromFavourite:Bool?
    
    var table1: UITableView!
    @IBOutlet weak var scrollView: MXScrollView!
    @IBOutlet weak var viewSize: UIView!
    @IBOutlet weak var clctnSize: UICollectionView!
    
    @IBOutlet weak var addCartCenter: NSLayoutConstraint!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var viewTopMenu: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblDetail: UITableView!
    @IBOutlet weak var btnRemoveSize: UIButton!
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnAddToBag: UIButton!
    var strProductName:String = ""
    var strProductSize:String = ""
    var strProductPrice:String = ""
    var arrProductDetail:NSMutableArray = NSMutableArray()
    var wbViewHeight:NSInteger = 0
    var getWbViewHeight:Bool = false
    var arrSize:NSMutableArray = NSMutableArray()
    
    var dictProductDetail:NSMutableDictionary = NSMutableDictionary()
    
    var sizeOptionID:String = ""
    var sizeOptionValue:String = ""
    
    var strProductSKU:NSString?
    
    @IBOutlet weak var viewSizeBottomSpace: NSLayoutConstraint!
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var HUD : MBProgressHUD?
    
    var isConfigureProduct:Bool = false
    
    @IBOutlet weak var lblSelectSize: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.strProductSKU = "01030100100003"
        
        if self.isFromFavourite == true
        {
            self.btnFavourite.isSelected = true
            
            self.btnFavourite.isUserInteractionEnabled = false
        }
        else
        {
            self.btnFavourite.isSelected = false
            
            self.btnFavourite.isUserInteractionEnabled = true
        }
        
        if isEnglish {
            self.lblUserName.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            
            self.addCartCenter.constant = -58.0
            
            self.viewTopMenu.transform = CGAffineTransform.identity
            self.btnShare.transform = CGAffineTransform.identity
            self.lblUserName.transform = CGAffineTransform.identity
            
            self.lblUserName.textAlignment = .left
            
            self.btnAddToBag.setTitle(appDel.mapping?.string(forKey: "Add to bag"), for: UIControlState.normal)
        }
        else
        {
           self.lblUserName.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
            
            self.addCartCenter.constant = 100.0
            self.viewTopMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnShare.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblUserName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.clctnSize.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblUserName.textAlignment = .right
            
            self.btnAddToBag.setTitle("     \((appDel.mapping?.string(forKey: "Add to bag"))!)", for: UIControlState.normal)
        }
    
        self.lblSelectSize.text = appDel.mapping?.string(forKey: "Select Size")
        
        self.btnRemoveSize.isHidden = true
        
        self.viewSizeBottomSpace.constant = -400
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.clctnSize.register(UINib(nibName: "CollectionViewSizeCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewSizeCell")
        
        if isEnglish
        {
            self.btnAddToBag.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: 15.0)
        }
        else
        {
            self.btnAddToBag.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: 15.0)
        }
        
       
        
        self.getSingleProduct()
        
        scrollView.isScrollEnabled = true
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        FIRAnalytics.logEvent(withName: "Product_Details", parameters: ["name":"Product_Details"])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        
    }
    
    //MARK:- Private methods
    func repositionBadge(tabIndex: Int){
        
        for badgeView in self.tabBarController!.tabBar.subviews[tabIndex].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
            }
        }
    }
    func showAlert()
    {
        let alert:UIAlertView = UIAlertView(title: (appDel.mapping?.string(forKey: "Awesome choice"))!, message: (appDel.mapping?.string(forKey: "What do you want to do now ?"))!, delegate: self, cancelButtonTitle: nil, otherButtonTitles: (appDel.mapping?.string(forKey: "Continue shopping"))!, (appDel.mapping?.string(forKey: "View cart"))!)
        alert.delegate = self
        alert.show()
        self.HUD?.hide(true)
    }
    func stopLoader()
    {
        self.HUD?.hide(true)
    }
    func getSingleProduct()
    {
        HUD?.show(true)
        
        let strUrl1:String = String(format:"\(API_URL)/v1/catalog/product/detail")
        
       //  let strUrl1:String = String(format:"https://api.shylabs.com/v1/catalog/product/detail")
        
        var request = URLRequest(url: URL(string: strUrl1)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")

        let parameter:NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(self.strProductSKU, forKey: "sku")
    
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
                        if httpStatus.statusCode != 400
                        {
                            self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Something went wrong"))!)
                            self.HUD?.hide(true)
                            return
                        }
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
                                self.dictProductDetail = jsonResult as! NSMutableDictionary
                                
                                self.lblUserName.text = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "brand_name") as? String
                                
                                let dictTitle:NSMutableDictionary = NSMutableDictionary()
                                
                                dictTitle.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "name"), forKey: "title")
                                
                                if let specialPrice = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_price") as? String
                                {
                                    
                                    let dateFormatter:DateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    if let fromdate = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_from_date") as? String
                                    {
                                        if let todate = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_to_date") as? String
                                        {
                                            let dateFrom = dateFormatter.date(from: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_from_date") as! String)!
                                            // Get a later date (after a couple of milliseconds)
                                            let dateTo = dateFormatter.date(from: (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_to_date") as! String)!
                                            
                                            if NSDate().isBetweeen(date: dateFrom as NSDate, andDate: dateTo as NSDate) == true
                                            {
                                                dictTitle.setValue("1", forKey: "isSpecialPrice")
                                                
                                                dictTitle.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "special_price"), forKey: "special_price")
                                            }
                                            else
                                            {
                                                dictTitle.setValue("0", forKey: "isSpecialPrice")
                                            }
                                            
                                        }
                                        else
                                        {
                                            dictTitle.setValue("0", forKey: "isSpecialPrice")
                                        }
                                }
                                else
                                {
                                    dictTitle.setValue("0", forKey: "isSpecialPrice")
                                }
  
                                }
                                else{
                                    dictTitle.setValue("0", forKey: "isSpecialPrice")
                                    
                                }
                                
                                dictTitle.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "price"), forKey: "price")
                                
                                dictTitle.setValue(self.appDel.mapping?.string(forKey: "Size"), forKey: "sizeValue")
                                
                                var arrOption:NSMutableArray = NSMutableArray()
                                
                                if let dict = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "configurable_attributes") as? NSMutableDictionary
                                {
                                    arrOption = ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "configurable_attributes") as! NSMutableDictionary).value(forKey: "attribute_details") as! NSMutableArray
                                }
                                
                                
                                
                                self.appDel.arrCurrentProductImages = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "media_gallery") as! NSMutableArray
                                
                                if (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "type_id") as! String == "configurable"
                                {
                                    self.isConfigureProduct = true
                                }
                                
                                /**   setup view  **/
                                
                                // Parallax Header
                                
                                self.scrollView.parallaxHeader.view = Bundle.main.loadNibNamed("StarshipHeader", owner: self, options: nil)?.first as? UIView // You can set the parallax header view from a nib.
                                if UIScreen.main.bounds.size.width == 320
                                {
                                    self.scrollView.parallaxHeader.height = 350
                                }
                                else if UIScreen.main.bounds.size.width == 375
                                {
                                    self.scrollView.parallaxHeader.height = 500
                                }
                                else
                                {
                                    self.scrollView.parallaxHeader.height = 500
                                }
                                
                                self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
                                self.scrollView.parallaxHeader.minimumHeight = 0
                                
                                
                                self.table1 = UITableView()
                                self.table1.dataSource = self;
                                self.table1.delegate = self
                                self.table1.backgroundColor = UIColor.clear
                                self.table1.separatorStyle = .none
                                self.table1.allowsSelection = false
                                self.scrollView.addSubview(self.table1)
                                
                                var frame = self.view.frame
                                
                                // scrollView.frame = frame
                                // scrollView.contentSize = frame.size
                                
                                frame.size.width /= 1
                                frame.size.height -= (self.scrollView.parallaxHeader.minimumHeight)
                                print(frame)
                                self.table1.frame = frame
                                
                                self.table1.register(UINib(nibName: "cellProductTitle", bundle: nil), forCellReuseIdentifier: "cellProductTitle")
                                self.table1.register(UINib(nibName: "cellProductDetail", bundle: nil), forCellReuseIdentifier: "cellProductDetail")
                                self.table1.register(UINib(nibName: "cellProductInfo", bundle: nil), forCellReuseIdentifier: "cellProductInfo")
                                self.table1.register(UINib(nibName: "addToBag", bundle: nil), forCellReuseIdentifier: "addToBag")
                                self.table1.register(UINib(nibName: "cellProductParameter", bundle: nil), forCellReuseIdentifier: "cellProductParameter")
                                self.table1.register(UINib(nibName: "cellProductTitleWithoutColor", bundle: nil), forCellReuseIdentifier: "cellProductTitleWithoutColor")
                                self.table1.register(UINib(nibName: "cellImage", bundle: nil), forCellReuseIdentifier: "cellImage")
                                
                                /**              **/
                                
                                for items in arrOption {
                                    
                                    let dictAtt:NSMutableDictionary = items as! NSMutableDictionary
                                    
                                    /*if (dictAtt.value(forKey: "attribute_name") as! String).lowercased().contains("color") == true
                                    {
                                        dictTitle.setValue(dictAtt.value(forKey: "option"), forKey: "color")
                                        dictTitle.setValue(dictAtt.value(forKey: "attribute_id"), forKey: "color_attribute_id")
                                    }
                                    if (dictAtt.value(forKey: "attribute_name") as! String).lowercased().contains("size") == true
                                    {
                                        dictTitle.setValue(dictAtt.value(forKey: "option"), forKey: "size")
                                        dictTitle.setValue(dictAtt.value(forKey: "attribute_id"), forKey: "size_attribute_id")
                                    }*/
                                    
                                    dictTitle.setValue(dictAtt.value(forKey: "option"), forKey: "size")
                                    dictTitle.setValue(dictAtt.value(forKey: "attribute_id"), forKey: "size_attribute_id")
                                    
                                }
                                
                                dictTitle.setValue("title", forKey: "value")
                                
                                self.arrProductDetail.add(dictTitle)
                                
                                let dictImage:NSMutableDictionary = NSMutableDictionary()
                                dictImage.setValue("image", forKey: "value")
                                self.arrProductDetail.add(dictImage)
                                
                                let dictDescription:NSMutableDictionary = NSMutableDictionary()
                                dictDescription.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "description"), forKey: "description")
                                dictDescription.setValue("description", forKey: "value")
                                self.arrProductDetail.add(dictDescription)
                                
                                var firstAdditionl:Bool = false
                                
                                for items in arrOption {
                                    
                                    let dictAtt:NSMutableDictionary = items as! NSMutableDictionary
                                    
                                    self.arrSize = dictAtt.value(forKey: "option") as! NSMutableArray
                                    self.clctnSize.reloadData()
                                    
                                    /*if (dictAtt.value(forKey: "attribute_name") as! String).lowercased().contains("color") == true                      {
                                        
                                    }
                                    else if (dictAtt.value(forKey: "attribute_name") as! String).lowercased().contains("size") == true
                                    {
                                        self.arrSize = dictAtt.value(forKey: "option") as! NSMutableArray
                                        self.clctnSize.reloadData()
                                    }
                                    else
                                    {
                                        /*if firstAdditionl == false
                                         {
                                         firstAdditionl = true
                                         
                                         let dictDescription:NSMutableDictionary = NSMutableDictionary()
                                         dictDescription.setValue(dictAtt.value(forKey: "attribute_code"), forKey: "title")
                                         dictDescription.setValue(dictAtt.value(forKey: "value"), forKey: "info")
                                         dictDescription.setValue("firstAdditional", forKey: "value")
                                         self.arrProductDetail.add(dictDescription)
                                         }
                                         else
                                         {
                                         let dictDescription:NSMutableDictionary = NSMutableDictionary()
                                         dictDescription.setValue(dictAtt.value(forKey: "attribute_code"), forKey: "title")
                                         dictDescription.setValue(dictAtt.value(forKey: "value"), forKey: "info")
                                         dictDescription.setValue("dictColor", forKey: "value")
                                         self.arrProductDetail.add(dictDescription)
                                         }*/
                                        
                                    }*/
                                    
                                    
                                }
                                
                                let dictSKU:NSMutableDictionary = NSMutableDictionary()
                                dictSKU.setValue(self.appDel.mapping?.string(forKey: "SKU"), forKey: "title")
                                dictSKU.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "sku"), forKey: "info")
                                dictSKU.setValue("firstAdditional", forKey: "value")
                                self.arrProductDetail.add(dictSKU)
                                
                                if let name = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "perfume_size") as? String
                                {
                                    let dictPerfume:NSMutableDictionary = NSMutableDictionary()
                                    
                                    dictPerfume.setValue(self.appDel.mapping?.string(forKey: "Perfume Size"), forKey: "title")
                                    dictPerfume.setValue(String(format:"%@",(jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "perfume_size") as! String), forKey: "info")
                                    dictPerfume.setValue("Additional", forKey: "value")
                                    self.arrProductDetail.add(dictPerfume)
                                }
                                
                                
                                if let color = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "color_") as? String
                                {
                                    let dictColor1:NSMutableDictionary = NSMutableDictionary()
                                    dictColor1.setValue(self.appDel.mapping?.string(forKey: "Color").uppercased(), forKey: "title")
                                    dictColor1.setValue((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "color_"), forKey: "info")
                                    dictColor1.setValue("Additional", forKey: "value")
                                    self.arrProductDetail.add(dictColor1)
                                }
                                
                                if let name = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "name") as? String
                                {
                                    let dictName:NSMutableDictionary = NSMutableDictionary()
                                    dictName.setValue(self.appDel.mapping?.string(forKey: "Name"), forKey: "title")
                                    dictName.setValue(((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "name") as! String).uppercased(), forKey: "info")
                                    dictName.setValue("Additional", forKey: "value")
                                    self.arrProductDetail.add(dictName)
                                }
                                
                                print(self.arrProductDetail)
                                
                                self.table1.reloadData()
                                
                                 self.HUD?.hide(true)
                                
                            }
                            else
                            {
                                self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Something went wrong"))!)
                                self.HUD?.hide(true)
                                
                            }
                            
                            // use jsonData
                        } catch {
                            // report error
                        }
                        
                }
                
                
                // use jsonData
            } catch let err{
                // report error
                self.HUD?.hide(true)
                print(err)
            }
            
        }
        task.resume()

    }
    
    //MARK:- Action zones
    
    @IBAction func btnAddToBagAction(_ sender: AnyObject)
    {
       
        if self.isConfigureProduct == true {
            
            if self.sizeOptionValue == "" {
                
                 self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "Please select size"))!)
                
                 return
                
            }
            
            HUD?.show(true)
            
            var str1:String = ""
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                str1 = String(format:"\(API_URL)/v1/checkout/cart/add-itemConfigure")
            }
            else
            {
                str1 = String(format: "\(API_URL)/v1/checkout/cart/guest-carts/add-item-configure")
            }
            
            var request = URLRequest(url: URL(string: str1)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            }
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(self.strProductSKU, forKey: "sku")
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String == ""
            {
                parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            }
            
            parameter.setValue("1", forKey: "qty")
            parameter.setValue(self.strProductName, forKey: "product_name")
            parameter.setValue(self.strProductPrice, forKey: "price")
            parameter.setValue("configurable", forKey: "product_type")
            
            let arrConfigue:NSMutableArray = NSMutableArray()
            
            if self.sizeOptionID != ""
            {
                let dictSize:NSMutableDictionary = NSMutableDictionary()
                dictSize.setValue(self.sizeOptionID, forKey: "option_id")
                dictSize.setValue(self.sizeOptionValue, forKey: "option_value")
                
                arrConfigue.add(dictSize)
            }
            
            parameter.setValue(arrConfigue, forKey: "configurable_item_options")
            
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
                            if httpStatus.statusCode != 400
                            {
                                self.appDel.showAlert(title:String(format:"Error : %d",httpStatus.statusCode))
                                self.HUD?.hide(true)
                                return
                            }
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
                                var currentBadge:NSInteger = UserDefaults.standard.integer(forKey: "badge")
                                
                                currentBadge = currentBadge + 1
                                
                                UserDefaults.standard.set(currentBadge, forKey: "badge")
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
                                
                                FIRAnalytics.logEvent(withName: "Add_to_cart", parameters: ["name":"Add_to_cart"])
                                
                                self.performSelector(onMainThread: #selector(self.showAlert), with: nil, waitUntilDone: true)
                            }
                            else
                            {
                                self.appDel.showAlert(title: jsonResult.value(forKey: "message") as! String)
                                self.HUD?.hide(true)
                                
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
            self.HUD?.show(true)
            
            var str1:String = ""
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                str1 = String(format:"\(API_URL)/v1/checkout/cart/add-item")
            }
            else
            {
                str1 = String(format: "\(API_URL)/v1/checkout/cart/guest-carts/add-item")
            }
            
            var request = URLRequest(url: URL(string: str1)!)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
            request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String != "" {
                
                request.addValue("Bearer \(UserDefaults.standard.value(forKey: "user_authorization") as! String)", forHTTPHeaderField: "Authorization")
            }
            
            let parameter:NSMutableDictionary = NSMutableDictionary()
            parameter.setValue(self.strProductSKU, forKey: "sku")
            
            if UserDefaults.standard.value(forKey: "user_authorization") as! String == ""
            {
                parameter.setValue(UserDefaults.standard.value(forKey: "guest_cart_id") as! String, forKey: "cart_id")
            }
            
            parameter.setValue("1", forKey: "qty")
            parameter.setValue(self.strProductName, forKey: "product_name")
            parameter.setValue(self.strProductPrice, forKey: "price")
            parameter.setValue("simple", forKey: "product_type")
            
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
                            if httpStatus.statusCode != 400
                            {
                                self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "This product is out of stock."))!)
                                self.HUD?.hide(true)
                                return
                            }
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
                                
                                 self.HUD?.hide(true)
                                
                                if flag == "1"
                                {
                                    self.performSelector(onMainThread: #selector(self.showAlert), with: nil, waitUntilDone: true)
                                }
                                else
                                {
                                    self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "This product is out of stock."))!)
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
        
        
        
    }
    @IBAction func btnCloseAction(_ sender: AnyObject)
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
    
    @IBAction func btnShareAction(_ sender: AnyObject)
    {
        
        let shareText = (self.dictProductDetail.value(forKey: "data") as! NSMutableDictionary).value(forKey: "name") as! String
        
        var strURL:String = ""
        
        if self.appDel.arrCurrentProductImages.count > 0
        {
            let dict:NSMutableDictionary = self.appDel.arrCurrentProductImages.object(at: 0) as! NSMutableDictionary
            
            strURL = String(format: "%@",dict.value(forKey: "image") as! String)
        }
        
        if let url = (self.dictProductDetail.value(forKey: "data") as! NSMutableDictionary).value(forKey: "url_path") as? String
        {
            strURL = String(format:"https://shy7lo.com/%@",(self.dictProductDetail.value(forKey: "data") as! NSMutableDictionary).value(forKey: "url_path") as! String)
        }
        else
        {
            strURL = String(format:"https://shy7lo.com/%@",(self.dictProductDetail.value(forKey: "data") as! NSMutableDictionary).value(forKey: "url_key") as! String)
        }
        
        let url:URL = URL(string: strURL)!
        
        let vc = UIActivityViewController(activityItems: [shareText, url], applicationActivities: [])
        present(vc, animated: true)
        
    }
    
    @IBAction func btnFavouriteAction(_ sender: AnyObject)
    {
        
        
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
            parameter.setValue(self.strProductSKU, forKey: "sku")
            
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
    @IBAction func btnSizeAction(_ sender: AnyObject)
    {
        self.btnRemoveSize.isHidden = false
        
        UIView.animate(withDuration: 1.0) {
            
            self.viewSizeBottomSpace.constant = 0
        }
    }
    
    @IBAction func btnRemoveSizeAction(_ sender: AnyObject)
    {
        self.btnRemoveSize.isHidden = true
        
        UIView.animate(withDuration: 1.0) {
            
            self.viewSizeBottomSpace.constant = -400
        }
    }
    //MARK:- Collectionview delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrSize.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewSizeCell", for: indexPath) as! CollectionViewSizeCell
        
        cell.setUpUI()
        
        let dict:NSMutableDictionary = self.arrSize.object(at: indexPath.row) as! NSMutableDictionary
        
        cell.viewSize.layer.borderColor = UIColor.black.cgColor
        cell.viewSize.layer.borderWidth = 1.0
        cell.viewSize.clipsToBounds = true
        
        cell.lblSize.text = dict.value(forKey: "default_label") as? String
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
         return CGSize(width: 80, height: 40)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dict:NSMutableDictionary = self.arrSize.object(at: indexPath.row) as! NSMutableDictionary
        
        let dictFirst:NSMutableDictionary = self.arrProductDetail.object(at: 0) as! NSMutableDictionary
        
        dictFirst.setValue(dict.value(forKey: "default_label") as? String, forKey: "sizeValue")
        
        self.sizeOptionValue = dict.value(forKey: "value_index") as! String
        self.sizeOptionID = dictFirst.value(forKey: "size_attribute_id") as! String
        
        print(dictFirst)
        
        table1.reloadData()
        
        self.btnRemoveSize.isHidden = true
        
        UIView.animate(withDuration: 1.0) {
            
            self.viewSizeBottomSpace.constant = -400
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == self.arrProductDetail.count
        {
            return 200
        }
        
        let dict:NSMutableDictionary = self.arrProductDetail.object(at: indexPath.row) as! NSMutableDictionary
        
        if dict.value(forKey: "value") as! String == "image"
        {
            if UIScreen.main.bounds.size.width == 375 {
                return 180
            }
            else if UIScreen.main.bounds.size.width > 420
            {
                return 340
            }
        }
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == self.arrProductDetail.count
        {
            return 200
        }
        let dict:NSMutableDictionary = self.arrProductDetail.object(at: indexPath.row) as! NSMutableDictionary
        
        if dict.value(forKey: "value") as! String == "image"
        {
            if UIScreen.main.bounds.size.width == 375 {
                return 180
            }
            else if UIScreen.main.bounds.size.width > 420
            {
                return 340
            }
        }
        
        return UITableViewAutomaticDimension;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if UIScreen.main.bounds.size.width == 320
        {
            return self.arrProductDetail.count + 1
        }
        
        return self.arrProductDetail.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row == self.arrProductDetail.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addToBag", for: indexPath) as! addToBag
            
            //dummy
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
        }
        else
        {
            let dict:NSMutableDictionary = self.arrProductDetail.object(at: indexPath.row) as! NSMutableDictionary
            
            if dict.value(forKey: "value") as! String == "title" {
                
                if dict.value(forKey: "color") as? NSMutableArray == nil {
                    
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductTitleWithoutColor", for: indexPath) as! cellProductTitleWithoutColor
                    
                    cell.setUpUI()
                    
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    
                    print(Float(dict.value(forKey: "price") as! String)!)
                    print((UserDefaults.standard.value(forKey: "exchangeRates") as! Float))
                    
                    
                    if dict.value(forKey: "isSpecialPrice") as? String == "1"
                    {
                        cell.lblOldPrice.text = String(format:"%0.2f %@",Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "special_price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.red
                        
                        cell.lblOldPrice.textColor = UIColor.lightGray
                        
                        cell.lblPriceSeperator.isHidden = false
                        
                        cell.lblOldPrice.isHidden = false
                        
                        cell.heightOldPrice.constant = 31
                        
                        cell.topSpecialPrice.constant = 40
                    }
                    else
                    {
                        cell.lblPrice.text = String(format:"%0.2f %@",Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.black
                        
                        cell.lblPriceSeperator.isHidden = true
                        
                        cell.lblOldPrice.isHidden = true
                        
                        cell.heightOldPrice.constant = 0
                        
                        cell.topSpecialPrice.constant = 8
                    }

                    cell.lblName.text = dict.value(forKey: "title") as? String
                    cell.lblStaticSize.text = dict.value(forKey: "sizeValue") as? String
                    
                    if isEnglish {
                        
                        cell.lblPrice.font = UIFont(name: appDel.strFont, size: 17.0)
                        cell.lblName.font = UIFont(name: appDel.strFont, size: 17.0)
                        cell.lblStaticSize.font = UIFont(name: appDel.strFont, size: 17.0)
                    }
                    else
                    {
                        cell.lblPrice.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                        cell.lblName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                        cell.lblStaticSize.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                    }
                    
                    self.strProductSize = (dict.value(forKey: "sizeValue") as? String)!
                    self.strProductName = (dict.value(forKey: "title") as? String)!
                    self.strProductPrice = String(format:"%0.2f",Float(dict.value(forKey: "price") as! String)!)
                    
                    cell.btnStaticSize.addTarget(self, action: #selector(btnSizeAction(_:)), for: UIControlEvents.touchUpInside)
                    
                    if dict.value(forKey: "size") as? NSMutableArray == nil
                    {
                        cell.lblStaticSize.isHidden = true
                        cell.btnStaticSize.isHidden = true
                    }
                    else
                    {
                        cell.lblStaticSize.isHidden = false
                        cell.btnStaticSize.isHidden = false
                    }
                    
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    cell.contentView.layoutIfNeeded()
                    return cell
                    
                    
                }
                else
                {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductTitle", for: indexPath) as! cellProductTitle
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    print(dict)
                    
                    cell.setUpUI()
                    
                    if dict.value(forKey: "isSpecialPrice") as? String == "1"
                    {
                        cell.lblOldPrice.text = String(format:"%0.2f %@",Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.text = String(format: "%0.2f %@",  Float(dict.value(forKey: "special_price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.red
                        
                        cell.lblPriceSeperator.isHidden = false
                        
                        cell.lblOldPrice.isHidden = false
                        
                        cell.heightOldPrice.constant = 31
                        
                        cell.topSpecialPrice.constant = 19
                    }
                    else
                    {
                        cell.lblPrice.text = String(format:"%0.2f %@",Float(dict.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                        cell.lblPrice.textColor = UIColor.black
                        
                        cell.lblPriceSeperator.isHidden = true
                        
                        cell.lblOldPrice.isHidden = true
                        
                        cell.heightOldPrice.constant = 0
                        
                        cell.topSpecialPrice.constant = 8
                    }
                    
                    
                    cell.lblName.text = dict.value(forKey: "title") as? String
                    cell.lblStaticSize.text = dict.value(forKey: "sizeValue") as? String
                    
                    cell.lblStaticColor.text = appDel.mapping?.string(forKey: "Color")
                    
                    self.strProductSize = (dict.value(forKey: "sizeValue") as? String)!
                    self.strProductName = (dict.value(forKey: "title") as? String)!
                    self.strProductPrice = String(format:"%0.2f",Float(dict.value(forKey: "price") as! String)!)
                    
                    if dict.value(forKey: "size") as? NSMutableArray == nil
                    {
                        cell.lblStaticSize.isHidden = true
                        cell.btnStaticSize.isHidden = true
                    }
                    else
                    {
                        cell.lblStaticSize.isHidden = false
                        cell.btnStaticSize.isHidden = false
                    }
                    
                    if isEnglish {
                        
                        cell.lblPrice.font = UIFont(name: appDel.strFont, size: 17.0)
                        cell.lblName.font = UIFont(name: appDel.strFont, size: 17.0)
                        cell.lblStaticSize.font = UIFont(name: appDel.strFont, size: 17.0)
                    }
                    else
                    {
                        cell.lblPrice.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                        cell.lblName.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                        cell.lblStaticSize.font = UIFont(name: appDel.strFontKufi, size: 15.0)
                    }
                    
                    
                    cell.btnStaticSize.addTarget(self, action: #selector(btnSizeAction(_:)), for: UIControlEvents.touchUpInside)
                    
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    cell.contentView.layoutIfNeeded()
                    return cell
                    
                }
                
                
            }
            
            if dict.value(forKey: "value") as! String == "image" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath) as! cellImage
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                if isEnglish
                {
                    cell.imgFeatures.image = UIImage(named: "detail_feature.png")
                }
                else
                {
                    cell.imgFeatures.image = UIImage(named: "detail_feature_ar.png")
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.contentView.layoutIfNeeded()
                return cell
                
            }
            if dict.value(forKey: "value") as! String == "description" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductDetail", for: indexPath) as! cellProductDetail
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.lblProductDetail.text = dict.value(forKey: "description") as? String
                print(appDel.strFont)
                
                print(cell.wbView)
                var htmlString: String = ""
                if isEnglish {
                    
                    htmlString = "<font face='\(appDel.strFont)' size='3'>\((dict.value(forKey: "description") as! String))"
                    
                    cell.lblDetailStatic.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
                    
                    cell.lblDetailStatic.textAlignment = .left
                }
                else
                {
                    cell.lblDetailStatic.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
                    
                    htmlString = "<font face='\(appDel.strFontKufi)' size='3'>\((dict.value(forKey: "description") as! String))"
                    
                    cell.lblDetailStatic.textAlignment = .right
                }
                
                cell.lblDetailStatic.text = appDel.mapping?.string(forKey: "Details")
                
                cell.wbView.loadHTMLString(htmlString, baseURL: nil)
                cell.wbView.backgroundColor = UIColor.clear
                cell.wbView.isOpaque = false
                cell.wbView.delegate = self
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.heightWbVIew.constant = CGFloat(self.wbViewHeight)
                cell.contentView.layoutIfNeeded()
                return cell
            }
            
            if dict.value(forKey: "value") as! String == "firstAdditional" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductInfo", for: indexPath) as! cellProductInfo
                
                cell.setUpUI()
                
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.lblTitle.text = dict.value(forKey: "title") as? String
                cell.lblValue.text = dict.value(forKey: "info") as? String
                
                if isEnglish {
                    
                    cell.lblAdditionalInfo.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
                    cell.lblTitle.font = UIFont(name: appDel.strFont, size: 17.0)
                    cell.lblValue.font = UIFont(name: appDel.strFont, size: 17.0)
                }
                else
                {
                    cell.lblAdditionalInfo.font = UIFont(name: appDel.strFontKufi_Bold, size: 16.0)
                    cell.lblTitle.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                    cell.lblValue.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                }
                
                cell.lblAdditionalInfo.text = appDel.mapping?.string(forKey: "Addition information")

                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.contentView.layoutIfNeeded()
                return cell
                
            }
            if dict.value(forKey: "value") as! String == "Additional" {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductParameter", for: indexPath) as! cellProductParameter
                
                cell.setUpUI()
                
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.lblTitle.text = dict.value(forKey: "title") as? String
                cell.lblValue.text = dict.value(forKey: "info") as? String
                
                if isEnglish {
                    
                    cell.lblTitle.font = UIFont(name: appDel.strFont, size: 17.0)
                    cell.lblValue.font = UIFont(name: appDel.strFont, size: 17.0)
                }
                else
                {
                    cell.lblTitle.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                    cell.lblValue.font = UIFont(name: appDel.strFontKufi, size: 16.0)
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.contentView.layoutIfNeeded()
                return cell
                
            }
        }

       /* if indexPath.row == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductInfo", for: indexPath) as! cellProductInfo
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.contentView.layoutIfNeeded()
            return cell
        } */
    
        
        return UITableViewCell()
    }
    //MARK:- Webview delegate method
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        if getWbViewHeight == false
        {
            getWbViewHeight = true
            webView.frame.size.height = 1
            webView.frame.size = webView.sizeThatFits(CGSize.zero)
            print(webView.frame.size.height)
            self.wbViewHeight = NSInteger(webView.frame.size.height)
            self.table1.reloadData()

        }
        
    }
    
    //MARK:- Alertview delegate method
    
    public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        print(buttonIndex)
        
        if buttonIndex == 0 {
            
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
        else
        {
            self.tabBarController?.selectedIndex = 2
            
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
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == false{
            
            print("end")
            
            scrollView.isScrollEnabled = true
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableScrl"), object: nil)

        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        //print(scrollView.parallaxHeader.progress)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        scrollView.isScrollEnabled = true
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableScrl"), object: nil)
        
        //fire post notification and enable scroll view ok strship header
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        print(scrollView.parallaxHeader.progress)
        
        if scrollView.parallaxHeader.progress < 100  {
            
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableScrl"), object: nil)
            
        }
        else
        {
            //self.automaticallyAdjustsScrollViewInsets = false
        }
       
    }
}
extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
extension String {
    var utf8Data: Data? {
        return data(using: .utf8)
    }
}
