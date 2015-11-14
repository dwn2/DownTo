//
//  ActiveInvitesViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class Invite {
    var creatorName: String
    var time: NSDate
    var eventName: String
    
    init(creatorName: String, time: NSDate, eventName: String) {
        self.creatorName = creatorName
        self.time = time
        self.eventName = eventName
    }
    
}

class ActiveInvitesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    var invites: [Invite] = []
    
    override func viewDidLoad() {
        invites.append(Invite.init(creatorName: "Chris", time: NSDate.init(), eventName: "Lunch"))
        invites.append(Invite.init(creatorName: "Ryan", time: NSDate.init(), eventName: "Chill"))
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
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        println(currentCell.textLabel!.text)
        
        return myCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController : ConfirmResponseViewController = segue.destinationViewController as! ConfirmResponseViewController
        
        NSIndexPath selectedIndexPath = [tableView indexPathForSelectedRow]
        
        DestViewController.eventLabelText =
        DestViewController.nameLabelText =
        DestViewController.timeLabelText = myTableView.cellForRowAtIndexPath(<#T##indexPath: NSIndexPath##NSIndexPath#>)
    }
    
    
}