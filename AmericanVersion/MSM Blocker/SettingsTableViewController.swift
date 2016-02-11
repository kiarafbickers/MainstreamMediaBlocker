//
//  SettingsTableViewController.swift
//  Mainstream Media Blocker
//
//  Created by Kiara Robles on 1/31/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate
{
    var contentField: UITextField!
    
    // MARK: - View Lifecyle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        let userSettings = NSUserDefaults.standardUserDefaults()
        if !(userSettings.boolForKey("seenTutorial")) {
            self.performSegueWithIdentifier("showTutorialSegue", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.section == 0) && (indexPath.row == 0) {
            performSegueWithIdentifier("segueMediaOutletTableView", sender: nil)
        }
        if (indexPath.section == 1) && (indexPath.row == 1) {
            if MFMailComposeViewController.canSendMail() {  // Checking if mail is available
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                
                // Configure the view controller:
                composeVC.setToRecipients(["contact.mainstreammediablocker@gmail.com"])
                composeVC.setSubject("Feedback to MSM Blocker")
                composeVC.setMessageBody("My Feedback", isHTML: false)
                
                // Presenting the view controller:
                self.presentViewController(composeVC, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - MFMailComposeViewController
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        if result == MFMailComposeResultFailed {
            print("Error sending mail.")
        }
        
        // Dismiss the mail compose view controller
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
