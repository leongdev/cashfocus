//
//  SettingsViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class SettingsViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  
  private lazy var CloseButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(
      barButtonSystemItem: .close,
      target: self,
      action: #selector(onPressCancel)
    )
    return button
  }()
  
  private lazy var nextScreenButton: UIButton = {
    var button = UIButton()
    button.setTitle("Next Screen", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(onPressNextScreen), for: .touchUpInside)
    button.backgroundColor = .systemGreen
    return button
  }()
  
  @objc func onPressNextScreen() {
    let vc = AccountViewController()
    let navigation = UINavigationController(rootViewController: vc)
    
    navigation.modalPresentationStyle = .pageSheet
    
    self.present(navigation, animated: true)
  }
  
  @objc func onPressCancel() {
    navigationController?.dismiss(animated: true)
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
    navigationItem.rightBarButtonItem = CloseButton
    
    view.addSubview(nextScreenButton)
    
    NSLayoutConstraint.activate([
      nextScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nextScreenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

#Preview {
  SettingsViewController()
}
