//  DownTo
//
//  Created by Ryan McCaffrey on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class ConfirmResponseViewController : UIViewController {
    
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    //@IBOutlet weak var notDownBtn: UIButton!
    //@IBOutlet weak var downBtn: UIButton!


    
    var eventLabelText = String()
    var nameLabelText = String()
    var timeLabelText = String()
    var client: MSClient!
    var myUser: User?
    var updateList: [Event] = []
    
    
    override func viewDidLoad() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        client = delegate.client!
        
        eventLabel.text = "dwn2 " + eventLabelText
        nameLabel.text = "by " + nameLabelText
        timeLabel.text = timeLabelText + ":00"
    }
    
    
    //This funcation removes the event if the user rejects
    func notDown() {
        self.updateList = []
        let usersTable = self.client.tableWithName("Events")
        //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"complete == NO"];
        let predicate = NSPredicate.init(format: "(receiver_userid == %@) && (creator_name == %@)", myUser!.id, nameLabel.text!)
        //        usersTable.readWithCompletion({
        usersTable.readWithPredicate(predicate, completion: {
            (result, error2) in
            if error2 != nil {
                print(error2)
            }
            else {
                for item in result.items {
                    print("Deleting \(item)")
                    usersTable.delete(item as! [NSObject : AnyObject], completion: nil)
                    //print(String(item["receiver_userid"]))
                    //print(self.client.currentUser.userId)
                    //                    if item["receiver_userid"] as! String == self.client.currentUser.userId {
                    
                    //self.updateList.append(Event.fromDictionary(item as! [String: AnyObject]))
                    //print("array: \(self.updateList)")
                    //                    }
                }
                
                /*if self.updateList.count != 0 {
                for index in 0...self.updateList.count-1 {
                self.invites.append(self.updateList[index])
                }
                }*/
                
                //self.myTableView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        })
    }
    

    @IBAction func downButtonPressed(sender: AnyObject) {

    }
    
    @IBAction func notDownButtonPressed(sender: AnyObject) {
        
    }
    
    //Changes event to accepted if user accepts
    func down() {
        self.updateList = []
        let usersTable = self.client.tableWithName("Events")
        //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"complete == NO"];
        let predicate = NSPredicate.init(format: "receiver_userid == %@ AND creator_name == %@", argumentArray: [myUser!.id, nameLabelText])
        //        usersTable.readWithCompletion({
        usersTable.readWithPredicate(predicate, completion: {
            (result, error2) in
            if error2 != nil {
                print(error2)
            }
            else {
                for item in result.items {
                    var newItem = item as! [NSObject : AnyObject]
                    newItem["accepted"] = true
                    
                    
                    print("Acception \(item)")
                    usersTable.update(item as! [NSObject : AnyObject], completion: nil)
                    //usersTable.delete(item as! [NSObject : AnyObject], completion: nil)
                    //print(String(item["receiver_userid"]))
                    //print(self.client.currentUser.userId)
                    //                    if item["receiver_userid"] as! String == self.client.currentUser.userId {
                    
                    //self.updateList.append(Event.fromDictionary(item as! [String: AnyObject]))
                    //print("array: \(self.updateList)")
                    //                    }
                }
                
                /*if self.updateList.count != 0 {
                for index in 0...self.updateList.count-1 {
                self.invites.append(self.updateList[index])
                }
                }*/
                
                //self.myTableView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        })
    }
    
    
    
}