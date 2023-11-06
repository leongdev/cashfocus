//
//  LoginVC.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-19.
//

import UIKit

class HomeViewController: UIViewController {
  
  let playButton = UIImage(systemName: Icons.playCircleFill.rawValue,withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40)))
  let pauseButton = UIImage(systemName: Icons.pauseCircleFill.rawValue,withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40)))
  
  weak var coordinator: MainCoordinator?
  private let viewModel = HomeViewModel()
  
  private let spacing:CGFloat = 20
  
  lazy var timer = BackgroundTimer(delegate: nil)

  private lazy var settingsButton: CashFocusIconButton = {
    let button =   CashFocusIconButton(
      iconName: Icons.gearshapeFill.rawValue,
      color: .systemGreen,
      fontSize: 20
    )
    
    button.addTarget(self, action: #selector(onPressSettings), for: .touchUpInside)
    return button
  }()
  

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
    return search
  }()
  
  private let emptyView = EmptyProjectsView()
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    initTimer()
  }
  
  override func viewWillAppear(_ animated: Bool){
    viewModel.getAllProjects()
    projectsTableView.reloadData()
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  // MARK: - Functions
  
  @objc func onPressAddNewProject() {
    coordinator?.onPressNewProject()
  }
  
  @objc func onPressSettings() {
    coordinator?.onPressSettigs()
  }
  
  func initTimer() {
    let timerId = timer.executeAfterDelay(delay: 1, repeating: true) {
      self.viewModel.onTimeUpdate()
      
      self.projectsTableView.visibleCells.forEach { cell in
        let index = self.projectsTableView.visibleCells.firstIndex(of: cell) ?? 0
        
        
        if let cell = cell as? CashFocusProjectsCell {
          if self.viewModel.timerIdList.contains(index) {
            cell.actionButton.setImage(self.pauseButton, for: .normal)
          } else {
            cell.actionButton.setImage(self.playButton, for: .normal)
          }
          
          cell.timePrice.text = self.viewModel.calculateMoney(time: self.viewModel.projectsCoreDataList[index].projectTime, hourlyRate: self.viewModel.projectsCoreDataList[index].projectHourlyRate)
          cell.time.text = self.viewModel.calculateTime(time: self.viewModel.projectsCoreDataList[index].projectTime)
        }
      }
    }
    
    self.viewModel.timerId = timerId
  }
  
  func onSelectItem(itemIndex: Int) {
    coordinator?.onPressProjectDetails(projectIndex: itemIndex)
  }
}


// MARK: - Constraints
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setup() {
    setupView()
    setupTableView()
    setupAddProjectButton()
  }
  
  func setupView() {
    view.backgroundColor = .systemBackground
    projectsTableView.contentInsetAdjustmentBehavior = .never
    
    navigationItem.title = "Hello! 🤑"
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    navigationItem.searchController = seartchBar
    
    navigationItem.largeTitleDisplayMode = .automatic
    navigationController?.navigationBar.sizeToFit()
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if viewModel.projectsCoreDataList.count == 0 {
      projectsTableView.onProjectListIsEmpty()
    } else {
      projectsTableView.onRestore()
    }
    
    return viewModel.projectsCoreDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CashFocusProjectsCell.identifier, for: indexPath) as? CashFocusProjectsCell else {
      fatalError("The table view could not dequeue a CustomCell in ViewController")
    }
    cell.title.text =  viewModel.projectsCoreDataList[indexPath.row].projectName
    cell.timePrice.text = viewModel.calculateMoney(time: viewModel.projectsCoreDataList[indexPath.row].projectTime, hourlyRate: viewModel.projectsCoreDataList[indexPath.row].projectHourlyRate)
    cell.time.text = viewModel.calculateTime(time: viewModel.projectsCoreDataList[indexPath.row].projectTime)
    cell.selectionStyle = .default
    cell.backgroundColor = .clear

    cell.subscribePlayButton = { [unowned self] in
      if viewModel.timerIdList.contains(indexPath.row) {
        viewModel.timerIdList = viewModel.timerIdList.filter { $0 !=  indexPath.row}
      } else {
        viewModel.timerIdList.append(indexPath.row)
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onSelectItem(itemIndex: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        viewModel.deleteProjectItem(item: viewModel.projectsCoreDataList[indexPath.row], index: indexPath.row)
        viewModel.getAllProjects() 
        tableView.reloadData()
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
      }
  }
}
