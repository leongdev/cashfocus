//
//  NewProjectViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class NewProjectViewController: UIViewController {
  
  weak var coordinator: MainCoordinator?
  private let viewModel = NewProjectViewModel()
  
  private lazy var AddButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onPressAdd))
    button.tintColor = .systemGreen
    //button.isEnabled = test.isEmpty
    return button
  }()
  
  private lazy var CancelButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onPressCancel))
    button.tintColor = .systemGreen
    return button
  }()
  
  private lazy var NameTextField: UITextField = {
    let textField  = UITextField()
    textField.text = "Aobah"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  @objc func onPressAdd() {
    
  }
  
  @objc func onPressCancel() {
    self.dismiss(animated: true)
  }
}

private extension NewProjectViewController {
  func setup() {
    navigationItem.title = "New Project"
    navigationItem.rightBarButtonItem = AddButton
    navigationItem.leftBarButtonItem = CancelButton
    view.backgroundColor = .systemBackground
    
    setupNameTextField()
  }
  
  func setupNameTextField() {
    view.addSubview(NameTextField)
    NSLayoutConstraint.activate([
      NameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      NameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

  }
}

#Preview {
  NewProjectViewController()
}
