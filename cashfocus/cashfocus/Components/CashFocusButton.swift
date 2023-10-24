//
//  CashFocusButton.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class CashFocusButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  init(iconName: String, label:String, color: UIColor, fontSize: CGFloat, iconSize: CGFloat ){
    super.init(frame: .zero)
    self.setImage(
      UIImage(
        systemName: iconName,
        withConfiguration:
          UIImage.SymbolConfiguration(
            font: UIFont.systemFont(ofSize: iconSize)
          )), for: .normal)
    self.setTitle(label, for: .normal)
    self.setTitleColor(color, for: .normal)
    self.tintColor = color
    setup()
  }
}

private extension CashFocusButton {
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false

  
    var config = UIButton.Configuration.filled()
    config.baseBackgroundColor = .systemGreen
    config.cornerStyle = .medium
    config.automaticallyUpdateForSelection = false
    
    self.configuration = config
  
    self.layer.shadowColor = UIColor.CashFocusTheme.secondary.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
    self.layer.masksToBounds = false
  }
}

#Preview {
  let button = CashFocusButton(
    iconName: Icons.plus.rawValue,
    label: "Add new project",
    color: .white,
    fontSize: 20,
    iconSize: 15
  )
  return button
}
