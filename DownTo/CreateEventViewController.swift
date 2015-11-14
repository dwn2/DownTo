//
//  ViewController.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var downToField: UITextField!
    @IBOutlet weak var meetAtField: UITextField!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var pickerWrapperView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    var isPickerWrapperViewActive: Bool = true
    let pickerWrapperViewHeight: CGFloat = 260
    var timeValue: Int = 5

    let timeChoices = [5, 10, 15, 20, 25, 30]

    var client: MSClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeButton.setTitle(String(timeValue), forState: UIControlState.Normal)
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        client = delegate.client!
    }



    override func viewWillAppear(animated: Bool) {
        if isPickerWrapperViewActive {
            dismissPickerWrapperView()
        }
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
        let oldFrame = pickerWrapperView.frame
        let oldOrigin = pickerWrapperView.frame.origin
        print("oldFrame: \(oldFrame)")
        print("oldOrigin: \(oldOrigin)")
        if !isPickerWrapperViewActive {
            showPickerWrapperView()
        }
        else {
            dismissPickerWrapperView()
        }
        print("new frame: \(pickerWrapperView.frame)")
    }

    @IBAction func dismissPickerWrapperView() {
        heightConstraint.constant = -pickerWrapperViewHeight
        UIView.animateWithDuration(0.1, animations: {
            self.view.layoutIfNeeded()
        })
        timeButton.setTitle(String(timeValue), forState: UIControlState.Normal)
        isPickerWrapperViewActive = false
    }

    @IBAction func showPickerWrapperView() {
        heightConstraint.constant = 0
        UIView.animateWithDuration(0.1, animations: {
            self.view.layoutIfNeeded()
        })
        isPickerWrapperViewActive = true
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeChoices.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeChoices[row])
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeValue = timeChoices[row]
        timeButton.setTitle(String(timeValue), forState: UIControlState.Normal)
    }

    @IBAction func createEvent() {
        let item: [String: AnyObject] = ["name": downToField.text!,
            "time": Int(timeButton.titleLabel!.text!)!,
            "location": meetAtField.text!]
        let itemTable = client.tableWithName("Events")
        print("\(itemTable)")
        itemTable.insert(item) {
            (insertedItem, error) in
            if error != nil {
                print("Error \(error.description)")
            }
            else {
                print("Ayy lmao")
            }
        }
    }
}

