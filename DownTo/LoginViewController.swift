//
//  LoginViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    var client: MSClient!
    var myUser: User?
    var otherUsers: [User] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        client = (UIApplication.sharedApplication().delegate as! AppDelegate).client!
//        client.logout()
//        SSKeychain.deletePasswordForService("AzureMobileServiceTutorial", account: "Facebook:1217481261611695")
        loadAuthInfo()
        if client.currentUser == nil {
            client.loginWithProvider("facebook", controller: self, animated: true, completion: {
                (user: MSUser!, error: NSError!) -> () in
                self.saveAuthInfo()
                self.requestUsersList()
            })
        }
        else {
            requestUsersList()
        }
    }

    func saveAuthInfo() {
        SSKeychain.setPassword(client.currentUser.mobileServiceAuthenticationToken, forService: "AzureMobileServiceTutorial", account: client.currentUser.userId)
        //Add user to database when they authenticate
        let usr: [String: AnyObject] = ["name": client.currentUser.userId]
        let usrTable = client.tableWithName("Users")
        print("\(usrTable)")
        usrTable.insert(usr) {
            (insertedItem, error) in
            if error != nil {
                print("Error \(error.description)")
            }
            else {
                print("Ayy lmao")
            }
        }
    }

    func loadAuthInfo() {
        if let userId = SSKeychain.accountsForService("AzureMobileServiceTutorial")?[0]["acct"] as? String {
            print(SSKeychain.accountsForService("AzureMobileServiceTutorial")?[0])
            print("user id: \(userId)")
            client.currentUser = MSUser.init(userId: userId)
            client.currentUser.mobileServiceAuthenticationToken = SSKeychain.passwordForService("AzureMobileServiceTutorial", account: userId)
        }
    }

    func requestUsersList() {
        print("requesting users list")
        activityIndicator.startAnimating()
        let userTable = self.client.tableWithName("Users")
        userTable.readWithCompletion({
            (result, error) in
            if error != nil {
                print(error)
            }
            else {
                for item in result.items {
                    if item["name"] as! String == self.client!.currentUser.userId {
                        self.myUser = User(name: item["UserName"] as! String, id: item["name"] as! String)
                    }
                    else {
                        self.otherUsers.append(User(name: item["UserName"] as! String, id: item["name"] as! String))
                    }
                }
                print("my user: \(self.myUser)")
                print("other users: \(self.otherUsers)")
            }
            self.performSegueWithIdentifier("login", sender: self)
            self.activityIndicator.stopAnimating()
//            self.activityIndicator.removeFromSuperview()
        })
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.myUser = myUser
        delegate.otherUsers = otherUsers
    }
}
