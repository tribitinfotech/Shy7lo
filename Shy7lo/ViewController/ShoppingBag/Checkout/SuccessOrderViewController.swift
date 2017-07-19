//
//  SuccessOrderViewController.swift
//  Shy7lo
//
//  Created by Jitendra bhadja on 22/04/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

import UIKit

class SuccessOrderViewController: UIViewController {

    @IBOutlet weak var btnConituneShopping: UIButton!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblStaticOrderID: UILabel!
    @IBOutlet weak var lblOrderPlaced: UILabel!
    @IBOutlet weak var lblCongratulation: UILabel!
    
    var orderID:String?
    
    var appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblOrderID.text = self.orderID
        self.lblOrderPlaced.text = appDel.mapping?.string(forKey: "Order placed successfully")
        self.lblStaticOrderID.text = appDel.mapping?.string(forKey: "order ID")
        self.lblCongratulation.text = appDel.mapping?.string(forKey: "congratulations")
        self.btnConituneShopping.setTitle(appDel.mapping?.string(forKey: "Continue shopping").uppercased(), for: UIControlState.normal)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnContinueSHoppingAction(_ sender: Any)
    {
        if (NSLocale.preferredLanguages[0] ).contains("ar") == true
        {
            (self.tabBarController?.viewControllers?[4] as! UINavigationController).popToRootViewController(animated: true)
            self.tabBarController?.selectedIndex = 4
            
            let transition = CATransition()
            transition.duration = 0.45
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            navigationController?.view?.layer.add(transition, forKey: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        else
        {
            (self.tabBarController?.viewControllers?[0] as! UINavigationController).popToRootViewController(animated: true)
            self.tabBarController?.selectedIndex = 0
            
            self.navigationController?.popToRootViewController(animated: true)
        }

    }
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
