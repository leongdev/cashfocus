//
//  MainCoordinator.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class MainCoordinator: Coordinator {

  var children = [Coordinator]()
  var nav: UINavigationController
  
  init(nav: UINavigationController) {
    self.nav = nav
  }
  
  func start() {
    let vc = HomeViewController()
    vc.coordinator = self
    nav.pushViewController(vc, animated: false)
  }
  
  func onPressNewProject() {
    let vc = NewProjectViewController()
    vc.coordinator = self

    let navigation = UINavigationController(rootViewController: vc)
    navigation.modalPresentationStyle = .fullScreen
    nav.present(navigation, animated: true)
  }
  
  func onPressAccount() {
    let vc = AccountViewController()
    vc.coordinator = self
    
    let navigation = UINavigationController(rootViewController: vc)
    navigation.modalPresentationStyle = .formSheet
    nav.present(navigation, animated: true)
  }
  
  func onPressSettigs() {
    let vc = SettingsViewController()
    vc.coordinator = self
    nav.pushViewController(vc, animated: true)
  }
  
  func onPressProjectDetails(projectIndex: Int) {
    let vc = ProjectDetailsViewController()
    vc.coordinator = self
    vc.projectIndex = projectIndex
    nav.pushViewController(vc, animated: true)
  }
}
