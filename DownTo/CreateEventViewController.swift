//
//  ViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var downToField: UITextField!
    @IBOutlet weak var meetAtField: UITextField!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var pickerWrapperView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("\(textField.text!)")
        return true
    }

    @IBAction func timeLabelTapped() {
        print("Time label tapped!")
        let oldFrame = self.pickerWrapperView.frame
        let oldOrigin = self.pickerWrapperView.frame.origin
        print("oldFrame: \(oldFrame)")
        print("oldOrigin: \(oldOrigin)")
        self.pickerWrapperView.frame = CGRectMake(oldOrigin.x, oldOrigin.y - self.pickerWrapperView.frame.height, oldFrame.width, oldFrame.height)
        print("new frame: \(self.pickerWrapperView.frame)")
    }
}

