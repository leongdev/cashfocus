//
//  Coordinator.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

protocol Coordinator {
  var children: [Coordinator] { get set }
  var nav: UINavigationController { get set }
  
  func start()
}
