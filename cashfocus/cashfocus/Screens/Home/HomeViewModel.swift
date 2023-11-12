//
//  HomeViewModel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class HomeViewModel {

  lazy var timer = BackgroundTimer(delegate: nil)
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var projectsCoreDataList: [ProjectItem]
  var timerId: UIBackgroundTaskIdentifier?
  var timerIdList: [Int] = []
  var searchText:String = ""
  var timerIsOn: Bool = false

  init(projectsCoreDataList: [ProjectItem] = [] ) {
    self.projectsCoreDataList = projectsCoreDataList
    getAllProjects()
  }
  
  func onPressPlayIntem(index: Int, projectsTableView: UITableView, pauseButtonImage: UIImage, playButtonImage: UIImage) {
    
    if self.timerIdList.contains(index) {
      self.timerIdList = self.timerIdList.filter { $0 != index}
    } else {
      self.timerIdList.append(index)
    }
    
    if(timerIdList.isEmpty) {
      stopTimer()
      projectsTableView.visibleCells.forEach { cell in
        if let cell = cell as? CashFocusProjectsCell {
          cell.actionButton.setImage(playButtonImage, for: .normal)
        }
      }
      timerIsOn = false
    } else if(!timerIsOn) {
      timerIsOn = true
      self.initTimer(projectsTableView: projectsTableView, pauseButtonImage: pauseButtonImage, playButtonImage: playButtonImage)
    }
  }
  
  func initTimer(projectsTableView: UITableView, pauseButtonImage: UIImage, playButtonImage: UIImage) {
    let timerId = timer.executeAfterDelay(delay: 1, repeating: true) {
      print("AOBAH")
      self.onTimeUpdate()
      
      if(!self.searchText.isEmpty) {
        return
      }
      
      projectsTableView.visibleCells.forEach { cell in
        
        guard let index = projectsTableView.indexPath(for: cell) else {
          fatalError("Couldnt find index path")
        }
        
        if let cell = cell as? CashFocusProjectsCell {
          if self.timerIdList.contains(index.row) {
            cell.actionButton.setImage(pauseButtonImage, for: .normal)
          } else {
            cell.actionButton.setImage(playButtonImage, for: .normal)
          }
          cell.setupTimeMoney(item: self.getProjectListFilered()[index.row])
        }
      }
    }
    
    self.timerId = timerId
  }
  
  func stopTimer() {
    guard let timerIdRaw = timerId?.rawValue else {
      fatalError("Error getting timer id")
    }
    self.timer.cancelExecution(tasks: [UIBackgroundTaskIdentifier(rawValue: timerIdRaw)])
  }
  
  func getProjectListFilered() -> [ProjectItem] {
    
    let filteredList = projectsCoreDataList.filter {
      
      if(searchText.isEmpty) {return true}
      
      guard let name = $0.projectName else {
        return false
      }
      return name.lowercased().contains(searchText.lowercased())
    }
    
    return  filteredList
  }
  
  func onTimeUpdate() {
    for item in timerIdList {
      let name  = projectsCoreDataList[item].projectName
      let description  = projectsCoreDataList[item].projectDescription
      let hourlyRate  = projectsCoreDataList[item].projectHourlyRate
      let time = projectsCoreDataList[item].projectTime + 1
      
      updateProjectItem(
        item: projectsCoreDataList[item],
        name: name ?? "",
        description: description ?? "",
        hourlyRate: hourlyRate,
        time: time
      )
    }
  }
  
  func updateProjectItem(item: ProjectItem, name: String, description: String, hourlyRate: Float, time: Float) {
    item.projectName = name
    item.projectDescription = description
    item.projectHourlyRate = hourlyRate
    item.projectTime = time
    
    do {
      try context.save()
    } catch {
      print("Error editing")
    }
  }
  
  func getAllProjects() {
    do {
      let item = try context.fetch(ProjectItem.fetchRequest())
      projectsCoreDataList = item
    } catch {
      //error
    }
  }
  
  func deleteProjectItem(item: ProjectItem, index: Int) {
    context.delete(item)
    timerIdList = timerIdList.filter { $0 != index}
    
    do {
      try context.save()
    } catch {
      print("Error deleting")
    }
  }
}
