//
//  ProjectDetailsViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-11-03.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

  var projectIndex: Int = 0
  
  weak var coordinator: MainCoordinator?
  private let viewModel = ProjectDetailsViewModel()
  
  private lazy var menuButton: CashFocusIconButton = {
    let button =   CashFocusIconButton(
      iconName: Icons.elipseCircle.rawValue,
      color: .systemGreen,
      fontSize: 20
    )
    
    button.addTarget(self, action: #selector(onPressMenu), for: .touchUpInside)
    return button
  }()
  
  private lazy var backButton: UIBarButtonItem = {
    var button = UIBarButtonItem()
    button.title = "Back"
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.setNavigationBarHidden(false, animated: true)
    viewModel.getAllProjects()
  }
  
  @objc func onPressMenu() {
      print("Presse Menu")
  }
}

extension ProjectDetailsViewController {
  func setup() {
    setupView()
  }
  
  func setupView() {
    view.backgroundColor = .systemBackground
    navigationItem.title = viewModel.projectsList[projectIndex].projectName
    navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
  }
}
