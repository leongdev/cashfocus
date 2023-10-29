//
//  CashFocusTextView.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-28.
//

import UIKit

class CashFocusTextView: UITextView {
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    setup()
  }
  
  init(fontSize: CGFloat) {
    super.init(frame: .zero, textContainer: .none)
    self.font = UIFont(name: Fonts.regular.rawValue, size: fontSize)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CashFocusTextView {
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
