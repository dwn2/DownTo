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

    override func viewDidLoad() {
        client = (UIApplication.sharedApplication().delegate as! AppDelegate).client!
//        client.currentUser = nil
//        SSKeychain.deletePasswordForService("AzureMobileServiceTutorial", account: "Facebook:1217481261611695")
        loadAuthInfo()
        if client.currentUser == nil {
            print("\(client.currentUser)")
            client.loginWithProvider("facebook", controller: self, animated: true, completion: {
                (user: MSUser!, error: NSError!) -> () in
                print("\(error)")
                self.saveAuthInfo()
                print("\(self.client.currentUser)")
            })
        }
    }

    func saveAuthInfo() {
        SSKeychain.setPassword(client.currentUser.mobileServiceAuthenticationToken, forService: "AzureMobileServiceTutorial", account: client.currentUser.userId)
    }

    func loadAuthInfo() {
        if let userId = SSKeychain.accountsForService("AzureMobileServiceTutorial")?[0]["acct"] as? String {
            print("user id: \(userId)")
            client.currentUser = MSUser.init(userId: userId)
            client.currentUser.mobileServiceAuthenticationToken = SSKeychain.passwordForService("AzureMobileServiceTutorial", account: userId)
        }
    }
}
