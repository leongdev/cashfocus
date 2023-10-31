//
//  NewProjectViewController.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-25.
//

import UIKit

class NewProjectViewController: UIViewController {

  weak var coordinator: MainCoordinator?
  private let viewModel = NewProjectViewModel()
  
  private let padding: CGFloat = 20
  
  private var projectName = ""
  private var projectDescription = ""
  private var hourlyRate: Float = 0
  
  private lazy var Line: CashFocusLine = {
    let line = CashFocusLine(backgroundColor: .line)
    return line
  }()
  
  private lazy var AddButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onPressAdd))
    button.tintColor = .systemGreen
    button.isEnabled = false
    return button
  }()
  
  private lazy var HourlyRateLabel: UILabel = {
    let label  = UILabel()
    label.text = "☝️how much you will receive in this project per hour!"
    label.font = UIFont(name: Fonts.regular.rawValue, size: 18)
    label.textColor = .systemGray3
    label.numberOfLines = 3
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  private lazy var CancelButton: UIBarButtonItem = {
    let button  = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onPressCancel))
    button.tintColor = .systemGreen
    return button
  }()
  
  private lazy var NameDescriptionView: UIView = {
    let view  = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 10
    view.backgroundColor = .inputBackground
    return view
  }()
  
  private lazy var NameTextField: UITextField = {
    let textField  = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .inputBackground
    
    textField.delegate = self
    textField.attributedPlaceholder = NSAttributedString(
      string: "Name",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3]
    )
    return textField
  }()
  
  private lazy var HourlyRateTextField: UITextField = {
    let textField  = UITextField()
    let image = UIImage(systemName:  Icons.dollarsign.rawValue )

    let leftImageView =  UIImageView(image:  image)
    leftImageView.frame = CGRect(x: 13, y: 0, width: 17, height: 28)
    leftImageView.tintColor = .systemGreen
    
    textField.placeholder = "00"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .inputBackground
    textField.layer.cornerRadius = 10
    textField.textAlignment = .left
    textField.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 32))
    textField.font = UIFont(name: Fonts.regular.rawValue, size: 18)
    textField.keyboardType = .numberPad
    textField.leftView?.addSubview(leftImageView)
    textField.leftViewMode = .always
    
    textField.delegate = self
    
    textField.addDoneButtonOnKeyboard(name: "Done", color: .systemGreen)
    
    return textField
  }()
  
  private lazy var DescriptionTextField: CashFocusTextView = {
    let textView  = CashFocusTextView(fontSize: 17)
    textView.backgroundColor = .inputBackground
    textView.textColor = .systemGray3
    textView.delegate = self
    textView.text = "Description"
    textView.addDoneButtonOnKeyboard(name: "Done", color: .systemGreen)
    return textView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)

      if let firstVC = presentingViewController as? HomeViewController {
          DispatchQueue.main.async {
              firstVC.projectsTableView.reloadData()
          }
      }
  }
  
  @objc func onPressAdd() {
    viewModel.createProjectItem(name: projectName, description: projectDescription, hourlyRate: hourlyRate)
    self.dismiss(animated: true)
  }
  
  @objc func onPressCancel() {
    self.dismiss(animated: true)
  }
  
  func checkAddButton() {
    let nameText = NameTextField.text ?? ""
    let hourlyText = HourlyRateTextField.text ?? ""
    
    if !nameText.isEmpty && !hourlyText.isEmpty {
      AddButton.isEnabled = true
    } else {
      AddButton.isEnabled = false
    }
  }
}

extension NewProjectViewController: UITextViewDelegate, UITextFieldDelegate {
  // MARK: - Setup UI
  
  func setup() {
    setupScreen()
    setupNameDescription()
    setupHourlyRate()
    setupHourlyLabel()
  }
  
  func setupScreen() {
    navigationItem.title = "New Project"
    navigationItem.rightBarButtonItem = AddButton
    navigationItem.leftBarButtonItem = CancelButton
    view.backgroundColor = .modalBackground
  }
  
  func setupNameDescription() {
    view.addSubview(NameDescriptionView)
    NameDescriptionView.addSubview(NameTextField)
    NameDescriptionView.addSubview(Line)
    NameDescriptionView.addSubview(DescriptionTextField)
    
    NSLayoutConstraint.activate([
      NameDescriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      NameDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      NameDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      NameDescriptionView.heightAnchor.constraint(equalToConstant: 200),
      
      NameTextField.topAnchor.constraint(equalTo: NameDescriptionView.topAnchor, constant: 10),
      NameTextField.leadingAnchor.constraint(equalTo: NameDescriptionView.leadingAnchor, constant: padding),
      NameTextField.trailingAnchor.constraint(equalTo: NameDescriptionView.trailingAnchor, constant: -padding),
      NameTextField.heightAnchor.constraint(equalToConstant: 40),
      
      Line.topAnchor.constraint(equalTo: NameTextField.bottomAnchor, constant: 10),
      Line.leadingAnchor.constraint(equalTo: NameDescriptionView.leadingAnchor, constant: padding),
      Line.trailingAnchor.constraint(equalTo: NameDescriptionView.trailingAnchor, constant: -padding),
      Line.heightAnchor.constraint(equalToConstant: 1),
      
      DescriptionTextField.topAnchor.constraint(equalTo: Line.bottomAnchor, constant: 10),
      DescriptionTextField.leadingAnchor.constraint(equalTo: NameDescriptionView.leadingAnchor, constant: 15),
      DescriptionTextField.trailingAnchor.constraint(equalTo: NameDescriptionView.trailingAnchor, constant: -padding),
      DescriptionTextField.heightAnchor.constraint(equalToConstant: 120),
    ])
  }
  
  func setupHourlyRate() {
    view.addSubview(HourlyRateTextField)
    
    NSLayoutConstraint.activate([
      HourlyRateTextField.topAnchor.constraint(equalTo: NameDescriptionView.bottomAnchor, constant: padding),
      HourlyRateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      HourlyRateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      HourlyRateTextField.heightAnchor.constraint(equalToConstant: 50),
    ])
  }
  
  func setupHourlyLabel() {
    view.addSubview(HourlyRateLabel)
    NSLayoutConstraint.activate([
      HourlyRateLabel.topAnchor.constraint(equalTo: HourlyRateTextField.bottomAnchor, constant: padding),
      HourlyRateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      HourlyRateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
    ])
  }
  
  // MARK: - Delegate Functions
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if DescriptionTextField.textColor == .systemGray3 {
      DescriptionTextField.text = nil
      DescriptionTextField.textColor = .mainText
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    
    checkAddButton()
    
    if DescriptionTextField.text.isEmpty {
      DescriptionTextField.text = "Description"
      DescriptionTextField.textColor = .systemGray3
    }
    
    projectDescription = DescriptionTextField.text
  }

  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    checkAddButton()
    
    switch textField.placeholder {
      case "Name":
        guard let inputText =  textField.text else {
          return projectName = ""
        }
        projectName = inputText
        
      case "00":
        guard let inputText =  textField.text else {
          return hourlyRate = 0
        }
      hourlyRate = Float(inputText) ?? 0.0
      case .none:
        break
      case .some(_):
        break
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.placeholder == "Name" {
      self.view.endEditing(true)
    }
    return false
  }
}
