//
//  FakeModelBuilder.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

import Foundation

class MenuSection: RRNCollapsableSectionItemProtocol  {
    
    var title: String
    var isVisible: Bool
    var items: [AnyObject]
    var id:Int
    
    init() {
        title = ""
        id = 0
        isVisible = false
        items = []
    }
}

class ModelBuilder {
    
    class func buildMenu() -> [RRNCollapsableSectionItemProtocol] {
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var collector = [RRNCollapsableSectionItemProtocol]()
        
        for i in 0 ..< appDel.categoryKeys.count {
            
            let section = MenuSection()
            
            let arr:NSMutableArray = appDel.categoryKeys as NSMutableArray
            
            section.title = arr.object(at: i) as! String
            
            section.id = Int((appDel.categoryIds as NSMutableArray).object(at: i) as! String)!
            
            if i == 0 {
                section.isVisible = true
            }
            section.items = (appDel.dictCategory.value(forKey: arr.object(at: i) as! String) as! NSMutableArray) as [AnyObject]
            
            print(section.items)
            
            collector.append(section)
            
        }
        
        return collector
    }
}
