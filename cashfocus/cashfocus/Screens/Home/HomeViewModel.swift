//
//  HomeViewModel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class HomeViewModel {
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var projectsCoreDataList: [ProjectItem]
  var timerId: UIBackgroundTaskIdentifier?
  var timerIdList: [Int] = []
  var searchText:String = ""
  
  init(projectsCoreDataList: [ProjectItem] = [] ) {
    self.projectsCoreDataList = projectsCoreDataList
    getAllProjects()
  }
  
  func getProjectsList() -> [ProjectItem] {
    return projectsCoreDataList
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
