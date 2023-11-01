//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  weak var coordinator: MainCoordinator?
  private let viewModel = HomeViewModel()
  
  private let spacing:CGFloat = 20

  private lazy var header = CashFocusHeader()
  private lazy var addProjectButton = CashFocusButton(
    iconName: Icons.plus.rawValue,
    label: "Add New Project",
    color:  .white,
    fontSize: 30,
    iconSize: 15
  )
  
  lazy var projectsTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CashFocusProjectsCell.self, forCellReuseIdentifier: CashFocusProjectsCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let emptyScreen = EmptyProjectsView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool){
    viewModel.getAllProjects()
    projectsTableView.reloadData()
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CashFocusProjectsCell.identifier, for: indexPath) as? CashFocusProjectsCell else {
      fatalError("The table view could not dequeue a CustomCell in ViewController")
    }
    cell.textLabel?.text = viewModel.projectsList[indexPath.row].projectName
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Clicked \(indexPath.row)")
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          viewModel.deleteProjectItem(item: viewModel.projectsList[indexPath.row])
          viewModel.getAllProjects()
          tableView.reloadData()
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
      }
  }
}
