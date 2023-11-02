//
//  CashFocusHeader.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-21.
//

import UIKit

class CashFocusHeader: UIView {
  
  lazy var button = CashFocusIconButton(
    iconName: Icons.gearshapeFill.rawValue,
    color: .systemGreen,
    fontSize: 20
  )
  
  private lazy var title = CashFocusLabel(
    text: "Hello! 🤑",
    textAlignment: .left,
    font: "Nunito-Bold",
    size: 25
  )
  
  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    return stack
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CashFocusHeader {
  func setup() {

    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(stackView)
    stackView.addArrangedSubview(title)
    stackView.addArrangedSubview(button)

    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
    ])
  }
}
