//
//  MessageComposer.swift
//  VHP
//
//  Created by Jitendra Bhadja on 20/06/16.
//  Copyright © 2016 Jitendra Bhadja. All rights reserved.
//

import UIKit
import MessageUI

//let textMessageRecipients = ["1-800-867-5309"]

class MessageComposer: NSObject,MFMessageComposeViewControllerDelegate {

    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(_ strNumber:String) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        let textMessageRecipients = [strNumber]
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey friend - Just download VHP from appstore"
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
