//
//  AttendanceViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/15/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class AttendanceViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myUser: User?
    var otherUsers: [User] = []
    var invitedUsers: [User] = []
    var eventName: String?
    var locationName: String?
    var initialTimeLeft: Int?
    var timeLeft: Countdown?
    var client: MSClient!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        client = delegate.client!
        navigationItem.title = "Event: \(eventName!)"
        locationLabel.text = locationName!
        timeLabel.text = String(timeLeft!)
        print("\(timeLeft?.currentMinutes) \(timeLeft?.currentSeconds)")
        print("invited users: \(invitedUsers)")
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
            while !self.timeLeft!.done {
                sleep(1)
                self.timeLeft!.decrement()
                dispatch_async(dispatch_get_main_queue()) {
                    self.timeLabel.text = String(self.timeLeft!)
                }
            }
        }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            while true {
                let eventTable = self.client.tableWithName("Events")
                while true {
                    let predicate = NSPredicate.init(format: "(creator_userid == %@) AND (name == %@) AND (location == %@) AND (time == %@)", argumentArray: [(self.myUser?.id)!, self.eventName!, self.locationName!, self.initialTimeLeft!])
                    eventTable.readWithPredicate(predicate, completion: {
                        (result, error) in
                        if error != nil {
                            print("Error: \(error)")
                        }
                        else {
                            print("Polling results: \(result.items.count) array: \(self.invitedUsers)")
                            var tmpArray: [User] = []
                            for (j, item) in result.items.enumerate() {
                                let dict = item as! [String: AnyObject]
                                let tmpUser = User.init(name: dict["receiver_name"] as! String, id: dict["receiver_userid"] as! String)
                                let index = self.invitedUsers.indexOf({
                                    $0.name == tmpUser.name && $0.id == tmpUser.id
                                })
                                if index != nil {
                                    tmpArray.append(self.invitedUsers[j])
                                }
                            }
                            self.invitedUsers = tmpArray
                        }
                    })
                    sleep(5)
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitedUsers.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("attendanceCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = invitedUsers[indexPath.row].name
        return cell
    }

    func removeRowFromTableView(row: Int) {
        self.invitedUsers.removeAtIndex(row)
    }
}