//
//  NewProjectViewModel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-26.
//

import UIKit

class NewProjectViewModel {
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
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
}
