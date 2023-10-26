//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  
  weak var coordinator: MainCoordinator?
  
  private let spacing:CGFloat = 20
  private let viewModel = HomeViewModel()
  private lazy var header = CashFocusHeader()
  private lazy var addProjectButton = CashFocusButton(
    iconName: Icons.plus.rawValue,
    label: "Add New Project",
    color:  .white,
    fontSize: 30,
    iconSize: 15
  )
  
  private lazy var projectsTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let emptyScreen = EmptyProjectsView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  @objc func onPressAddNewProject() {
    coordinator?.onPressNewProject()
  }
  
  @objc func onPressSettings() {
    coordinator?.onPressSettigs()
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setup() {
    setupView()
    setupHeader()
    setupAddProjectButton()
    setupTableView()
  }
  
  func setupView() {
    view.backgroundColor = .systemBackground
  }
  
  func setupHeader() {
    view.addSubview(header)
    
    header.button.addTarget(self, action: #selector(onPressSettings), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
      header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
      header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      header.heightAnchor.constraint(equalToConstant: 30),
    ])
  }
  
  
  func setupAddProjectButton() {
    view.addSubview(addProjectButton)
    
    addProjectButton.startAnimationPressButton()
    addProjectButton.addTarget(self, action: #selector(onPressAddNewProject), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      addProjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
      addProjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
      addProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      addProjectButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
  

  func setupTableView() {
    view.addSubview(projectsTableView)
    
    projectsTableView.delegate = self
    projectsTableView.dataSource = self
    
    NSLayoutConstraint.activate([
      projectsTableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: spacing),
      projectsTableView.bottomAnchor.constraint(equalTo: addProjectButton.topAnchor, constant: -spacing),
      projectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      projectsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if viewModel.projectsList.count == 0 {
      projectsTableView.onProjectListIsEmpty()
    } else {
      projectsTableView.onRestore()
    }
  
    return viewModel.projectsList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "Hello World"
    return cell
  }
}


#Preview {
  HomeViewController()
}
