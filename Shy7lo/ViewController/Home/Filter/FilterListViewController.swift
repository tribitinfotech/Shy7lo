//
//  FilterListViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 26/12/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit

class FilterListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    var arrFilterType:NSMutableArray = NSMutableArray()
    var dictCurrentFilter:NSMutableDictionary = NSMutableDictionary()
    
    @IBOutlet weak var imgFIlterIcon: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var viewHeader: UIView!
    
    
    @IBOutlet weak var tblFilter: UITableView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnApplyFilter: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnResetAll: UIButton!
  
    @IBOutlet weak var tblFilterData: UITableView!
    @IBOutlet weak var lblFilterName: UILabel!
   
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var objCategory:CategoryListViewController?
    
    var strOldSortIndex:NSInteger?
    var oldGridStatus:Bool?
    
    
    /* view filter */
    
    @IBOutlet weak var heightFilterSearch: NSLayoutConstraint!
    
    var arrFilterData:NSMutableArray = NSMutableArray()
    var arrSearchFilterData:NSMutableArray = NSMutableArray()
    var isSearching:Bool = false
    
    @IBOutlet weak var viewFilter: UIView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var viewSearchFilter: UIView!
    
    @IBOutlet weak var txtSearchForFilter: UITextField!
    
    
    @IBOutlet weak var viewFilterInside: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var heightFilterTable: NSLayoutConstraint!
    
    @IBOutlet weak var filterViewTop: NSLayoutConstraint!
    
    var strFilterValue:String = ""
    var strFilterSelectedId:String = ""
    
    var selectedFilter:NSInteger = 0
    
    /*             */
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.strOldSortIndex = appDel.filterSortIndex
        self.oldGridStatus = appDel.isGridSelected
        
        self.tblFilter.sectionHeaderHeight = UITableViewAutomaticDimension
        self.tblFilter.estimatedSectionHeaderHeight = 25;
        
        self.btnSearch.backgroundColor = .clear
        self.btnSearch.layer.cornerRadius = 0
        self.btnSearch.layer.borderWidth = 1
        self.btnSearch.layer.borderColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor
        
        self.txtSearchForFilter.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.customizeTextfield(self.txtSearchForFilter)
        

            
        if isEnglish {
            
            self.imgLogo.image = UIImage(named: "ic_top_logo.png")
            self.viewHeader.transform = CGAffineTransform.identity
            self.imgFIlterIcon.transform = CGAffineTransform.identity
            self.imgLogo.transform = CGAffineTransform.identity
            
            /* view filter setup */
            
            self.viewFilterInside.transform = CGAffineTransform.identity
            
            self.txtSearchForFilter.transform = CGAffineTransform.identity
            
            self.btnSearch.transform = CGAffineTransform.identity
            
            self.lblFilterName.transform = CGAffineTransform.identity
            
            self.btnClear.transform = CGAffineTransform.identity
            
            self.btnDone.transform = CGAffineTransform.identity
            
            self.txtSearchForFilter.textAlignment = .left
            self.lblFilterName.textAlignment = .left
            
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: appDel.setFont(18.0))
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFont_Bold, size: appDel.setFont(18.0))
            self.lblFilterName.font = UIFont(name: appDel.strFont_Bold, size: 17.0)
            self.txtSearchForFilter.font = UIFont(name: appDel.strFont, size: 14.0)
            
            /* view filter setup */
            
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFont, size: appDel.setFont(14.0))
            //self.btnFilter.titleLabel?.font = UIFont(name: appDel.strFont, size: appDel.setFont(8.0))
            self.btnResetAll.titleLabel?.font = UIFont(name: appDel.strFont, size: appDel.setFont(14.0))
            self.lblTitle.font = UIFont(name: appDel.strFont, size: 17.0)
            
            self.viewTop.transform = CGAffineTransform.identity
            self.btnFilter.transform = CGAffineTransform.identity
            //self.btnResetAll.transform = CGAffineTransform.identity
            self.lblTitle.transform = CGAffineTransform.identity
            self.lblTitle.textAlignment = .left
            
            //let strMapFIlter = appDel.mapping?.string(forKey: "FilterMenu")
            //self.btnFilter.setTitle("\(strMapFIlter!)", for: UIControlState.normal)
            //self.btnFilter.titleLabel?.adjustsFontSizeToFitWidth = true
            
        }
        else
        {
            self.imgLogo.image = UIImage(named: "logo_arabic.png")
            self.viewHeader.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgFIlterIcon.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.imgLogo.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            /* view filter setup */
            
            self.viewFilterInside.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.txtSearchForFilter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnSearch.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.lblFilterName.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnClear.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.btnDone.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            
            self.txtSearchForFilter.textAlignment = .right
            self.lblFilterName.textAlignment = .right
            
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: appDel.setFont(18.0))
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFontKufi_Bold, size: appDel.setFont(18.0))
            self.lblFilterName.font = UIFont(name: appDel.strFontKufi_Bold, size: 17.0)
            self.txtSearchForFilter.font = UIFont(name: appDel.strFontKufi, size: 14.0)
            
            /* view filter setup */
            
            self.btnApplyFilter.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: appDel.setFont(14.0))
            //self.btnFilter.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: appDel.setFont(7.0))
            self.btnResetAll.titleLabel?.font = UIFont(name: appDel.strFontKufi, size: appDel.setFont(14.0))
            self.lblTitle.font = UIFont(name: appDel.strFontKufi, size: 17.0)
            
            self.viewTop.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.btnFilter.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            //self.btnResetAll.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.lblTitle.textAlignment = .right
            
            //let strMapFIlter = appDel.mapping?.string(forKey: "FilterMenu")
            //self.btnFilter.setTitle("\(strMapFIlter!)      .", for: UIControlState.normal)
            //self.btnFilter.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        
        self.btnApplyFilter.setTitle(appDel.mapping?.string(forKey: "Apply Filter"), for: UIControlState.normal)
        
        self.btnResetAll.setTitle(appDel.mapping?.string(forKey: "Reset All"), for: UIControlState.normal)
        
        self.btnDone.setTitle(appDel.mapping?.string(forKey: "DoneFilter"), for: UIControlState.normal)
        self.btnClear.setTitle(appDel.mapping?.string(forKey: "Clear"), for: UIControlState.normal)
        self.txtSearchForFilter.placeholder = appDel.mapping?.string(forKey: "Search")
        
        self.lblTitle.text = appDel.mapping?.string(forKey: "Filter")

        self.tblFilter.register(UINib(nibName: "filterCell", bundle: nil), forCellReuseIdentifier: "cellFilter")
        self.tblFilter.register(UINib(nibName: "cellFilterHeader", bundle: nil), forCellReuseIdentifier: "cellFilterHeader")
        
        self.tblFilter.register(UINib(nibName: "cellSortHeader", bundle: nil), forCellReuseIdentifier: "cellSortHeader")
        self.tblFilter.register(UINib(nibName: "cellOptionHeader", bundle: nil), forCellReuseIdentifier: "cellOptionHeader")
        
        self.tblFilter.register(UINib(nibName: "cellFIlterData", bundle: nil), forCellReuseIdentifier: "cellFIlterData")
        
        
        for i in 0..<self.arrFilterType.count
        {
            let dict:NSMutableDictionary = self.arrFilterType.object(at: i) as! NSMutableDictionary
            
            dict.setValue(appDel.mapping?.string(forKey: "All"), forKey: "filterValue")
            dict.setValue("", forKey: "filterSelectedId")
            dict.setValue("0", forKey: "isSelected")
            dict.setValue("0", forKey: "isOpened")
            
            for i in 0..<self.dictCurrentFilter.allKeys.count
            {
                let strCode:String = (self.dictCurrentFilter.allKeys as NSArray).object(at: i) as! String
                
                if strCode == dict.value(forKey: "code") as! String {
                    
                    var selectedValue:String = ""
                    var selectedId:String = ""
                    
                     for j in 0..<(dict.value(forKey: "options") as! NSArray).count
                     {
                        let dictCodeOfMainFilter:NSMutableDictionary = (dict.value(forKey: "options") as! NSArray).object(at: j) as! NSMutableDictionary
                        
                        let strValue:String = self.dictCurrentFilter.value(forKey: strCode) as! String
                        
                        if strValue.contains(",") == true {
                            
                            let arrCommaSep:NSArray = strValue.components(separatedBy: ",") as NSArray
                            
                            for str in arrCommaSep
                            {
                                let value:String = str as! String
                                
                                if value == dictCodeOfMainFilter.value(forKey: "id") as! String {
                                    
                                    if selectedValue == "" {
                                        
                                        selectedValue = dictCodeOfMainFilter.value(forKey: "label") as! String
                                        selectedId = dictCodeOfMainFilter.value(forKey: "id") as! String
                                    }
                                    else
                                    {
                                        selectedValue = String(format:"%@,%@",selectedValue,dictCodeOfMainFilter.value(forKey: "label") as! String)
                                        selectedId = String(format:"%@,%@",selectedId,dictCodeOfMainFilter.value(forKey: "id") as! String)
                                    }
                                    
                                    break
                                }
                            }
                            
                        }
                        else
                        {
                            if strValue == dictCodeOfMainFilter.value(forKey: "id") as! String
                            {
                                if selectedValue == "" {
                                    
                                    selectedValue = dictCodeOfMainFilter.value(forKey: "label") as! String
                                    selectedId = dictCodeOfMainFilter.value(forKey: "id") as! String
                                }
                                else
                                {
                                    selectedValue = String(format:"%@,%@",selectedValue,dictCodeOfMainFilter.value(forKey: "label") as! String)
                                    selectedId = String(format:"%@,%@",selectedId,dictCodeOfMainFilter.value(forKey: "id") as! String)
                                }
                            }
                            
                            
                        }
                        
                        /*if strValue.contains(dictCodeOfMainFilter.value(forKey: "id") as! String) == true {
                            
                            if selectedValue == "" {
                                
                                selectedValue = dictCodeOfMainFilter.value(forKey: "label") as! String
                                selectedId = dictCodeOfMainFilter.value(forKey: "id") as! String
                            }
                            else
                            {
                                selectedValue = String(format:"%@,%@",selectedValue,dictCodeOfMainFilter.value(forKey: "label") as! String)
                                selectedId = String(format:"%@,%@",selectedId,dictCodeOfMainFilter.value(forKey: "id") as! String)
                            }
                        }*/
                    }
                    
                    dict.setValue(selectedValue, forKey: "filterValue")
                    dict.setValue(selectedId, forKey: "filterSelectedId")
                }
            }
            
        }
        
        print(self.arrFilterType)
        
        self.tblFilter.reloadData()
        
        
        UIView.animate(withDuration: 0.01, animations: {
            
            self.filterViewTop.constant = 101
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            self.filterViewTop.constant = 1000
        }
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Textfield Delegate Method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "" {
            
            
            var numberOFRows:NSInteger = 0
            
            
            if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                if self.arrFilterData.count > 8 {
                    numberOFRows = 7
                }
            }
            else
            {
                if self.arrFilterData.count > 10
                {
                    numberOFRows = 9
                }
            }
            
            
            if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                
                if self.arrFilterData.count > 8 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrFilterData.count)
                }
            }
            else
            {
                if self.arrFilterData.count > 10 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrFilterData.count)
                }
                
            }
            
            self.isSearching = false
            self.tblFilterData.reloadData()
            
        }
        else
        {
            self.arrSearchFilterData = NSMutableArray()
            
            for i in 0..<self.arrFilterData.count
            {
                let dict:NSMutableDictionary = self.arrFilterData.object(at: i) as! NSMutableDictionary
                
                if ((dict.value(forKey: "label") as! String).lowercased()).hasPrefix((textField.text!).lowercased()) == true {
                    
                    self.arrSearchFilterData.add(dict)
                }
                
            }
            
            print(self.arrSearchFilterData)
            
            var numberOFRows:NSInteger = 0
            
            
            if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                if self.arrSearchFilterData.count > 8 {
                    numberOFRows = 7
                }
            }
            else
            {
                if self.arrSearchFilterData.count > 10
                {
                    numberOFRows = 9
                }
            }
            

            if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                
                if self.arrSearchFilterData.count > 8 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrSearchFilterData.count)
                }
            }
            else
            {
                if self.arrSearchFilterData.count > 10 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrSearchFilterData.count)
                }
                
            }
            
            self.isSearching = true
            self.tblFilterData.reloadData()
        }
        

    }

    //MARK:- Tableview delagte methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.arrFilterType.count + 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == self.arrFilterType.count  {
            
            //sort
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSortHeader") as! cellSortHeader
            
            cell.setUpUI()
            
            cell.btnNew.addTarget(self, action: #selector(btnSortNewAction), for: .touchUpInside)
            cell.btnPopularity.addTarget(self, action: #selector(btnSortPopularityAction), for: .touchUpInside)
            cell.btnHighToLow.addTarget(self, action: #selector(btnSortHighToLowAction), for: .touchUpInside)
            cell.btnLowToHigh.addTarget(self, action: #selector(btnSortLowToHighAction), for: .touchUpInside)
            cell.btnDiscount.addTarget(self, action: #selector(btnSortDiscountAction), for: .touchUpInside)
            
            return cell.contentView
        }
        else if section == self.arrFilterType.count + 1
        {
            //options
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOptionHeader") as! cellOptionHeader
            
            cell.setUpUI()
            
            cell.btngrid.addTarget(self, action: #selector(btnGridAction), for: .touchUpInside)
            cell.btnList.addTarget(self, action: #selector(btnListAction), for: .touchUpInside)
            
            if appDel.isGridSelected == true {
                
                cell.btngrid.isSelected = true
                cell.btnList.isSelected = false
            }
            else
            {
                cell.btngrid.isSelected = false
                cell.btnList.isSelected = true
            }
            
            return cell.contentView
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilterHeader") as! cellFilterHeader
            
            let dict:NSMutableDictionary = self.arrFilterType.object(at: section) as! NSMutableDictionary
            
            if dict.value(forKey: "isOpened") as! String == "0"
            {
                 cell.setUpUI(isSelected: false)
            }
            else
            {
                 cell.setUpUI(isSelected: true)
            }
            
            cell.lblFilterHeader.text = dict.value(forKey: "label") as? String
            
            cell.btnShowHide.tag = section
            
            cell.btnShowHide.addTarget(self, action: #selector(btnTapShowHideSection), for: .touchUpInside)
            
            return cell.contentView
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == self.arrFilterType.count || section == self.arrFilterType.count + 1 {
            return 0
        }
        else
        {
            let dict:NSMutableDictionary = self.arrFilterType.object(at: section) as! NSMutableDictionary
            
            if dict.value(forKey: "isOpened") as! String == "1"
            {
                return (dict.value(forKey: "options") as! NSArray).count
            }
            else
            {
                return 1
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFIlterData", for: indexPath) as! cellFIlterData
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.setUpUI()
        
        var dict:NSMutableDictionary = NSMutableDictionary()
        
        let dictSec:NSMutableDictionary = self.arrFilterType.object(at: indexPath.section) as! NSMutableDictionary
        
        print(dictSec)
        
        if dictSec.value(forKey: "isOpened") as! String == "0" {
            
            cell.lblSortParameter.setTitle(dictSec.value(forKey: "filterValue") as! String?, for: UIControlState.normal)
            
             cell.imgCheckMark.image = UIImage(named: "btn_filter_round_select.png")
        }
        else
        {
            dict = (dictSec.value(forKey: "options") as! NSMutableArray).object(at: indexPath.row) as! NSMutableDictionary
            
            cell.lblSortParameter.setTitle(dict.value(forKey: "label") as! String?, for: UIControlState.normal)
            
            if self.strFilterSelectedId.contains(",") == true {
                
                //For loop and check each value with dict id
            }
            else
            {
                if dictSec.value(forKey: "filterSelectedId") as! String == dict.value(forKey: "id") as! String
                {
                    cell.imgCheckMark.image = UIImage(named: "btn_filter_round_select.png")
                }
                else
                {
                    cell.imgCheckMark.image = UIImage(named: "btn_filter_round.png")
                }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tblFilter {
         
           /* self.viewFilter.isHidden = false
            
            self.arrFilterData = (self.arrFilterType.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "options") as! NSMutableArray
            
            self.lblFilterName.text =  (self.arrFilterType.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "label") as? String
            
            self.strFilterValue = ((self.arrFilterType.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "filterValue") as? String)!
            
            self.strFilterSelectedId = ((self.arrFilterType.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "filterSelectedId") as? String)!
            
            self.selectedFilter = indexPath.row
            
            var numberOFRows:NSInteger = 0
            
            if (self.arrFilterType.object(at: indexPath.row) as! NSMutableDictionary).value(forKey: "code") as! String == "brand"  {
                
                self.heightFilterSearch.constant = 44
                
                if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                    if self.arrFilterData.count > 8 {
                        numberOFRows = 7
                    }
                }
                else
                {
                    if self.arrFilterData.count > 10
                    {
                        numberOFRows = 9
                    }
                }
            }
            else
            {
                self.heightFilterSearch.constant = 0
                
                if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                    if self.arrFilterData.count > 8 {
                        numberOFRows = 8
                    }
                }
                else
                {
                    if self.arrFilterData.count > 10
                    {
                        numberOFRows = 10
                    }
                }
            }
            
            if UIScreen.main.bounds.size.width == 320 || UIScreen.main.bounds.size.width == 375 {
                
                if self.arrFilterData.count > 8 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrFilterData.count)
                }
            }
            else
            {
                if self.arrFilterData.count > 10 {
                    self.heightFilterTable.constant = CGFloat(Float(44*numberOFRows))
                }
                else
                {
                    self.heightFilterTable.constant = CGFloat(44*self.arrFilterData.count)
                }
                
            }
            
            self.tblFilterData.reloadData()
            
            self.perform(#selector(upFilterView), with: nil, afterDelay: 0.1)*/
            

            
            
            
            var dictSec:NSMutableDictionary = NSMutableDictionary()
            
            dictSec = self.arrFilterType.object(at: indexPath.section) as! NSMutableDictionary
            
            if dictSec.value(forKey: "isOpened") as! String == "1" {
                
                var dict:NSMutableDictionary = NSMutableDictionary()
                
                dict = (dictSec.value(forKey: "options") as! NSMutableArray).object(at: indexPath.row) as! NSMutableDictionary
                
                self.strFilterSelectedId = dict.value(forKey: "id") as! String
                
                self.strFilterValue = dict.value(forKey: "label") as! String
                
                dictSec.setValue(self.strFilterValue, forKey: "filterValue")
                dictSec.setValue(self.strFilterSelectedId, forKey: "filterSelectedId")
                
                self.tblFilter.reloadData()
            }
            else
            {
                let dict:NSMutableDictionary = self.arrFilterType.object(at: indexPath.section) as! NSMutableDictionary
                
                dict.setValue("1", forKey: "isOpened")
                
                self.tblFilter.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
  
        }
        else
        {
           
            
            
            /*if self.strFilterSelectedId.contains(dict.value(forKey: "id") as! String)
            {
                
                if self.strFilterSelectedId.contains(",") == true {
                    
                    let arrCommaSep:NSArray = self.strFilterSelectedId.components(separatedBy: ",") as NSArray
                    
                    if self.strFilterSelectedId.hasPrefix(dict.value(forKey: "id") as! String) {
                        
                        self.strFilterSelectedId = self.strFilterSelectedId.replacingOccurrences(of: String(format:"%@,",dict.value(forKey: "id") as! String), with: "")
                        
                         self.strFilterValue = self.strFilterValue.replacingOccurrences(of: String(format:"%@,",dict.value(forKey: "label") as! String), with: "")
                    }
                    else if arrCommaSep.lastObject as! String == dict.value(forKey: "id") as! String
                    {
                        self.strFilterSelectedId = self.strFilterSelectedId.replacingOccurrences(of: String(format:",%@",dict.value(forKey: "id") as! String), with: "")
                        
                         self.strFilterValue = self.strFilterValue.replacingOccurrences(of: String(format:",%@",dict.value(forKey: "label") as! String), with: "")
                    }
                    else
                    {
                        self.strFilterSelectedId = self.strFilterSelectedId.replacingOccurrences(of: String(format:",%@",dict.value(forKey: "id") as! String), with: "")
                        
                        self.strFilterValue = self.strFilterValue.replacingOccurrences(of: String(format:",%@",dict.value(forKey: "label") as! String), with: "")
                    }
                    
                }
                else
                {
                    self.strFilterSelectedId = self.strFilterSelectedId.replacingOccurrences(of: String(format:"%@",dict.value(forKey: "id") as! String), with: "")
                    
                    self.strFilterValue = self.strFilterValue.replacingOccurrences(of: String(format:"%@",dict.value(forKey: "label") as! String), with: "")
                }

            }
            else
            {
                if strFilterSelectedId == "" {
                    
                    strFilterSelectedId = dict.value(forKey: "id") as! String
                    
                    self.strFilterValue = dict.value(forKey: "label") as! String
                }
                else
                {
                    strFilterSelectedId = String(format:"%@,%@",strFilterSelectedId,dict.value(forKey: "id") as! String)
                    
                    self.strFilterValue = String(format:"%@,%@",self.strFilterValue,dict.value(forKey: "label") as! String)
                }
            }*/

        }
        
       
    }
    
    //MARK:- Private method
    
    func upFilterView()
    {
        UIView.animate(withDuration: 0.7, animations: {
            
            self.filterViewTop.constant = 101
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            
        }
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
    //MARK:- Action zones
    
    @IBAction func btnGridAction(_ sender: Any)
    {
        appDel.isGridSelected = true
        
        self.tblFilter.reloadData()
    }
    
    @IBAction func btnListAction(_ sender: Any)
    {
        appDel.isGridSelected = false
        
        self.tblFilter.reloadData()
    }
    
    @IBAction func btnSortNewAction(_ sender: Any)
    {
        appDel.filterSortIndex = 2
        
        self.tblFilter.reloadData()
    }
    @IBAction func btnSortPopularityAction(_ sender: Any)
    {
        appDel.filterSortIndex = 1
        
        self.tblFilter.reloadData()
    }
    @IBAction func btnSortHighToLowAction(_ sender: Any)
    {
        appDel.filterSortIndex = 4
        
        self.tblFilter.reloadData()
    }
    @IBAction func btnSortLowToHighAction(_ sender: Any)
    {
        appDel.filterSortIndex = 3
        
        self.tblFilter.reloadData()
    }
    @IBAction func btnSortDiscountAction(_ sender: Any)
    {
        appDel.filterSortIndex = 5
        
        self.tblFilter.reloadData()
    }
    
    @IBAction func btnTapShowHideSection(_ sender: Any)
    {
        let btn:UIButton = sender as! UIButton
        
        let dict:NSMutableDictionary = self.arrFilterType.object(at: btn.tag) as! NSMutableDictionary
        
        if dict.value(forKey: "isOpened") as! String == "0"
        {
           dict.setValue("1", forKey: "isOpened")
        }
        else
        {
           dict.setValue("0", forKey: "isOpened")
        }
        self.tblFilter.reloadSections(IndexSet(integer: btn.tag), with: .automatic)
    }
    @IBAction func btnRemoveFilterAction(_ sender: Any)
    {
        /*UIView.animate(withDuration: 1.0, animations: {
            
            self.filterViewTop.constant = UIScreen.main.bounds.size.height
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            self.viewFilter.isHidden = true
        }*/
    }
    @IBAction func btnClearFilterAction(_ sender: Any)
    {
        self.isSearching = false
        
        self.txtSearchForFilter.resignFirstResponder()
        
        let dict:NSMutableDictionary = self.arrFilterType.object(at: selectedFilter) as! NSMutableDictionary
        
        dict.setValue(appDel.mapping?.string(forKey: "All"), forKey: "filterValue")
        dict.setValue("", forKey: "filterSelectedId")
        
        self.tblFilter.reloadData()
        
        UIView.animate(withDuration: 0.7, animations: {
            
            self.filterViewTop.constant = UIScreen.main.bounds.size.height
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            self.viewFilter.isHidden = true
        }
        
        
    }
    @IBAction func btnDoneFilterAction(_ sender: Any)
    {
        self.isSearching = false
        
        self.txtSearchForFilter.resignFirstResponder()
        
        let dict:NSMutableDictionary = self.arrFilterType.object(at: selectedFilter) as! NSMutableDictionary
        
        dict.setValue(self.strFilterValue, forKey: "filterValue")
        dict.setValue(self.strFilterSelectedId, forKey: "filterSelectedId")
        
        UIView.animate(withDuration: 0.7, animations: {
            
            self.filterViewTop.constant = UIScreen.main.bounds.size.height
            
            self.view.layoutIfNeeded()
            
        }) { (flag:Bool) in
            
            self.viewFilter.isHidden = true
            
            self.tblFilter.reloadData()
        }
    }
    @IBAction func btnApplyFilterAction(_ sender: AnyObject)
    {
        print(self.arrFilterType)
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        
        for i in 0..<self.arrFilterType.count
        {
            let dictFilter:NSMutableDictionary = self.arrFilterType.object(at: i) as! NSMutableDictionary
            
            
            if dictFilter.value(forKey: "filterSelectedId") as! String != "" {
                
                dict.setValue(dictFilter.value(forKey: "filterSelectedId") as! String, forKey: dictFilter.value(forKey: "code") as! String)
            }
            
        }
        
        if appDel.isGridSelected == true {
            
            self.objCategory?.btnGridAction(self.btnDone)
        }
        else
        {
            self.objCategory?.btnListAction(self.btnDone)
        }
        
        self.objCategory?.currentPage = 1
        
        
        switch appDel.filterSortIndex {
        case 1:
            self.objCategory?.bodyParameter.setValue("most_viewed", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("ASC", forKey: "direction")
            break
        case 2:
            self.objCategory?.bodyParameter.setValue("created_at", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("ASC", forKey: "direction")
            break
        case 3:
            self.objCategory?.bodyParameter.setValue("price", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("ASC", forKey: "direction")
            break
        case 4:
            self.objCategory?.bodyParameter.setValue("price", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("DESC", forKey: "direction")
            break
        case 5:
            self.objCategory?.bodyParameter.setValue("saving", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("ASC", forKey: "direction")
            break
        default:
            self.objCategory?.bodyParameter.setValue("", forKey: "sortby")
            self.objCategory?.bodyParameter.setValue("ASC", forKey: "direction")
            break
        }
        
        
        
        self.objCategory?.bodyParameter.setValue(1, forKey: "page_number")
        
        self.objCategory?.bodyParameter.setValue(dict, forKey: "filterdata")
        
        self.objCategory?.dictFilterData = dict
        
        //self.objCategory?.getProductsOfSelectedCategory()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFilterAction(_ sender: AnyObject)
    {
        appDel.filterSortIndex = self.strOldSortIndex!
        
        appDel.isGridSelected = self.oldGridStatus!
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFilterTapped(_ sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        for item  in self.arrFilterType {
            
            let dict:NSMutableDictionary = item as! NSMutableDictionary
            dict.setValue("0", forKey: "isSelected")
        }
        
        /*let dict1:NSMutableDictionary = self.arrFilterType.object(at: btn.tag) as! NSMutableDictionary
        dict1.setValue("1", forKey: "isSelected")*/
        
        self.tblFilter.reloadData()
    }
    
    @IBAction func btnSearchFilterAction(_ sender: Any)
    {
        self.txtSearchForFilter.resignFirstResponder()
    }
    @IBAction func btnResetAllAction(_ sender: AnyObject)
    {
        appDel.filterSortIndex = 2
        
        appDel.isGridSelected = true
        
        for i in 0..<self.arrFilterType.count
        {
            let dictFilter:NSMutableDictionary = self.arrFilterType.object(at: i) as! NSMutableDictionary
            
            dictFilter.setValue(appDel.mapping?.string(forKey: "All"), forKey: "filterValue")
            dictFilter.setValue("", forKey: "filterSelectedId")
        }
        
        self.tblFilter.reloadData()
    }
    
    //MARK :- Memory management method
    
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
