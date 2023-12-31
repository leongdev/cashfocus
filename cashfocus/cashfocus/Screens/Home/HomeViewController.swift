//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  
  let playButton = UIImage(systemName: Icons.playCircleFill.rawValue,withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40))) ?? UIImage(resource: .pig)
  let pauseButton = UIImage(systemName: Icons.pauseCircleFill.rawValue,withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40))) ?? UIImage(resource: .pig)
  
  weak var coordinator: MainCoordinator?
  private let viewModel = HomeViewModel()

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
  
  lazy var seartchBar: UISearchController = {
    let search = UISearchController()
    search.searchResultsUpdater = self
    return search
  }()
  
  private let emptyView = EmptyProjectsView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(onAppGoesToBackground), name: UIApplication.willTerminateNotification, object: nil)
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool){
    viewModel.getAllProjects()
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.prefersLargeTitles = true
    projectsTableView.reloadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  // MARK: - Functions
  
  @objc func onPressAddNewProject() {
    coordinator?.onPressNewProject()
  }  
  
  @objc func onAppGoesToBackground() {
    viewModel.stopTimer()
  }
}

// MARK: - Constraints
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
  
  func setup() {
    setupView()
    setupTableView()
    setupAddProjectButton()
  }
  
  func setupView() {
    view.backgroundColor = .systemBackground
    projectsTableView.contentInsetAdjustmentBehavior = .never
    
    navigationItem.title = "Hello! 🤑"
    navigationItem.searchController = seartchBar
    
    navigationItem.largeTitleDisplayMode = .automatic
    navigationController?.navigationBar.sizeToFit()
  }
  
  func setupAddProjectButton() {
    view.addSubview(addProjectButton)
    
    addProjectButton.startAnimationPressButton()
    addProjectButton.addTarget(self, action: #selector(onPressAddNewProject), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      addProjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      addProjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      addProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      addProjectButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
  
  func setupTableView() {
    view.addSubview(projectsTableView)
    
    projectsTableView.delegate = self
    projectsTableView.dataSource = self
    projectsTableView.rowHeight = 100
    projectsTableView.showsVerticalScrollIndicator = false
    projectsTableView.backgroundColor = .clear
    
    NSLayoutConstraint.activate([
      projectsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      projectsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
      projectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      projectsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
  
  // MARK: - Delegates
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }
    viewModel.searchText = text
    projectsTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if viewModel.getProjectListFilered().count == 0 {
      projectsTableView.onProjectListIsEmpty()
    } else {
      projectsTableView.onRestore()
    }
    
    return viewModel.getProjectListFilered().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CashFocusProjectsCell.identifier, for: indexPath) as? CashFocusProjectsCell else {
      return UITableViewCell()
    }
    
    cell.title.text =  viewModel.getProjectListFilered()[indexPath.row].projectName
    cell.setupTimeMoney(item: viewModel.getProjectListFilered()[indexPath.row])
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    
    cell.subscribePlayButton = { [unowned self] in
      viewModel.onPressPlayIntem(
        index: indexPath.row,
        projectsTableView: self.projectsTableView,
        pauseButtonImage: self.pauseButton,
        playButtonImage: self.playButton
      )
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.deleteProjectItem(item: viewModel.getProjectListFilered()[indexPath.row], index: indexPath.row)
      viewModel.getAllProjects()
      projectsTableView.reloadData()
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
}
