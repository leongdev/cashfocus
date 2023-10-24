//
//  HomeViewModel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class HomeViewModel {
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var projectsList: [ProjectItem]
  
  init(projectsList: [ProjectItem] = []) {
    self.projectsList = projectsList
    getAllProjects()
  }
  
  func getAllProjects() {
    do {
      let item = try context.fetch(ProjectItem.fetchRequest())
      projectsList = item
    } catch {
      //error
    }
  }
  
  func createProjectItem(name: String, description: String, hourlyRate: Float) {
    let newItem = ProjectItem(context: context)
    newItem.projectName = name
    newItem.projectDescription = description
    newItem.projectHourlyRate = hourlyRate
    newItem.projectTime = 0.0
    newItem.projectCreatedAt = Date()
    
    do {
      try context.save()
    } catch {
      print("Error creating")
    }
  }
  
  func deleteProjectItem(item: ProjectItem) {
    context.delete(item)
    
    do {
      try context.save()
    } catch {
      print("Error deleting")
    }
  }
  
  func updateProjectItem(item: ProjectItem, name: String, description: String, hourlyRate: Float) {
    item.projectName = name
    item.projectDescription = description
    item.projectHourlyRate = hourlyRate
    
    do {
      try context.save()
    } catch {
      print("Error editing")
    }
  }
}
