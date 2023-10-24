//
//  UITableView+Ext.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

extension UITableView {
  func onProjectListIsEmpty() {
    let empty = EmptyProjectsView()
    let view = UIView()
    view.addSubview(empty)

    empty.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    empty.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
    
    self.isScrollEnabled  = false
    self.backgroundView   = view
  }
  
  func onRestore() {
    self.backgroundView   = nil
    self.isScrollEnabled  = true
  }
}
