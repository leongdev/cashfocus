//
//  NewProjectViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class NewProjectViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    view.backgroundColor = .systemBackground
  }
}

private extension NewProjectViewController {
  func setup() {
    self.navigationItem.title = "Bar Title" 
  }
}
