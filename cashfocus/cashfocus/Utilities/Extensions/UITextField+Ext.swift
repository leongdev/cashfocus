//
//  UITextField+Ext.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-29.
//

import UIKit

extension UITextField {
  func addDoneButtonOnKeyboard(name: String, color: UIColor){
      let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
      doneToolbar.barStyle = .default

      let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let done: UIBarButtonItem = UIBarButtonItem(title: name, style: .done, target: self, action: #selector(self.doneButtonAction))
      done.tintColor = color
    
      let items = [flexSpace, done]
      doneToolbar.items = items
      doneToolbar.sizeToFit()

      self.inputAccessoryView = doneToolbar
      
  }

  @objc func doneButtonAction() {
    self.resignFirstResponder()
  }
}
