//
//  CategoryListViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 07/12/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class CategoryListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    
    @IBOutlet weak var clctnBottom: NSLayoutConstraint!
    @IBOutlet weak var heightSort: NSLayoutConstraint!
    
    /** ------- **/
    
    @IBOutlet weak var tblSort: UITableView!
    
    @IBOutlet weak var viewNewFilter: UIView!
    
    @IBOutlet weak var viewFIlter: UIView!
    
    /** -------- **/
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewSubMenu: UIView!
    @IBOutlet weak var viewFilterTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSpaceFilter: NSLayoutConstraint!
    @IBOutlet weak var topSpaceFilter: NSLayoutConstraint!
    
    var smallLayout:AFCollectionViewFlowSmallLayout!
    var largeLayout:AFCollectionViewFlowLargeLayout!
    var HUD : MBProgressHUD?
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isFromCategorySelection:Bool?
    var strSelectedCategoryId:String?
    
    var arrProducts:NSMutableArray = NSMutableArray()
    var arrSortParameter:NSMutableArray = NSMutableArray()
    var arrFilter:NSMutableArray = NSMutableArray()
    
    var bodyParameter:NSMutableDictionary = NSMutableDictionary()
    var dictFilterData:NSMutableDictionary = NSMutableDictionary()
    
    var dictBanner:NSMutableDictionary = NSMutableDictionary()
    var isShowList:Bool = false
    var currentPage:NSInteger = 1
    var totalRecords:NSInteger = 0
    
    var sortIndex:NSInteger = 1000
    
    @IBOutlet var btnList:UIButton!
    @IBOutlet var btnGrid:UIButton!
    
    @IBOutlet var collectionPhotos: UICollectionView!
    
    @IBOutlet weak var lblLoadingMore: UILabel!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var lblNoMoreData: UILabel!
    @IBOutlet var activitySpinner: UIActivityIndicatorView!
    var isLoadingEnabled:Bool = false
    //MARK:- View Life cycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.set(false, forKey: "isCategory")
        UserDefaults.standard.synchronize()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaults.standard.set(true, forKey: "isCategory")
        UserDefaults.standard.synchronize()
        
        self.viewFIlter.isHidden = true
        
        if isEnglish {
            
            self.imgLogo.image = UIImage(named: "ic_top_logo.png")
            
            self.viewSubMenu.transform = CGAffineTransform.identity
            self.viewMenu.transform = CGAffineTransform.identity
            
            self.imgLogo.transform = CGAffineTransform.identity
            self.btnNew.transform = CGAffineTransform.identity
            
        }
        else
        {
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            
            self.viewMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewSubMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.imgLogo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnNew.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        }
        
        self.getProductsOfSelectedCategory(needtoShow: true)
        self.getFilterData(needtoShow: false)
        
        self.tblSort.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool)
    {
        FIRAnalytics.logEvent(withName: "Product_list", parameters: ["name":"Product_list"])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel.isListVewAppear = false
        
        self.activitySpinner.startAnimating()
        self.activitySpinner.isHidden = false
        
        HUD = MBProgressHUD(view: self.view)
        
        self.view.addSubview(HUD!)
        
        HUD?.labelText="Loading.."
        
        HUD?.color=UIColor(red: 225.0/255.0, green: 60.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        
        self.btnGrid.isSelected = true
        self.btnList.isSelected = false
        
        self.smallLayout = AFCollectionViewFlowSmallLayout()
        self.largeLayout = AFCollectionViewFlowLargeLayout()
        
        self.collectionPhotos.collectionViewLayout = self.smallLayout
        
        self.viewFIlter.isHidden = true
        
        self.collectionPhotos.register(UINib(nibName: "cellPhoto", bundle: nil), forCellWithReuseIdentifier: "cellPhoto")
        self.collectionPhotos.register(UINib(nibName: "cellPhotoList", bundle: nil), forCellWithReuseIdentifier: "cellPhotoList")
        
        self.tblSort.register(UINib(nibName: "cellSortParameter", bundle: nil), forCellReuseIdentifier: "cellSortParameter")
        
        self.viewFilterTopSpace.constant = UIScreen.main.bounds.size.height
        
        if self.isFromCategorySelection == true
        {
            bodyParameter = NSMutableDictionary()
            dictFilterData = NSMutableDictionary()
            
            bodyParameter.setValue("", forKey: "sortby")
            bodyParameter.setValue("", forKey: "direction")
            bodyParameter.setValue(self.strSelectedCategoryId, forKey: "category_id")
            bodyParameter.setValue(dictFilterData, forKey: "filterdata")
            bodyParameter.setValue(self.currentPage, forKey: "page_number")

        }
        else
        {
            print(self.dictBanner)
            
            
            /*let jsonText = self.dictBanner.value(forKey: "search_criteria") as! String
            var dictonary:NSDictionary?
            
            if let data = jsonText.data(using: String.Encoding.utf8) {
                
                do {
                    dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                    if let myDictionary = dictonary
                    {
                        let dict:NSDictionary = myDictionary
                        
             
                    }
                } catch let error as NSError {
                    print(error)
                }
            }*/
            
            
            self.strSelectedCategoryId = self.dictBanner.value(forKey: "category_id") as? String
            
            self.dictFilterData = NSMutableDictionary(dictionary: self.dictBanner.value(forKey: "filterdata") as! NSDictionary)
            
            /*self.dictBanner.setValue("price", forKey: "sortby")
            self.dictBanner.setValue("ASC", forKey: "direction")*/
            
            print(self.dictBanner)
            
            self.bodyParameter = self.dictBanner
            
            self.bodyParameter.setValue(self.currentPage, forKey: "page_number")
            
            self.isFromCategorySelection = true
            
            print(bodyParameter)

        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Private method
    
    func convertToDictionary(text: String) -> [String:Any]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                print(json ?? "")
                
                return json
            } catch {
                print("Something went wrong")
            }
        }
        
        return nil
    }
    func getProductsOfSelectedCategory(needtoShow:Bool)
    {
        if needtoShow == true {
            HUD?.show(true)
        }
        
         //let str1:String = String(format: "\(API_URL)/v1/customer/productlist/%@",self.strSelectedCategoryId!)
        
        let str1:String = String(format: "\(API_URL)/v1/catalog/products/listing")
        
        var request = URLRequest(url: URL(string: str1)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        print(bodyParameter)
        /*let dictSend:NSMutableDictionary = NSMutableDictionary()
         dictSend.setValue(parameter, forKey: "cartItem")*/
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: bodyParameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.HUD?.hide(true)
                self.clctnBottom.constant = 49
                self.isLoadingEnabled = false
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        self.clctnBottom.constant = 49
                        self.isLoadingEnabled = false
                        return
                }
               
                
            }
            do {
                /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
                 
                 print((string!).replacingOccurrences(of: "\"", with: ""))*/
                
                var jsonResult = NSDictionary()
                
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                    
                    DispatchQueue.main.async()
                    {
                        
                        self.HUD?.hide(true)
                        
                        let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                        
                        if flag == "1"
                        {
                            print(jsonResult)
                            
                            self.isLoadingEnabled = false
                            self.clctnBottom.constant = 49
                            
                            if self.currentPage == 1
                            {
                                self.totalRecords = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "totalCount") as! NSInteger
                                
                                self.arrProducts = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "categoryData") as! NSMutableArray
                                
                                if self.arrProducts.count == 0
                                {
                                    self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "No result found"))!)
                                }
                                
                                self.collectionPhotos.reloadData()
                                
                                /*self.arrSortParameter = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "sortingData") as! NSMutableArray
                                
                                if self.arrSortParameter.count < 10
                                {
                                    self.heightSort.constant = CGFloat(Float(self.arrSortParameter.count * 44)) + 44.0
                                }
                                else
                                {
                                    self.heightSort.constant = 396
                                }
                                
                                let dictPrice:NSMutableDictionary = NSMutableDictionary()
                                
                                for i in 0 ..< self.arrSortParameter.count
                                {
                                    let dict:NSMutableDictionary = self.arrSortParameter.object(at: i) as! NSMutableDictionary
                                    
                                    if dict.value(forKey: "code") as! String == "price"
                                    {
                                        dict.setValue("ASC", forKey: "direction")
                                        dict.setValue(self.appDel.mapping?.string(forKey: "Price (Low to High)"), forKey: "label")
                                        
                                      
                                        dictPrice.setValue("price", forKey: "code")
                                        dictPrice.setValue(self.appDel.mapping?.string(forKey: "Price (High to Low)"), forKey: "label")
                                        dictPrice.setValue("DESC", forKey: "direction")
                                        
                                         self.arrSortParameter.insert(dictPrice, at: i + 1)
                                        
                                        break
                                    }
                                }
                                
                                
                                self.arrFilter = NSMutableArray()
                                
                                for i in 0 ..< ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "layeredData") as! NSMutableArray).count
                                {
                                    let dict:NSMutableDictionary = ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "layeredData") as! NSMutableArray).object(at: i) as! NSMutableDictionary
                                    
                                    if (dict.value(forKey: "options") as! NSMutableArray).count > 0
                                    {
                                        self.arrFilter.add(dict)
                                    }
                                }
                                
                                
                                let sortDesc = NSSortDescriptor(key: "label", ascending: true)
                                let sortedArray:NSArray = (self.arrFilter as NSArray).sortedArray(using: [sortDesc]) as NSArray
                                
                                self.arrFilter = NSMutableArray(array: sortedArray)*/

                                
                            }
                            else
                            {
                                let arr:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "categoryData") as! NSMutableArray
                                
                                for item in arr
                                {
                                    let dict = item as! NSMutableDictionary
                                    
                                    self.arrProducts.add(dict)
                                }
                                
                                if self.arrProducts.count == 0
                                {
                                    self.appDel.showAlert(title: (self.appDel.mapping?.string(forKey: "No result found"))!)
                                }

                                
                                self.collectionPhotos.reloadData()
                            }
                            
                            
                            UIView.animate(withDuration: 0.01, animations: {
                                
                                self.viewFilterTopSpace.constant = 101
                                
                                self.view.layoutIfNeeded()
                                
                            }) { (flag:Bool) in
                                
                                self.viewFilterTopSpace.constant = 1000
                            }
                            
                            self.tblSort.reloadData()
                        }
                        else
                        {
                            self.isLoadingEnabled = false
                            self.clctnBottom.constant = 49
                            
                            self.arrProducts = NSMutableArray()
                            self.collectionPhotos.reloadData()
                        }
    
                    }
                    
                    // use jsonData
                } catch {
                    // report error
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
    func getFilterData(needtoShow:Bool)
    {
        
     if needtoShow == true {
         HUD?.show(true)
     }
     
     //let str1:String = String(format: "\(API_URL)/v1/customer/productlist/%@",self.strSelectedCategoryId!)
     
     let str1:String = String(format: "\(API_URL)/v1/catalog/products/filters")
     
     var request = URLRequest(url: URL(string: str1)!)
     request.httpMethod = "POST"
     
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
     request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
     
     print(bodyParameter)
     /*let dictSend:NSMutableDictionary = NSMutableDictionary()
     dictSend.setValue(parameter, forKey: "cartItem")*/
     
     var jsondata2 = Data()
     
     do {
         jsondata2 = try JSONSerialization.data(withJSONObject: bodyParameter, options: JSONSerialization.WritingOptions.prettyPrinted)
         // use jsonData
     } catch {
     // report error
     }
     
     
     request.httpBody = jsondata2
     
     let task = URLSession.shared.dataTask(with: request) { data, response, error in
     guard let data = data, error == nil else {                                                 // check for fundamental networking error
         print("error=\(error)")
         self.HUD?.hide(true)
         self.clctnBottom.constant = 49
         return
     }
     
     if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
             print("statusCode should be 200, but is \(httpStatus.statusCode)")
             print("response = \(response)")
             DispatchQueue.main.async()
             {
             self.HUD?.hide(true)
             self.clctnBottom.constant = 49
             return
     }
     
     
     }
     do {
     /*let string = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
     
     print((string!).replacingOccurrences(of: "\"", with: ""))*/
     
     var jsonResult = NSDictionary()
     
     do
     {
        jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
             print(jsonResult)
     
     DispatchQueue.main.async()
     {
        
         let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
         
         if flag == "1"
         {
             print(jsonResult)
                
             self.arrSortParameter = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "sortingData") as! NSMutableArray
             
             if self.arrSortParameter.count < 10
             {
                 self.heightSort.constant = CGFloat(Float(self.arrSortParameter.count * 44)) + 44.0
             }
             else
             {
                 self.heightSort.constant = 396
             }
             
             let dictPrice:NSMutableDictionary = NSMutableDictionary()
             
             for i in 0 ..< self.arrSortParameter.count
             {
                 let dict:NSMutableDictionary = self.arrSortParameter.object(at: i) as! NSMutableDictionary
                 
                 if dict.value(forKey: "code") as! String == "price"
                 {
                     dict.setValue("ASC", forKey: "direction")
                     dict.setValue(self.appDel.mapping?.string(forKey: "Price (Low to High)"), forKey: "label")
                     
                     
                     dictPrice.setValue("price", forKey: "code")
                     dictPrice.setValue(self.appDel.mapping?.string(forKey: "Price (High to Low)"), forKey: "label")
                     dictPrice.setValue("DESC", forKey: "direction")
                     
                     self.arrSortParameter.insert(dictPrice, at: i + 1)
                     
                     break
                 }
             }
             
             
             self.arrFilter = NSMutableArray()
             
             for i in 0 ..< ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "layeredData") as! NSMutableArray).count
             {
                 let dict:NSMutableDictionary = ((jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "layeredData") as! NSMutableArray).object(at: i) as! NSMutableDictionary
                 
                 if (dict.value(forKey: "options") as! NSMutableArray).count > 0
                 {
                     self.arrFilter.add(dict)
                 }
             }
             
             
             let sortDesc = NSSortDescriptor(key: "label", ascending: true)
             let sortedArray:NSArray = (self.arrFilter as NSArray).sortedArray(using: [sortDesc]) as NSArray
             
             self.arrFilter = NSMutableArray(array: sortedArray)
            
             UIView.animate(withDuration: 0.01, animations: {
             
             self.viewFilterTopSpace.constant = 101
             
             self.view.layoutIfNeeded()
             
             }) { (flag:Bool) in
             
                 self.viewFilterTopSpace.constant = 1000
             }
            
                self.tblSort.reloadData()
             }
             else
             {
                 self.clctnBottom.constant = 49

             }
         
         }
     
     // use jsonData
     } catch {
     // report error
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
    func getProducts()
    {
       /* HUD?.show(true)
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjM3MjVhZTA0MWVjNzNkZDIxMmMwNWUyOTYxNWIzNmFhNzNiNWI4NjVlMTdlYTQxYWZkYmUyZWZmMDRiZTMwNjg0M2FjYjJiZTY3OGQ4ZjAxIn0.eyJhdWQiOiIxIiwianRpIjoiMzcyNWFlMDQxZWM3M2RkMjEyYzA1ZTI5NjE1YjM2YWE3M2I1Yjg2NWUxN2VhNDFhZmRiZTJlZmYwNGJlMzA2ODQzYWNiMmJlNjc4ZDhmMDEiLCJpYXQiOjE0NzI1NDY4OTAsIm5iZiI6MTQ3MjU0Njg5MCwiZXhwIjo0NjI4MjIwNDkwLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Iwrh6o23dnzW8m9moSGODfMFYP44Lx80iSzboI337NK5MaYN0MEzsdyjXSn8WJEdHF9wVWNYBkkGcxgyHv-jv8ORzcaWpFdmrX-miRbMXBJFNtaPu0nIKn89u0EiCVoaLRssP0nXcn4PUdQCnyFexRzqAjV_QThFYGVf67_Cf2YbzdB1o0uFK9lkTzmwEiCgwAh5z_zqXdCBdNHPUZq4nZsHgY44Zl02HiMMdF8jfEIwNmj0O-wM-cO50cAlEId-pDLNfYqKh8y9OB2k3gRTv-l538NAg8QAcMBRhvESi2NPSXSX0EsrXpI8mItJg2piBUt_D_2ZRDcRclgi4iaNzjOAGfjOEj1mUvhI0_2LrAIyNfgYq7bixLrDV6iji8DzkgL6Hy141TntAqedk-_-L1cyp845b7qc-45x5LlGgJlxJX-xFZcGOV0nj02xHL5crBxBTAw8Uvjb0hSI86lQNcpAd8_HSInV61ZzoteeGZuwSoezu4Jb-34uX0FLh_CkMjsSB9xLTttJhvagCaahAEevkl5f1VxxX4ha-KHBWWsVY4j2z8NGP5tqCFMjcJpFk9L7VFaekhSD3HJS_HrIYItsp6z99d1mno6FeWCTyPtdkqtvVXMm6QjLW7EG14HQkLJBJgEk0rzFk2b7HC5TX6VZFoJsk5bbvqig4biKWXw", forHTTPHeaderField: "Authorization")
        
        let strUrl1:String = String(format: "http://mage2.shy7lo.com/index.php/rest/V1/products?%@&searchCriteria[pageSize]=10&searchCriteria[currentPage]=%d",self.dictBanner.value(forKey: "search_criteria") as! String,currentPage)
        
        print(strUrl1)
        
        manager.get(strUrl1, parameters: nil, success: { (operation: AFHTTPRequestOperation?, responseObject: Any?) in
         
            self.HUD?.hide(true)
         
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
         
                print(jsonResult)
         
                self.arrProducts = jsonResult.value(forKey: "items") as! NSMutableArray
         
                self.collectionPhotos.reloadData()
         
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
         
         
        })*/

    }
    
    //MARK:- Action zones
    
    @IBAction func btnFilterBackAction(_ sender: AnyObject)
    {
        UIView.animate(withDuration: 1.0, animations: {
            
            self.viewFilterTopSpace.constant = UIScreen.main.bounds.size.height
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            self.viewFIlter.isHidden = true
        }
        
    }
    
    @IBAction func btnMenuAction(_ sender: AnyObject)
    {
        
    }
    
    @IBAction func btnCartAction(_ sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func btnNewACtion(_ sender: AnyObject)
    {
        self.viewFIlter.isHidden = false
        
        UIView.animate(withDuration: 1, animations: {
            
            self.viewFilterTopSpace.constant = 101
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
           
        }

    }
    @IBAction func btnFilterAction(_ sender: AnyObject)
    {
         let obj:FilterListViewController = FilterListViewController(nibName: "FilterListViewController", bundle: nil)
         obj.arrFilterType = self.arrFilter
         obj.dictCurrentFilter = self.dictFilterData
         obj.objCategory = self
         //self.tabBarController?.present(obj, animated: true, completion: nil)
         self.present(obj, animated: true, completion: nil)
        /*let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        self.navigationController?.pushViewController(obj, animated: false)*/
        
    }
    @IBAction func btnGridAction(_ sender: AnyObject)
    {
        self.isShowList = false
        
        appDel.isListVewAppear = false
        
        self.btnGrid.isSelected = true
        self.btnList.isSelected = false
        
        self.smallLayout.invalidateLayout()
        self.collectionPhotos.setCollectionViewLayout(self.smallLayout, animated: true)
        
        self.collectionPhotos.reloadData()
       // self.perform(#selector(animateCollectionSmall), with: nil, afterDelay: 0.1)
       
    }
    @IBAction func btnListAction(_ sender: AnyObject)
    {
        self.isShowList = true
        
        appDel.isListVewAppear = true
        
        self.btnGrid.isSelected = false
        self.btnList.isSelected = true
        
        self.largeLayout.invalidateLayout()
        self.collectionPhotos.setCollectionViewLayout(self.largeLayout, animated: true)
        
        self.collectionPhotos.reloadData()
        
        //self.perform(#selector(animateCollectionLarge), with: nil, afterDelay: 0.18)
        
    }
    
    @IBAction func btnBackAction(_ sender: AnyObject)
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
    //MARK:- Private method
    
    func animateCollectionSmall()
    {
        print("visible == \(self.collectionPhotos.indexPathsForVisibleItems)")
        self.collectionPhotos.reloadItems(at: self.collectionPhotos.indexPathsForVisibleItems)
        
    }
    func animateCollectionLarge()
    {
        print("visible == \(self.collectionPhotos.indexPathsForVisibleItems)")
        self.collectionPhotos.reloadItems(at: self.collectionPhotos.indexPathsForVisibleItems)
        
        
    }
    
    //MARK:- UIScrollview delegate method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        if self.viewFIlter.isHidden == true {
        
            if (self.arrProducts.count < self.totalRecords) && (self.arrProducts.count%16 == 0) && self.isLoadingEnabled == false{
                
                let bottomEdge: Float = Float(scrollView.contentOffset.y) + Float(scrollView.frame.size.height)
                if bottomEdge + 1 >= Float(scrollView.contentSize.height) {
                    // we are at the end
                    self.currentPage = self.currentPage + 1
                    
                    self.bodyParameter.setValue(self.currentPage, forKey: "page_number")
                    
                    self.clctnBottom.constant = 87
                    
                    self.isLoadingEnabled = true
                    
                    let section: Int = numberOfSections(in: self.collectionPhotos) - 1
                    let item: Int = collectionView(self.collectionPhotos, numberOfItemsInSection: section) - 1
                    let lastIndexPath = IndexPath(item: item, section: section)
                    self.collectionPhotos.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)

                    
                    self.getProductsOfSelectedCategory(needtoShow: false)
                }
                
                
            }
            
        }
        
        
        
        
    }
    
    //MARK:- Tableview delagte methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrSortParameter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSortParameter", for: indexPath) as! cellSortParameter
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.setUpUI()
        
        if indexPath.row == self.sortIndex {
            
            cell.imgCheckMark.isHidden = false
        }
        else
        {
            cell.imgCheckMark.isHidden = true
        }
        
        let dict:NSMutableDictionary = self.arrSortParameter.object(at: indexPath.row) as! NSMutableDictionary
        
        if isEnglish
        {
            cell.lblSortParameter.contentHorizontalAlignment = .left
            
            if dict.value(forKey: "code") as! String == "position" {
                
                cell.lblSortParameter.setTitle("Position", for: UIControlState.normal)
            }
            else
            {
                cell.lblSortParameter.setTitle(dict.value(forKey: "label") as? String, for: UIControlState.normal)
            }
        }
        else
        {
            cell.lblSortParameter.contentHorizontalAlignment = .right
            
            if dict.value(forKey: "code") as! String == "name" {
                
                cell.lblSortParameter.setTitle("اسم المنتج", for: UIControlState.normal)
            }
            else if dict.value(forKey: "code") as! String == "bag_size" {
                
                cell.lblSortParameter.setTitle("فرعية", for: UIControlState.normal)
            }
            else if dict.value(forKey: "code") as! String == "created_at" {
                
                cell.lblSortParameter.setTitle("وصل حديثًا", for: UIControlState.normal)
            }
            else if dict.value(forKey: "code") as! String == "saving" {
                
                cell.lblSortParameter.setTitle("تخفيضات", for: UIControlState.normal)
            }
            else if dict.value(forKey: "code") as! String == "bestsellers" {
                
                cell.lblSortParameter.setTitle("الأفضل مبيعًا", for: UIControlState.normal)
            }
            else if dict.value(forKey: "code") as! String == "most_viewed" {
                
                cell.lblSortParameter.setTitle("الأكثر شهرة", for: UIControlState.normal)
            }
            else
            {
                cell.lblSortParameter.setTitle(dict.value(forKey: "label") as? String, for: UIControlState.normal)
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.viewFIlter.isHidden = true
        
        UIView.animate(withDuration: 1) {
            
            self.viewFilterTopSpace.constant = UIScreen.main.bounds.size.height
            
            self.view.layoutIfNeeded()
        }
        
        self.bodyParameter.setValue((self.arrSortParameter.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "code") as! String, forKey: "sortby")
        
        self.currentPage = 1
        
        self.bodyParameter.setValue(self.currentPage, forKey: "page_number")
        
        if (self.arrSortParameter.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "code") as! String == "price" {
            
            self.bodyParameter.setValue((self.arrSortParameter.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "direction") as! String, forKey: "direction")
        }
        else
        {
             self.bodyParameter.setValue("", forKey: "direction")
        }
        
        self.sortIndex = indexPath.row
        
        print(self.bodyParameter)
        
        self.getProductsOfSelectedCategory(needtoShow: true)
    }
    
    //MARK:- CollectionView delegate method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath as IndexPath) as! cellPhoto
        
        cell.lblSoldPrice.adjustsFontSizeToFitWidth = true
        cell.lblNotSoldPrice.adjustsFontSizeToFitWidth = true
        
        let dictProduct:NSMutableDictionary = self.arrProducts.object(at: indexPath.row) as! NSMutableDictionary
        
        if self.isFromCategorySelection == true {
            
            
            
            if let thumb = dictProduct.value(forKey: "thumbNail") as? String {
                
                cell.imgCover.sd_setImage(with: NSURL(string:  String(format: "%@",dictProduct.value(forKey: "thumbNail") as! String)) as URL!, placeholderImage: nil)
            }
            else
            {
                cell.imgCover.image = UIImage(named: "placeholder.png")
                cell.imgCover.backgroundColor = UIColor.white
            }
            
            cell.lblProductName.text = dictProduct.value(forKey: "name") as? String
            
            if let specialPrice = dictProduct.value(forKey: "specialPrice") as? String
            {
                let dateFormatter:DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let fromdate = dictProduct.value(forKey: "special_from_date") as? String
                {
                    if let todate = dictProduct.value(forKey: "special_to_date") as? String
                    {
                        let dateFrom = dateFormatter.date(from: dictProduct.value(forKey: "special_from_date") as! String)!
                        // Get a later date (after a couple of milliseconds)
                        let dateTo = dateFormatter.date(from: dictProduct.value(forKey: "special_to_date") as! String)!
                        
                        
                        if NSDate().isBetweeen(date: dateFrom as NSDate, andDate: dateTo as NSDate) == true {
                            
                            cell.lblNotSoldWidth.constant = 70.0
                            cell.lblSoldCenter.constant = 33.25
                            
                            cell.lblSoldPrice.text = String(format: "%0.2f %@",Float(dictProduct.value(forKey: "specialPrice") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            

                            if let price = dictProduct.value(forKey: "price") as? String
                            {
                                cell.lblNotSoldPrice.text = String(format: "%0.2f %@",  Float(price)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            }
                            else
                            {
                                cell.lblNotSoldPrice.text = String(format: "%0.2f %@",  Float((dictProduct.value(forKey: "price") as! NSNumber).stringValue)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            }
                            
                            cell.lblSeprator.isHidden = false
                            cell.lblNotSoldPrice.textColor = UIColor.black
                            cell.lblSoldPrice.textColor = UIColor.red
                            
                        }
                        else
                        {
                            cell.lblSoldCenter.constant = 0.0
                            cell.lblNotSoldWidth.constant = 0.0
                           
                           
                            if let price = dictProduct.value(forKey: "price") as? String
                            {
                                cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float(dictProduct.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                
                            }else
                            {
                                cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float((dictProduct.value(forKey: "price") as! NSNumber).stringValue)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            }
                            
                            cell.lblSeprator.isHidden = true
                            cell.lblSoldPrice.textColor = UIColor.black
                        }
                    }
                    else
                    {
                        cell.lblSoldCenter.constant = 0.0
                        cell.lblNotSoldWidth.constant = 0.0
                        
                        if let price = dictProduct.value(forKey: "price") as? String
                        {
                            cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float(dictProduct.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                            
                        }else
                        {
                            cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float((dictProduct.value(forKey: "price") as! NSNumber).stringValue)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        }
                        
                        cell.lblSeprator.isHidden = true
                        cell.lblSoldPrice.textColor = UIColor.black
                    }
                }
                else
                {
                    cell.lblSoldCenter.constant = 0.0
                    cell.lblNotSoldWidth.constant = 0.0
                    
                    if let price = dictProduct.value(forKey: "price") as? String
                    {
                        cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float(dictProduct.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                        
                    }else
                    {
                        cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float((dictProduct.value(forKey: "price") as! NSNumber).stringValue)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                    }
                    
                    cell.lblSeprator.isHidden = true
                    cell.lblSoldPrice.textColor = UIColor.black
                }

            }
            else
            {
                cell.lblSoldCenter.constant = 0.0
                cell.lblNotSoldWidth.constant = 0.0
                
                if let price = dictProduct.value(forKey: "price") as? String
                {
                    cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float(dictProduct.value(forKey: "price") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                    
                }else
                {
                    cell.lblSoldPrice.text = String(format: "%0.2f %@",  Float((dictProduct.value(forKey: "price") as! NSNumber).stringValue)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                }

                cell.lblSeprator.isHidden = true
                cell.lblSoldPrice.textColor = UIColor.black
            }
            
        }
        else{
            
           /* let customAttributes:NSMutableArray = dictProduct.value(forKey: "custom_attributes") as! NSMutableArray
            
            var needtoApplySpecialCode:Bool = false
            
            for items in customAttributes {
                
                let dict:NSMutableDictionary = items as! NSMutableDictionary
                
                if dict.value(forKey: "attribute_code") as! String == "image"
                {
                    cell.imgCover.sd_setImage(with: NSURL(string:  String(format: "%@%@",IMAGE_URL,dict.value(forKey: "value") as! String)) as URL!, placeholderImage: nil)
                }
                
                if dict.value(forKey: "attribute_code") as! String == "special_price"
                {
                    print(Float(dict.value(forKey: "value") as! String))
                    print(Float(dictProduct.value(forKey: "price") as! NSInteger))
                    
                    if Float(dict.value(forKey: "value") as! String)! < Float(dictProduct.value(forKey: "price") as! NSInteger) {
                        
                        for items in customAttributes {
                            
                            let dictAtt:NSMutableDictionary = items as! NSMutableDictionary
                            
                            if dictAtt.value(forKey: "attribute_code") as! String == "special_from_date"
                            {
                                let dateFormatter:DateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-DD HH:mm:ss"
                                
                                let dateA = NSDate()
                                
                                // Get a later date (after a couple of milliseconds)
                                let dateB = dateFormatter.date(from: dictAtt.value(forKey: "value") as! String)
                                
                                // Compare them
                                switch dateA.compare(dateB! as Date) {
                                case .orderedAscending     :   print("current is earlier than Sp date")
                                case .orderedDescending    :   needtoApplySpecialCode = true
                                case .orderedSame          :   needtoApplySpecialCode = true
                                }
                                
                                if needtoApplySpecialCode == false {
                                    
                                    cell.lblSoldCenter.constant = 0.0
                                    cell.lblNotSoldWidth.constant = 0.0
                                    
                                    cell.lblSoldPrice.text = String(format: "%0.2f %@",  (dictProduct.value(forKey: "price") as! Float)*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblSeprator.isHidden = true
                                    cell.lblSoldPrice.textColor = UIColor.black
                                }
                                else
                                {
                                    cell.lblNotSoldWidth.constant = 70.0
                                    cell.lblSoldCenter.constant = 33.25
                                    cell.lblSoldPrice.text = String(format: "%0.2f %@",Float(dict.value(forKey: "value") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblNotSoldPrice.text = String(format: "%0.2f %@",  (dictProduct.value(forKey: "price") as! Float)*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblSeprator.isHidden = false
                                    cell.lblNotSoldPrice.textColor = UIColor.black
                                    cell.lblSoldPrice.textColor = UIColor.red
                                }
                                
                            }
                        }
                    }
                    
                    
                }
            }
            
            if needtoApplySpecialCode == false {
                
                cell.lblSoldCenter.constant = 0.0
                cell.lblNotSoldWidth.constant = 0.0
                
                cell.lblSoldPrice.text = String(format: "%0.2f %@"
                    ,(dictProduct.value(forKey: "price") as! Float)*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                
                cell.lblSeprator.isHidden = true
                cell.lblSoldPrice.textColor = UIColor.black
            }
            
            cell.lblProductName.text = dictProduct.value(forKey: "name") as? String*/
        }
                
        if let brand = dictProduct.value(forKey: "brand") as? String
        {
            cell.lblCompanyName.text = dictProduct.value(forKey: "brand") as? String
        }
        else
        {
            cell.lblCompanyName.text = ""
        }
        
        
        
        //lblCompanyName remaining
        
        if isEnglish {
            
            cell.lblSoldPrice.font = UIFont(name: appDel.strFont, size: 13.0)
            cell.lblNotSoldPrice.font = UIFont(name: appDel.strFont, size: 13.0)
            cell.lblProductName.font = UIFont(name: appDel.strFont, size: 12.0)
            cell.lblCompanyName.font = UIFont(name: appDel.strFont, size: 12.0)
        }
        else
        {
            if UIScreen.main.bounds.size.width == 320 {
                cell.lblSoldPrice.font = UIFont(name: appDel.strFontKufi, size: 9.0)
                cell.lblNotSoldPrice.font = UIFont(name: appDel.strFontKufi, size: 9.0)
            }
            else
            {
                cell.lblSoldPrice.font = UIFont(name: appDel.strFontKufi, size: 12.0)
                cell.lblNotSoldPrice.font = UIFont(name: appDel.strFontKufi, size: 12.0)
            }
            cell.lblProductName.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            cell.lblCompanyName.font = UIFont(name: appDel.strFontKufi, size: 11.0)
            
            print(cell.lblSoldPrice.font)
            print(appDel.strFontKufi)
        }
        
        return cell
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if self.isShowList == true {
            
            let screenWidth = self.view.bounds.width - 20
            let quarterWidth = screenWidth
            return CGSize(width: quarterWidth, height: ((450*UIScreen.main.bounds.size.height)/568))
        }
        else
        {
            let screenWidth = self.view.bounds.width - 10
            let quarterWidth = screenWidth / 2
            return CGSize(width: quarterWidth-11, height: ((242*UIScreen.main.bounds.size.height)/568))
        }
       
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("%@",self.arrProducts.object(at: indexPath.row))
        
        if isEnglish {
            
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            obj.strProductSKU = (self.arrProducts.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
            obj.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else
        {
            let obj:MXScrollViewExample = MXScrollViewExample(nibName: "MXScrollViewExample", bundle: nil)
            obj.strProductSKU = (self.arrProducts.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "sku") as! String as NSString?
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
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
}
extension NSDate {
    func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self as Date) == self.compare(date2 as Date)
    }
}
