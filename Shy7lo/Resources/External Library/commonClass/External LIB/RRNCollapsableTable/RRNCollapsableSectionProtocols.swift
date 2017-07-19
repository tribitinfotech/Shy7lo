//
//  RRNCollapsableSectionProtocols.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

import UIKit

protocol RRNCollapsableSectionHeaderProtocol {
    func open(_ animated: Bool);
    func close(_ animated: Bool);
    
    var btnArrow:UIButton! { get }
    var sectionTitleLabel: UILabel! { get }
    var interactionDelegate: RRNCollapsableSectionHeaderReactiveProtocol! { get set }
    var tag: Int { get set }
}

protocol RRNCollapsableSectionHeaderReactiveProtocol {
    func userTapped(_ view: RRNCollapsableSectionHeaderProtocol)
}

protocol RRNCollapsableSectionItemProtocol {
    var title: String { get }
    var isVisible: Bool { get set }
    var items: [AnyObject] { get }
    var id: Int { get }
}
