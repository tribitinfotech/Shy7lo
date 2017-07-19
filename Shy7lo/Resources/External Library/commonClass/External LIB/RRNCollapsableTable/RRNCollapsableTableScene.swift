//
//  RRNCollapsableTableScene.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

import UIKit

class RRNCollapsableTableViewController: UIViewController {
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let
                tableView = self.collapsableTableView(),
                let nibName = self.sectionHeaderNibName(),
                let reuseID = self.sectionHeaderReuseIdentifier()
        {
            let nib = UINib(nibName: nibName, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseID)
            tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        }
    }
    
    func collapsableTableView() -> UITableView? {
        return nil
    }
    
    func model() -> [RRNCollapsableSectionItemProtocol]? {
        return nil
    }
    
    func singleOpenSelectionOnly() -> Bool {
        return false
    }
    
    func sectionHeaderNibName() -> String? {
        return nil
    }
    
    func sectionHeaderReuseIdentifier() -> String? {
        return (self.sectionHeaderNibName())! + "ID"
    }

}

extension RRNCollapsableTableViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.model() ?? []).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuSection = self.model()?[section]
        return (menuSection?.isVisible ?? false) ? menuSection!.items.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var view: RRNCollapsableSectionHeaderProtocol?
        
        if let reuseID = self.sectionHeaderReuseIdentifier() {
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseID) as? RRNCollapsableSectionHeaderProtocol
        }
        
        view?.tag = section
        
        let menuSection = self.model()?[section]
        
        view?.sectionTitleLabel.text = (menuSection?.title ?? "")
        
        view?.btnArrow.tag = (menuSection?.id)!
        
        view?.btnArrow.addTarget(self, action: Selector(("buttonPress:"))
            , for: UIControlEvents.touchUpInside)
        
        
        view?.sectionTitleLabel.font = UIFont(name: appDel.strFont_Bold, size: appDel.setFont(17.0))
        
        if menuSection?.isVisible == true {
            
            view?.sectionTitleLabel.textColor = UIColor(red: 97.0/255.0, green: 28.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        }
        else
        {
            view?.sectionTitleLabel.textColor = UIColor.black
        }
        
        view?.interactionDelegate = self
        
        return view as? UIView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //No use
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let menuSection = self.model()?[(indexPath as NSIndexPath).section]
        
        cell.lblTitle.text = "Jitendra"
        
        cell.lblTitle.font = UIFont(name: appDel.strFont, size: appDel.setFont(17.0))
        
        cell.contentView.layoutIfNeeded()
        
        return cell
    }
}



extension RRNCollapsableTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? RRNCollapsableSectionHeaderProtocol {
            let menuSection = self.model()?[section]
            if (menuSection?.isVisible ?? false) {
                view.open(false)
            } else {
                view.close(false)
            }
        }
    }
}

extension RRNCollapsableTableViewController: RRNCollapsableSectionHeaderReactiveProtocol {
    
    func userTapped(_ view: RRNCollapsableSectionHeaderProtocol) {
        
        if let tableView = self.collapsableTableView() {
            
            let section = view.tag
            
            tableView.beginUpdates()
            
            var foundOpenUnchosenMenuSection = false
            
            let menu = self.model()
            
            if let menu = menu {
                
                var count = 0
                
                for var menuSection in menu {
                    
                    let chosenMenuSection = (section == count)
                    
                    let isVisible = menuSection.isVisible
                    
                    if isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = false
                        
                        view.close(true)
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "getTableHeight"), object: 0)
                        
                        let indexPaths = self.indexPaths(section, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths, with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                        tableView.reloadSections(IndexSet(integer: count), with: .none)
                        
                    } else if !isVisible && chosenMenuSection {
                        
                        menuSection.isVisible = true
                        
                        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        appDel.visibleIndex = count
                        
                        view.open(true)
                        
                        let indexPaths = self.indexPaths(section, menuSection: menuSection)
                        
                        tableView.insertRows(at: indexPaths, with: (foundOpenUnchosenMenuSection) ? .bottom : .top)
                        
                        tableView.reloadSections(IndexSet(integer: count), with: .none)
                        
                        let arr:NSArray = menuSection.items as AnyObject as! NSArray
                        
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "getTableHeight"), object: arr.count)
                        
                    } else if isVisible && !chosenMenuSection && self.singleOpenSelectionOnly() {
                        
                        foundOpenUnchosenMenuSection = true
                        
                        menuSection.isVisible = false
                        
                        let headerView = tableView.headerView(forSection: count)
                        
                        if let headerView = headerView as? RRNCollapsableSectionHeaderProtocol {
                            headerView.close(true)
                        }
                        
                        let indexPaths = self.indexPaths(count, menuSection: menuSection)
                        
                        tableView.deleteRows(at: indexPaths, with: (view.tag > count) ? .top : .bottom)
                        
                        tableView.reloadSections(IndexSet(integer: count), with: .none)
                    }
                    
                    count = count + 1
                }
                
            }
            
            //Notification
            
            tableView.endUpdates()
            
           
            
            
        }
    }
    
    func indexPaths(_ section: Int, menuSection: RRNCollapsableSectionItemProtocol) -> [IndexPath] {
        var collector = [IndexPath]()
        
        var indexPath: IndexPath
        for i in 0 ..< menuSection.items.count {
            indexPath = IndexPath(row: i, section: section)
            collector.append(indexPath)
        }
        
        return collector
    }
}
