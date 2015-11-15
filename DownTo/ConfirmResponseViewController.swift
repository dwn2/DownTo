//
//  ConfirmResponse.swift
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
    
    var eventLabelText = String()
    var nameLabelText = String()
    var timeLabelText = String()
    
    override func viewDidLoad() {
//        eventLabel.text = "My event"
        nameLabel.text = "by " + nameLabelText
//        timeLabel.text = "A 10:30"
    }
}