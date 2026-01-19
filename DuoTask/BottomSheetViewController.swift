//
//  BottomSheetViewController.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 29.12.2025.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 12
        static let tfBorderColor: CGColor = UIColor.lightGray.cgColor
        static let upperTFPlaceholder = "subject text field"
        static let downTFPlaceholder = "body text field"
        static let svAxis: NSLayoutConstraint.Axis = .vertical
        static let svSpacing: CGFloat = 8
        static let svDistribution: UIStackView.Distribution = .fillEqually
        static let saveButtonText = "Save"
        static let saveButtonColor: UIColor = .black
        static let cancelButtonText = "Cancel"
        static let cancelButtonColor: UIColor = .red
        static let buttonBackgroundColor: UIColor = .lightGray
        static let contentStackViewOffsetTop: CGFloat = 40
        static let contentStackViewOffsetLeft: CGFloat = 40
        static let contentStackViewOffsetRight: CGFloat = 40
    }
    
    var delegate: TaskStorageDelegate?
    
    let subjectTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.upperTFPlaceholder
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = Constants.tfBorderColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.downTFPlaceholder
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = Constants.tfBorderColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = Constants.svAxis
        stackview.spacing = Constants.svSpacing
        stackview.distribution = Constants.svDistribution
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.saveButtonText, for: .normal)
        button.setTitleColor(Constants.saveButtonColor, for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.cancelButtonText, for: .normal)
        button.setTitleColor(Constants.cancelButtonColor, for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(subjectTextField)
        contentStackView.addArrangedSubview(bodyTextField)
        contentStackView.addArrangedSubview(saveButton)
        contentStackView.addArrangedSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.contentStackViewOffsetTop),
            contentStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.contentStackViewOffsetRight),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.contentStackViewOffsetLeft)
        ])
        
        saveButton.layer.cornerRadius = Constants.cornerRadius
        saveButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = Constants.cornerRadius
        cancelButton.layer.masksToBounds = true
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc func didTapSaveButton() {
        let subject = subjectTextField.text ?? ""
        let body = bodyTextField.text ?? ""
        let task = Task(id: UUID(), subject: subject, body: body)
        
        delegate?.giveTask(task: task)
        dismiss(animated: true)
    }
}
