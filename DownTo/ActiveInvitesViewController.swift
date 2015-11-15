//
//  ActiveInvitesViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

//class Invite {
//    var creatorName: String
//    var time: NSDate
//    var eventName: String
//    
//    init(creatorName: String, time: NSDate, eventName: String) {
//        self.creatorName = creatorName
//        self.time = time
//        self.eventName = eventName
//    }
//
//}

class ActiveInvitesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    var invites: [Event] = []
    var selectedIndex = 0
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        invites.append(Event.init(creatorName: "Chris", eventTime: NSDate.init(), eventName: "Lunch", eventLocation: "Hooters"))
        invites.append(Event.init(creatorName: "Ryan", eventTime: NSDate.init(), eventName: "Chill", eventLocation: "Narnia"))
        
        self.myTableView.addSubview(self.refreshControl)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        selectedIndex = indexPath.row
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return invites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let myCell = tableView.dequeueReusableCellWithIdentifier("prototype1", forIndexPath: indexPath) as UITableViewCell
        
        myCell.textLabel?.text = "\(invites[indexPath.row].creatorName): Down 2 \(invites[indexPath.row].eventName)"
        myCell.detailTextLabel?.text = "Time"
        myCell.tag = indexPath.row
        
        return myCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController : ConfirmResponseViewController = segue.destinationViewController as! ConfirmResponseViewController
        destViewController.nameLabelText = invites[selectedIndex].creatorName
        //destViewController.timeLabelText =
        
        //let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
        
        //DestViewController.eventLabelText =
        //DestViewController.nameLabelText =
       // DestViewController.timeLabelText = myTableView.cellForRowAtIndexPath(<#T##indexPath: NSIndexPath##NSIndexPath#>)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        self.myTableView.reloadData()
        refreshControl.endRefreshing()
    }
}