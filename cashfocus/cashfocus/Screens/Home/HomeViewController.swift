//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  
  let spacing:CGFloat = 20
  
  private lazy var header = CashFocusHeader()
  private lazy var addProjectButton = CashFocusButton(
    iconName: IconButtons.plus.rawValue,
    label: "Add New Project",
    color:  .white,
    fontSize: 30,
    iconSize: 15
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  @objc func onPressButton() {
    addProjectButton.startAnimationPressButton()
  }
}

private extension HomeViewController {
  func setup() {
    view.backgroundColor = .systemBackground

    view.addSubview(header)
    view.addSubview(addProjectButton)
    
    addProjectButton.addTarget(self, action: #selector(onPressButton), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    
    NSLayoutConstraint.activate([
      header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
      header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
      header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      addProjectButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
      addProjectButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
      addProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      addProjectButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}


#Preview {
  HomeViewController()
}
