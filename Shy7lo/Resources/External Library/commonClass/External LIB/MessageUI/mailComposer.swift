//
//  mailComposer.swift
//  VHP
//
//  Created by Jitendra Bhadja on 20/06/16.
//  Copyright © 2016 Jitendra Bhadja. All rights reserved.
//

import UIKit
import MessageUI
class mailComposer: NSObject,MFMailComposeViewControllerDelegate {

    func configuredMailComposeViewController(_ strEmail:String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([strEmail])
        mailComposerVC.setSubject("Vexel")
        mailComposerVC.setMessageBody("Hey friend - Just download Vexel from appstore", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
