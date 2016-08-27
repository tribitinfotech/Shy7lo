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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("sdasd asd sdadas")
        
        // Do any additional setup after loading the view.
    }

    //MARK:- Action zones
    
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
        let btn:UIButton = sender as! UIButton
        
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
