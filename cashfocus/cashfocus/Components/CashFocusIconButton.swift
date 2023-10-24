//
//  CashFocusIconButton.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-21.
//

import UIKit

class CashFocusIconButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  init(iconName: String, color: UIColor, fontSize: CGFloat ) {
    super.init(frame: .zero)
    self.setImage(
      UIImage(
        systemName: iconName,
        withConfiguration:
          UIImage.SymbolConfiguration(
            font: UIFont.systemFont(ofSize: fontSize)
          )), for: .normal)
    self.tintColor = color
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CashFocusIconButton {
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}


#Preview {
  let button = CashFocusIconButton(
    iconName: Icons.elipseCircle.rawValue,
    color: .systemGreen,
    fontSize: 30)
  return button
}
