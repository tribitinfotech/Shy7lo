//
//  StarshipHeader.swift
//  Shy7lo
//
//  Created by haresh on 31/12/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit

class StarshipHeader: UIView,UIScrollViewDelegate {

    @IBOutlet var imgRef: UIImageView!
    @IBOutlet var scrlProductImages: UIScrollView!
    //@IBOutlet var clctnView: UICollectionView!
    @IBOutlet weak var viewInScroll: UIView!
    var pageControl : UIPageControl = UIPageControl()
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var pageCntrlY: NSLayoutConstraint!
    @IBOutlet weak var pageCntrl: UIPageControl!
    
    override func awakeFromNib() {
        
       // clctnView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        super.awakeFromNib()
        
         NotificationCenter.default.addObserver(self, selector: #selector(btnDisbaleScrl), name: NSNotification.Name(rawValue: "disableScrl"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(brnEnableScrl), name: NSNotification.Name(rawValue: "enableScrl"), object: nil)
        
        
        
        var imgTemp:UIImageView!
        
        
        
        for i in 0..<appDel.arrCurrentProductImages.count
        {
            print(i)
            
            let imgProduct:UIImageView = UIImageView()
            //imgProduct.frame = CGRect(x: UIScreen.main.bounds.size.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.height * 400)/568)
           
            let dict:NSMutableDictionary = appDel.arrCurrentProductImages.object(at: i) as! NSMutableDictionary
            
           // let strURL:String = String(format: "%@%@",IMAGE_URL,dict.value(forKey: "image") as! String)
            
            let strURL:String = String(format: "%@",dict.value(forKey: "image") as! String)
            
            
            if isEnglish {
                imgProduct.sd_setImage(with:  NSURL(string: strURL) as URL!, placeholderImage: UIImage(named: ""), options: SDWebImageOptions.lowPriority)
            }
            
            
            imgProduct.contentMode = UIViewContentMode.scaleAspectFit
            imgProduct.translatesAutoresizingMaskIntoConstraints = false
            imgProduct.clipsToBounds = true
            self.viewInScroll.addSubview(imgProduct)

            let width = NSLayoutConstraint(item: imgProduct, attribute: .width, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: imgProduct, attribute: .height, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([width, height])

            if i==0
            {
                let horizontalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)

                let verticalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
                
                
                let bottomConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
                
                NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint,bottomConstraint])

            }
            else if i == appDel.arrCurrentProductImages.count - 1
            {
                let horizontalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: imgTemp, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
                
                let verticalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
                
                let bottomConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
                
                let trailConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
                NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint,bottomConstraint,trailConstraint])

                
            }
            else
            {
                let horizontalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: imgTemp, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
                
                let verticalConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
                
                
                let bottomConstraint = NSLayoutConstraint(item: imgProduct, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.viewInScroll, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
                NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint,bottomConstraint])

            }
            
            imgTemp = imgProduct
        }
        
        //self.pageCntrl
        
        self.scrlProductImages.delegate = self
        
        self.pageCntrl.numberOfPages = appDel.arrCurrentProductImages.count
        
        if isEnglish
        {
            self.pageCntrl.currentPage = 0
            
            
        }
        else
        {
            self.pageCntrl.currentPage = appDel.arrCurrentProductImages.count - 1
            
           print(CGFloat(appDel.arrCurrentProductImages.count - 1)*self.scrlProductImages.frame.size.width)
            
           self.perform(#selector(setOffset), with: nil, afterDelay: 0.1)

        }
        
        
        self.viewInScroll.bringSubview(toFront: self.pageCntrl)
        
        if UIScreen.main.bounds.size.width == 320 {
            
            self.pageCntrlY.constant = 150
        }
        
        self.layoutIfNeeded()
        
        // Initialization code
    }
    func setOffset()
    {
        self.scrlProductImages.contentOffset = CGPoint(x: CGFloat(appDel.arrCurrentProductImages.count - 1)*self.scrlProductImages.frame.size.width, y: 0)
        
        var count:NSInteger = appDel.arrCurrentProductImages.count - 1
        
        for item in self.viewInScroll.subviews
        {
            if item.isKind(of: UIImageView.self) {
                
                let dict:NSMutableDictionary = appDel.arrCurrentProductImages.object(at: count) as! NSMutableDictionary
                
                let strURL:String = String(format: "%@",dict.value(forKey: "image") as! String)
                
                let imgProduct:UIImageView = item as! UIImageView
                
                imgProduct.sd_setImage(with:  NSURL(string: strURL) as URL!, placeholderImage: UIImage(named: ""), options: SDWebImageOptions.lowPriority)
                
                count = count - 1
            }
        }
        
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.scrlProductImages.isScrollEnabled = true
        var pageNumber:Int = 0
        
        pageNumber = Int(round(self.scrlProductImages.contentOffset.x / self.scrlProductImages.frame.size.width))
        
        
        self.pageCntrl.numberOfPages = appDel.arrCurrentProductImages.count
        
        self.pageCntrl.currentPage = Int(pageNumber)
    }
    func btnDisbaleScrl()
    {
        self.scrlProductImages.isScrollEnabled = false
    }
    func brnEnableScrl()
    {
        self.scrlProductImages.isScrollEnabled = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
