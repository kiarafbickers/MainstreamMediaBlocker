//
//  MediaTableViewController.swift
//  MSM Blocker
//
//  Created by Kiara Robles on 1/31/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

class MediaTableViewController: UITableViewController
{
    var mediaOutlets = [String]()
    
    // MARK: - View Lifecyle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Blocked Media Outlets"
        tableView.allowsSelection = false
        
        self.mediaOutlets.append("ABC News")
        self.mediaOutlets.append("Al Jazeera")
        self.mediaOutlets.append("BBC")
        self.mediaOutlets.append("Bloomberg")
        self.mediaOutlets.append("CBS News")
        self.mediaOutlets.append("CNN")
        self.mediaOutlets.append("Fox News")
        self.mediaOutlets.append("MSNBC")
        self.mediaOutlets.append("NBC")
        self.mediaOutlets.append("NPR: National Public Radio")
        self.mediaOutlets.append("New York Times")
        self.mediaOutlets.append("PBS: Public Broadcasting Service")
        self.mediaOutlets.append("The Daily Show")
        self.mediaOutlets.append("The Glenn Beck Program")
        self.mediaOutlets.append("The Guardian")
        self.mediaOutlets.append("The Huffington Post")
        self.mediaOutlets.append("The New Yorker")
        self.mediaOutlets.append("The Rachel Maddow Show")
        self.mediaOutlets.append("The Rush Limbaugh")
        self.mediaOutlets.append("The Sean Hannity Show")
        self.mediaOutlets.append("The Wall Street Journal")
        self.mediaOutlets.append("USA Today")
        self.mediaOutlets.append("Washington Post")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Data Source Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.mediaOutlets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mediaOutlet") as UITableViewCell!
        
        cell.textLabel?.text = self.mediaOutlets[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        func statusBarHeight() -> CGFloat {
            let statusBarSize = UIApplication.sharedApplication().statusBarFrame.size
            return Swift.min(statusBarSize.width, statusBarSize.height)
        }
        
        let screenHeight: CGFloat = self.view.frame.height - (self.navigationController?.navigationBar.frame.height)! - statusBarHeight()
        let cellHeight: CGFloat
        
        if DeviceType.IS_IPHONE_4_OR_LESS {
            cellHeight = screenHeight / 8
        }
        else {
            cellHeight = screenHeight / 10
        }
        
        return cellHeight;
    }
}
