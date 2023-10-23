//
//  HomeViewModel.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class HomeViewModel {
  let projectsList: [Project]
  
  init(projectsList: [Project] = []) {
    self.projectsList = projectsList
  }
}
