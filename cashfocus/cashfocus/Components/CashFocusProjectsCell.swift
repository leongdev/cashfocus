//
//  CashFocusTableViewCell.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-31.
//

import UIKit

class CashFocusProjectsCell: UITableViewCell {
  static let identifier = "ProjectsCell"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CashFocusProjectsCell {
  func setup() {
    
  }
}
