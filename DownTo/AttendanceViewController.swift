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
    var timeLeft: Countdown?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
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
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitedUsers.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("attendanceCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = invitedUsers[indexPath.row].name
        return cell
    }
}