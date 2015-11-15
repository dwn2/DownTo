//
//  ActiveInvitesViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

//class Invite { //    var creatorName: String
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
//    var times: [Countdown] = []
    var selectedIndex = 0
    var updateList: [Event] = []
//    var updateTime: [Countdown] = []
    var client: MSClient!

    var myUser: User?
    var otherUsers: [User] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        client = delegate.client!
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        invites.append(Event.init(creatorName: "Chris", eventTime: NSDate.init(), eventName: "Lunch", eventLocation: "Hooters"))
//        invites.append(Event.init(creatorName: "Ryan", eventTime: NSDate.init(), eventName: "Chill", eventLocation: "Narnia"))

        self.myTableView.addSubview(self.refreshControl)
        
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
//            while self.times.count > 0 {
//                for index in 0...self.times.count-1 {
//                    
//                    sleep(1)
//                    self.times[index].decrement()
//                    dispatch_async(dispatch_get_main_queue()) {
//                        //self.timeLabel.text = String(self.times[index]!)
//                        self.myTableView.reloadData()
//                    }
//                }
//            }
//        }
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
        myCell.detailTextLabel?.text = "\(invites[indexPath.row].eventTime):00"
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
        //Creates updateList array with new events
        update()

    }
    
    //This funcation gives a chance to access all events that the current user is invited to
    func update() {
        self.updateList = []
        self.invites = []
//        self.updateTime = []
//        self.times = []
        
        let usersTable = self.client.tableWithName("Events")
        //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"complete == NO"];
        let predicate = NSPredicate.init(format: "receiver_userid == %@", myUser!.id)
//        usersTable.readWithCompletion({
        usersTable.readWithPredicate(predicate, completion: {
            (result, error2) in
            if error2 != nil {
                print(error2)
            }
            else {
                for item in result.items {
                    print(item)
                    print(String(item["receiver_userid"]))
                    print(self.client.currentUser.userId)
//                    if item["receiver_userid"] as! String == self.client.currentUser.userId {

                        self.updateList.append(Event.fromDictionary(item as! [String: AnyObject]))
                        print("array: \(self.updateList)")
                    
//                    
//                    let eventLengthItem = item["time"] as! Int
//                    let stringItem = item["__createdAt"] as! String
//                    self.updateTime.append(Countdown.init(timeOfCreation: stringItem, eventLength: eventLengthItem))
//                    
//                    }
                }

                if self.updateList.count != 0 {
                    for index in 0...self.updateList.count-1 {
                        self.invites.append(self.updateList[index])
//                        self.times.append(self.updateTime[index])
                    }
                }

                self.myTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    
}
