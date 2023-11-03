//
//  SettingsViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class SettingsViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  
  private lazy var nextScreenButton: UIButton = {
    var button = UIButton()
    button.setTitle("Next Screen", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(onPressNextScreen), for: .touchUpInside)
    button.backgroundColor = .systemGreen
    return button
  }()
  
  private lazy var backButton: UIBarButtonItem = {
    var button = UIBarButtonItem()
    button.title = "Back"
    return button
  }()
  
  
  @objc func onPressNextScreen() {
    coordinator?.onPressAccount()
  }
  
  @objc func onPressCancel() {
    navigationController?.dismiss(animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

extension SettingsViewController {
  func setup() {
    view.backgroundColor = .systemBackground
    navigationItem.title = "Settings"
    navigationItem.largeTitleDisplayMode = .automatic
    navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    
    view.addSubview(nextScreenButton)
    
    NSLayoutConstraint.activate([
      nextScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nextScreenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}
