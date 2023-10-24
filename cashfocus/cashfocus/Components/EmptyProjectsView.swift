//
//  EmptyProjectsView.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

class EmptyProjectsView: UIView {
  
  private lazy var title = CashFocusLabel(
    text: "You don't have any \n projects yet!",
    textAlignment: .left,
    font: Fonts.bold.rawValue,
    size:33
  )
  
  private lazy var pigImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(resource: .pig)
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EmptyProjectsView {
  func setup() {
    self.translatesAutoresizingMaskIntoConstraints = false
  
    title.numberOfLines = 2
    title.textAlignment = .center
    
    self.addSubview(pigImage)
    self.addSubview(title)

    NSLayoutConstraint.activate([
      pigImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      pigImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      pigImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      pigImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      
      title.topAnchor.constraint(equalTo: pigImage.bottomAnchor),
      title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
  }
}

#Preview {
  EmptyProjectsView()
}
