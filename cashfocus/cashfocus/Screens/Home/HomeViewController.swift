//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  
  private lazy var header = CashFocusHeader()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

private extension HomeViewController {
  func setup() {
    view.backgroundColor = .systemBackground

    view.addSubview(header)
    
    NSLayoutConstraint.activate([
      header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}


#Preview {
  HomeViewController()
}
