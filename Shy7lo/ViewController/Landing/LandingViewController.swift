//
//  LandingViewController.swift
//  Shy7lo
//
//  Created by jitendra bhadja on 22/08/16.
//  Copyright © 2016 jitendra bhadja. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    //MARK:- View life cycle
    
    @IBOutlet weak var runkeeperSwitch4: DGRunkeeperSwitch!
    
    @IBOutlet weak var btnKuwait: UIButton!
    @IBOutlet weak var btnOman: UIButton!
    @IBOutlet weak var btnDubai: UIButton!
    @IBOutlet weak var btnSaudiArabia: UIButton!
    @IBOutlet weak var btnQatar: UIButton!
    @IBOutlet weak var btnBahrin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("sdasd asd sdadas")
        
        if let runkeeperSwitch4 = runkeeperSwitch4 {
            runkeeperSwitch4.titles = ["English", "Arabic"]
            runkeeperSwitch4.backgroundColor = UIColor.blackColor()
            runkeeperSwitch4.selectedBackgroundColor = .whiteColor()
            runkeeperSwitch4.titleColor = .whiteColor()
            runkeeperSwitch4.selectedTitleColor = UIColor.blackColor()
            runkeeperSwitch4.titleFont = UIFont(name: "Raleway-SemiBold", size: 14.0)
        }
        
        // Do any additional setup after loading the view.
    }

    //MARK:- Action zones
    @IBAction func switchValueDidChange(sender: AnyObject)
    {
        print(sender.selectedIndex)
    }
    
    @IBAction func btnArabicAction(sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        if btn.selected == true
        {
            btn.selected = false
        }
        else
        {
            btn.selected = true
        }
    }
    @IBAction func btnEnglishAction(sender: AnyObject)
    {
        let btn:UIButton = sender as! UIButton
        
        if btn.selected == true
        {
            btn.selected = false
        }
        else
        {
            btn.selected = true
        }
    }
    @IBAction func btnLanguageAction(sender: AnyObject)
    {
        self.btnOman.selected = false
        self.btnDubai.selected = false
        self.btnQatar.selected = false
        self.btnBahrin.selected = false
        self.btnKuwait.selected = false
        self.btnSaudiArabia.selected = false
        
        let btn:UIButton = sender as! UIButton
        
        if btn.selected == true {
            
            btn.selected = false
        }
        else
        {
            btn.selected = true
        }
        
    }
    
    @IBAction func btnNextAction(sender: AnyObject) {
    }
    //MARK:- Memory managment method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
