//
//  CashFocusTableViewCell.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-31.
//

import UIKit

class CashFocusProjectsCell: UITableViewCell {
  
  static let identifier = "ProjectsCell"
  
  lazy var line: CashFocusLine = {
    let line = CashFocusLine(backgroundColor: .systemGray6)
    return line
  }()
  
  lazy var rightIcon: UIImageView = {
    let icon = UIImageView()
    icon.image = UIImage(systemName: Icons.chevronForward.rawValue)
    icon.tintColor = .systemGreen
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.contentMode = .scaleAspectFit
    return icon
  }()
  
  lazy var title: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.regular.rawValue, size: 18)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var cellBackground: UIView = {
    let view = UIView()
    view.backgroundColor = .inputBackground
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var time: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.regular.rawValue, size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  lazy var timePrice: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.regular.rawValue, size: 23)
    label.textColor = .systemGreen
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  lazy var playButton: CashFocusIconButton = {
    let button = CashFocusIconButton(
      iconName: Icons.playCircleFill.rawValue,
      color: .systemGreen, fontSize: 35
    )
    return button
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CashFocusProjectsCell {
  func setup() {
    setupBackground()
    setupLine()
    setupTitle()
    setupTimePrice()
    setupTime()
    setupPlayButton()
  }
  
  func setupBackground() {
    self.contentView.addSubview(cellBackground)
    self.contentView.backgroundColor = .modalBackground
    
    cellBackground.layer.cornerRadius = 10
    
    NSLayoutConstraint.activate([
      cellBackground.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
      cellBackground.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
      cellBackground.heightAnchor.constraint(equalToConstant: 80),
      cellBackground.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    ])
  }
  
  func setupLine() {
    cellBackground.addSubview(line)
    
    NSLayoutConstraint.activate([
      line.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 12),
      line.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -12),
      line.centerYAnchor.constraint(equalTo:cellBackground.centerYAnchor),
      line.heightAnchor.constraint(equalToConstant: 1),
    ])
  }
  
  func setupTitle() {
    cellBackground.addSubview(title)
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 12),
      title.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 12),
      title.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  func setupTimePrice() {
    cellBackground.addSubview(timePrice)
    
    NSLayoutConstraint.activate([
      timePrice.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -5),
      timePrice.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 12),
      timePrice.widthAnchor.constraint(equalToConstant: 100)
    ])
  }  
  
  func setupPlayButton() {
    cellBackground.addSubview(playButton)
    
    NSLayoutConstraint.activate([
      playButton.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -5),
      playButton.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -12),
      playButton.heightAnchor.constraint(equalToConstant: 30),
      playButton.widthAnchor.constraint(equalToConstant: 30),
    ])
  }
  
  func setupTime() {
    cellBackground.addSubview(time)
    cellBackground.addSubview(rightIcon)
    
    NSLayoutConstraint.activate([
      rightIcon.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 13),
      rightIcon.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -12),
      rightIcon.widthAnchor.constraint(equalToConstant: 12),
      rightIcon.heightAnchor.constraint(equalToConstant: 19),
      
      time.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 12),
      time.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -25),
    ])
  }
}
