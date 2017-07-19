//
//  MenuSectionHeader.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

import UIKit

class MenuSectionHeaderView: UITableViewHeaderFooterView, RRNCollapsableSectionHeaderProtocol {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewArrowLeading: NSLayoutConstraint!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var viewArrow: UIView!
    var interactionDelegate: RRNCollapsableSectionHeaderReactiveProtocol!
    
    func radians(_ degrees: Double) -> Double {
        return M_PI * degrees / 180.0
    }
    
    fileprivate var isRotating = false
    
    func open(_ animated: Bool) {
        
        if UIScreen.main.bounds.size.width == 320
        {
            self.viewArrowLeading.constant = 282
        }
        else if UIScreen.main.bounds.size.width == 375
        {
            self.viewArrowLeading.constant = 337
        }
        else if UIScreen.main.bounds.size.width == 414
        {
            self.viewArrowLeading.constant = 380
        }
        
        if isEnglish {
            
            self.viewCell.transform = CGAffineTransform.identity
            self.sectionTitleLabel.transform = CGAffineTransform.identity
            self.sectionTitleLabel.textAlignment = .left
        }
        else
        {
            
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.sectionTitleLabel.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.sectionTitleLabel.textAlignment = .right
        }
        
        
        
        if animated && !isRotating {
            
            isRotating = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: { () -> Void in
                //self.arrowImageView.transform = CGAffineTransformIdentity
                self.arrowImageView.image = UIImage(named: "ic_arrow_up.png")
                }, completion: { (finished) -> Void in
                    self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            //arrowImageView.transform = CGAffineTransformIdentity
            self.arrowImageView.image = UIImage(named: "ic_arrow_up.png")
            isRotating = false
        }
    }
    
    func close(_ animated: Bool) {
        
        if UIScreen.main.bounds.size.width == 320
        {
            self.viewArrowLeading.constant = 282
        }
        else if UIScreen.main.bounds.size.width == 375
        {
            self.viewArrowLeading.constant = 337
        }
        else if UIScreen.main.bounds.size.width == 414
        {
            self.viewArrowLeading.constant = 380
        }
        
        if isEnglish {
            
            self.viewCell.transform = CGAffineTransform.identity
            self.sectionTitleLabel.transform = CGAffineTransform.identity
            self.sectionTitleLabel.textAlignment = .left
        }
        else
        {
            
            self.viewCell.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.sectionTitleLabel.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
            self.sectionTitleLabel.textAlignment = .right
        }
        
        if animated && !isRotating {
            
            isRotating = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: { () -> Void in
                //self.arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(self.radians(180.0)))
                self.arrowImageView.image = UIImage(named: "ic_arrow_bottom.png")
                }, completion: { (finished) -> Void in
                    self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            //arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(radians(180.0)))
            self.arrowImageView.image = UIImage(named: "ic_arrow_bottom.png")
            isRotating = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        interactionDelegate?.userTapped(self)
    }
}
