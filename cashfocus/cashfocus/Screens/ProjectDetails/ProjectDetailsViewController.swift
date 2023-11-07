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
    
    let edit = UIAction(title: "Edit Name", image:  UIImage(systemName: Icons.pencil.rawValue)) { _ in
      
    }
    
    let delete = UIAction(title: "Delete Project", image: UIImage(systemName: Icons.trash.rawValue), attributes: .destructive) { _ in
      
    }
    
    let menu = UIMenu(children: [ edit, delete])

    delete.image?.withTintColor(.systemGreen)
    
    button.menu = menu
    button.showsMenuAsPrimaryAction = true
    
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
