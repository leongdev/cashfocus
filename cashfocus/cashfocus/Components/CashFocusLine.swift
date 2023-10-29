//
//  CashFocusLine.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-28.
//

import UIKit

class CashFocusLine: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  init(backgroundColor: UIColor) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CashFocusLine {
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

