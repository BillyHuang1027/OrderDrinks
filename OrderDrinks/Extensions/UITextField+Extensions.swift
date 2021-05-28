//
//  UITextField+Extensions.swift
//  OrderDrinks
//
//  Created by 黃昌齊 on 2021/5/26.
//

import Foundation
import UIKit

extension OrderTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.setPickerView(selectedAt: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
}
