//
//  CashFocusLabel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-21.
//

import UIKit

class CashFocusLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  init(text: String, textAlignment: NSTextAlignment) {
    super.init(frame: .zero)
    self.text = text
    self.textAlignment = textAlignment
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CashFocusLabel {
  func setup() {
    self.font = UIFont(name: "Nunito-Bold", size: 25)
    self.textColor = .label
    self.adjustsFontSizeToFitWidth = true
    self.minimumScaleFactor = 1
    self.lineBreakMode = .byTruncatingTail
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

#Preview {
  let label = CashFocusLabel(text: "Hello! 🤑", textAlignment: .left)
  return label
}
