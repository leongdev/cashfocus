//
//  AccountViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-26.
//

import UIKit

class AccountViewController: UIViewController {
  
  private lazy var CloseButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(
      barButtonSystemItem: .close,
      target: self,
      action: #selector(onPressCancel)
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  @objc func onPressCancel() {
    navigationController?.dismiss(animated: true)
  }
}

extension AccountViewController {
  func setup() {
    view.backgroundColor = .systemBackground
    navigationItem.title = "Account"
    navigationItem.largeTitleDisplayMode = .automatic
    navigationItem.rightBarButtonItem = CloseButton
  }
}
