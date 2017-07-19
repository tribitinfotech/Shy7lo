//
//  CategoryListViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 07/12/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class SearchListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
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
    
    @IBOutlet var btnList:UIButton!
    @IBOutlet var btnGrid:UIButton!
    
    @IBOutlet var collectionPhotos: UICollectionView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var viewSearchFilter: UIView!
    
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var txtSearchForFilter: UITextField!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var isAlertShown:Bool = false
    
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
        
        if isEnglish {
            
            self.imgLogo.image = UIImage(named: "ic_top_logo.png")
            
            self.viewSubMenu.transform = CGAffineTransform.identity
            self.viewMenu.transform = CGAffineTransform.identity
            
            //self.searchBar.transform = CGAffineTransform.identity
            
            self.imgLogo.transform = CGAffineTransform.identity
            //self.btnNew.transform = CGAffineTransform.identity
            
            self.viewSearchFilter.transform = CGAffineTransform.identity
            self.txtSearchForFilter.transform = CGAffineTransform.identity
            
            self.btnSearch.transform = CGAffineTransform.identity
            self.txtSearchForFilter.textAlignment = .left
            
            self.lblSearch.font = UIFont(name: appDel.strFont, size: 19.0)
            
        }
        else
        {
            self.viewMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.viewSubMenu.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            //self.searchBar.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.imgLogo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            //self.btnNew.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            //self.viewSearchFilter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.txtSearchForFilter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnSearch.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.txtSearchForFilter.textAlignment = .right
            
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            
             self.lblSearch.font = UIFont(name: appDel.strFontKufi, size: 19.0)
            
        }
        
        self.lblSearch.text = appDel.mapping?.string(forKey: "Search Shy7lo for better fashion")
        
        self.lblSearch.adjustsFontSizeToFitWidth = true
        
        if (self.txtSearchForFilter.text?.characters.count)! > 3 {
            
            self.currentPage = 1
            
            self.getProductsOfSearch(searchText: self.txtSearchForFilter.text!)
            
            self.lblSearch.isHidden = true
            
            self.indicator.isHidden = false
            
            self.indicator.startAnimating()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        FIRAnalytics.logEvent(withName: "Search_Products", parameters: ["name":"Search_Products"])
        
      /*  if isEnglish
        {
            let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
            searchTextField.layer.cornerRadius = 13
            searchTextField.textAlignment = NSTextAlignment.left
            let image:UIImage = UIImage(named: "searchIcon.png")!
            let imageView:UIImageView = UIImageView.init(image: image)
            searchTextField.leftView = imageView
            searchTextField.placeholder = ""
            searchTextField.rightView = nil
            searchTextField.rightViewMode = UITextFieldViewMode.always
        }
        else
        {
            let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
            searchTextField.layer.cornerRadius = 13
            searchTextField.textAlignment = NSTextAlignment.right
            let image:UIImage = UIImage(named: "searchIcon.png")!
            let imageView:UIImageView = UIImageView.init(image: image)
            searchTextField.leftView = nil
            searchTextField.placeholder = ""
            searchTextField.rightView = imageView
            searchTextField.rightViewMode = UITextFieldViewMode.always
        }*/
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.indicator.isHidden = true
        
        self.btnSearch.backgroundColor = .clear
        self.btnSearch.layer.cornerRadius = 0
        self.btnSearch.layer.borderWidth = 0
        self.btnSearch.layer.borderColor = UIColor.lightGray.cgColor
        
        self.viewFIlter.isHidden = true
        
        self.navigationController?.isNavigationBarHidden = true
    
        self.txtSearchForFilter.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.txtSearchForFilter.layer.borderColor = UIColor.clear.cgColor
        self.txtSearchForFilter.layer.cornerRadius = 5.0
        self.txtSearchForFilter.layer.borderWidth = 1
        self.customizeTextfield(self.txtSearchForFilter)
        
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
        
      /*  if self.isFromCategorySelection == true
        {
            bodyParameter = NSMutableDictionary()
            dictFilterData = NSMutableDictionary()
            
            bodyParameter.setValue("", forKey: "sortby")
            bodyParameter.setValue("", forKey: "direction")
            bodyParameter.setValue(self.strSelectedCategoryId, forKey: "category_id")
            bodyParameter.setValue(dictFilterData, forKey: "filterdata")
            
            self.getProductsOfSelectedCategory()
            
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
            
            self.bodyParameter = self.dictBanner
            
            self.isFromCategorySelection = true
            
            print(bodyParameter)
            
             self.getProductsOfSelectedCategory()
        }*/
        
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
    func getProductsOfSearch(searchText:String)
    {
        
         //let str1:String = String(format: "\(API_URL)/v1/customer/productlist/%@",self.strSelectedCategoryId!)
        
        let str1:String = String(format: "\(API_URL)/v1/catalog/searchProduct")
        
        var request = URLRequest(url: URL(string: str1)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("shy7lo", forHTTPHeaderField: "X-Website")
        request.addValue(Default.value(forKey: LANG_KEY) as! String!, forHTTPHeaderField: "X-Lang")
        
        let dictSend:NSMutableDictionary = NSMutableDictionary()
        dictSend.setValue(searchText, forKey: "searchQuery")
        dictSend.setValue(self.currentPage, forKey: "page_number")
        
        var jsondata2 = Data()
        
        do {
            jsondata2 = try JSONSerialization.data(withJSONObject: dictSend, options: JSONSerialization.WritingOptions.prettyPrinted)
            // use jsonData
        } catch {
            // report error
        }
        
        
        request.httpBody = jsondata2
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self.isLoadingEnabled = false
                self.HUD?.hide(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async()
                    {
                        self.HUD?.hide(true)
                        
                        self.indicator.isHidden = true
                        
                        self.isLoadingEnabled = false
                        
                        self.indicator.stopAnimating()
                        
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
                        
                        
                        
                        let flag:String = (jsonResult.value(forKey: "success") as! NSNumber).stringValue
                        
                        if flag == "1"
                        {
                            print(jsonResult)
                            print("serach : \(searchText) textfield : \(self.txtSearchForFilter.text)")
                            self.indicator.isHidden = true
                            
                            self.isLoadingEnabled = false
                            
                            self.indicator.stopAnimating()
                            
                            if let dict = jsonResult.value(forKey: "data") as? NSMutableDictionary
                            {
                                
                                if searchText == self.txtSearchForFilter.text
                                {
                                    self.HUD?.hide(true)
                                    
                                    if self.currentPage == 1
                                    {
                                        self.totalRecords = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "total_count") as! NSInteger
                                        
                                        self.arrProducts = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                                    }
                                    else
                                    {
                                        let arr:NSMutableArray = (jsonResult.value(forKey: "data") as! NSMutableDictionary).value(forKey: "items") as! NSMutableArray
                                        
                                        for item in arr
                                        {
                                            let dict = item as! NSMutableDictionary
                                            
                                            self.arrProducts.add(dict)
                                        }
                                        self.collectionPhotos.reloadData()
                                    }
                                    
                                    
                                    if self.arrProducts.count == 0
                                    {
                                        if self.isAlertShown == false
                                        {
                                            //self.isAlertShown = true
                                            
                                            self.btnList.isHidden = true
                                            self.btnGrid.isHidden = true
                                            
                                            self.lblSearch.isHidden = false
                                            self.lblSearch.text = (self.appDel.mapping?.string(forKey: "No result found"))
                                            
                                            /* let alert:UIAlertView = UIAlertView(title: self.appDel.mapping?.string(forKey: "Shy7lo"), message: (self.appDel.mapping?.string(forKey: "No result found")), delegate: self, cancelButtonTitle: self.appDel.mapping?.string(forKey: "OK"))
                                             alert.delegate = self
                                             alert.show() */
                                        }
                                        
                                    }else
                                    {
                                        self.btnList.isHidden = false
                                        self.btnGrid.isHidden = false
                                        
                                        self.lblSearch.isHidden = true
                                    }
                                    
                                    self.collectionPhotos.reloadData()
                                }
                                
                                
                            }
                            else
                            {
                                if searchText == self.txtSearchForFilter.text
                                {
                                    self.arrProducts = NSMutableArray()
                                    self.collectionPhotos.reloadData()
                                    
                                    if self.isAlertShown == false
                                    {
                                        //self.isAlertShown = true
                                        
                                        self.lblSearch.isHidden = false
                                        self.lblSearch.text = (self.appDel.mapping?.string(forKey: "No result found"))
                                        
                                        /*let alert:UIAlertView = UIAlertView(title: self.appDel.mapping?.string(forKey: "Shy7lo"), message: (self.appDel.mapping?.string(forKey: "No result found")), delegate: self, cancelButtonTitle: self.appDel.mapping?.string(forKey: "OK"))
                                         alert.delegate = self
                                         alert.show()*/
                                        
                                        self.btnList.isHidden = true
                                        self.btnGrid.isHidden = true
                                    }
                                }
                            }

                        }
                        else
                        {
                            self.HUD?.hide(true)
                            
                            self.isLoadingEnabled = false
                            
                            self.arrProducts = NSMutableArray()
                            self.collectionPhotos.reloadData()
                            
                            self.btnList.isHidden = true
                            self.btnGrid.isHidden = true
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
    
     //MARK:- Uitextfield delegate
   
    func textFieldDidChange(_ textField: UITextField) {

        if (textField.text?.characters.count)! > 3 {
            
            self.currentPage = 1
            
            self.getProductsOfSearch(searchText: textField.text!)
            
            self.lblSearch.isHidden = true
            
            self.indicator.isHidden = false
            
            self.indicator.startAnimating()
        }
        else if textField.text == ""
        {
            self.indicator.isHidden = true
            
            self.indicator.stopAnimating()
            
            self.arrProducts = NSMutableArray()
            self.collectionPhotos.reloadData()
            
            self.lblSearch.isHidden = false
            
            self.btnGrid.isHidden = true
            self.btnList.isHidden = true
            
            self.lblSearch.text = appDel.mapping?.string(forKey: "Search Shy7lo for better fashion")
        }
        
    }
    func customizeTextfield( _ textfield:UITextField)
    {
        let leftView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 50))
        leftView.backgroundColor=UIColor.clear
        textfield.leftView = leftView
        textfield.leftViewMode = UITextFieldViewMode.always
        
        let rightView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 50))
        rightView.backgroundColor=UIColor.clear
        textfield.rightView = rightView
        textfield.rightViewMode = UITextFieldViewMode.always
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Action zones
    
    @IBAction func btnSearchFilterAction(_ sender: Any)
    {
        self.txtSearchForFilter.resignFirstResponder()
    }
    
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
         //obj.objCategory = self
         self.present(obj, animated: true, completion: nil)
        
    }
    @IBAction func btnGridAction(_ sender: AnyObject)
    {
        self.isShowList = false
        
        self.btnGrid.isSelected = true
        self.btnList.isSelected = false
        
        self.smallLayout.invalidateLayout()
        self.collectionPhotos.setCollectionViewLayout(self.smallLayout, animated: true)
        
       // self.perform(#selector(animateCollectionSmall), with: nil, afterDelay: 0.1)
       
    }
    @IBAction func btnListAction(_ sender: AnyObject)
    {
        self.isShowList = true
        
        self.btnGrid.isSelected = false
        self.btnList.isSelected = true
        
        self.largeLayout.invalidateLayout()
        self.collectionPhotos.setCollectionViewLayout(self.largeLayout, animated: true)
        
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
        
        
        
        if (self.arrProducts.count < self.totalRecords) && (self.arrProducts.count%16 == 0) && self.isLoadingEnabled == false
        {
            
            let bottomEdge: Float = Float(scrollView.contentOffset.y) + Float(scrollView.frame.size.height)
            if bottomEdge + 1 >= Float(scrollView.contentSize.height) {
                // we are at the end
                self.currentPage = self.currentPage + 1
                
                self.indicator.isHidden = false
                
                self.indicator.startAnimating()
                
                self.isLoadingEnabled = true
                
                self.getProductsOfSearch(searchText: self.txtSearchForFilter.text!)
            }
            
            
        }
        
    }
    
    //MARK:- UISearchbar delegate
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       print(searchText)
        
        if searchText.characters.count > 3 {
            
            self.getProductsOfSearch(searchText: searchText)
        }
        else if searchText == ""
        {
            self.arrProducts = NSMutableArray()
            self.collectionPhotos.reloadData()
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
        
        let dict:NSMutableDictionary = self.arrSortParameter.object(at: indexPath.row) as! NSMutableDictionary
        
        cell.lblSortParameter.setTitle(dict.value(forKey: "label") as? String, for: UIControlState.normal)
        
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
        
        print(self.bodyParameter)
        
    }
    
    //MARK:- UIAlertview delegate method
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        self.isAlertShown = false
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
        
        let customAttributes:NSMutableArray = dictProduct.value(forKey: "custom_attributes") as! NSMutableArray
        
        var needtoApplySpecialCode:Bool = false
        
        cell.imgCover.sd_setImage(with: NSURL(string:  String(format: "%@",dictProduct.value(forKey: "image") as! String)) as URL!, placeholderImage: nil, options: .lowPriority)
        
        for items in customAttributes {
            
            let dict:NSMutableDictionary = items as! NSMutableDictionary
            
            /*if dict.value(forKey: "attribute_code") as! String == "image"
            {
               cell.imgCover.sd_setImage(with: NSURL(string:  String(format: "%@",dict.value(forKey: "value") as! String)) as URL!, placeholderImage: nil, options: .lowPriority)
            }*/
            
            if dict.value(forKey: "attribute_code") as! String == "brand"
            {
                cell.lblCompanyName.text = dict.value(forKey: "value") as? String
            }
            
            if dict.value(forKey: "attribute_code") as! String == "special_price"
            {
                
                if let value = dict.value(forKey: "value") as? String {
                    
                    let Price:Float = Float((dict.value(forKey: "value") as? String)!)!
                    
                    let mainPrice:Float = Float((dictProduct.value(forKey: "price") as? String)!)!
                    
                    if Price < mainPrice {
                        
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
                                    
                                    cell.lblSoldPrice.text = String(format: "%0.2f %@",  mainPrice*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblSeprator.isHidden = true
                                    cell.lblSoldPrice.textColor = UIColor.black
                                }
                                else
                                {
                                    cell.lblNotSoldWidth.constant = 70.0
                                    cell.lblSoldCenter.constant = 33.25
                                    cell.lblSoldPrice.text = String(format: "%0.2f %@",Float(dict.value(forKey: "value") as! String)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblNotSoldPrice.text = String(format: "%0.2f %@",  mainPrice*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
                                    
                                    cell.lblSeprator.isHidden = false
                                    cell.lblNotSoldPrice.textColor = UIColor.black
                                    cell.lblSoldPrice.textColor = UIColor.red
                                }
                                
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
                ,Float((dictProduct.value(forKey: "price") as? String)!)!*(UserDefaults.standard.value(forKey: "exchangeRates") as! Float),UserDefaults.standard.value(forKey: "currencyCode") as! String)
            
            cell.lblSeprator.isHidden = true
            cell.lblSoldPrice.textColor = UIColor.black
        }
        
        cell.lblProductName.text = dictProduct.value(forKey: "name") as? String
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
