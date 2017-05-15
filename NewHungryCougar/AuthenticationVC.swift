//
//  AuthenticationVC.swift
//  NewHungryCougar
//
//  Created by Kyle Nakamura on 4/13/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit
let classPickerData = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate", "Faculty"]


class AuthenticationVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var classPicker: UIPickerView!
    @IBOutlet weak var departmentPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        classPicker.delegate = self
        classPicker.dataSource = self
        departmentPicker.delegate = self
        departmentPicker.dataSource = self
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = classPickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classPickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classPickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
