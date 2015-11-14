//
//  PickerViewWrapper.swift
//  DownTo
//
//  Created by Christopher Fu on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import UIKit

class PickerViewWrapper : UIView {
    override func drawRect(rect: CGRect) {
        let toolbar = UIToolbar.init(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        let fixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixedSpace.width = 200
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: nil)
        let toolbarItems = [fixedSpace, doneButton]
        toolbar.setItems(toolbarItems, animated: false)
    }
}