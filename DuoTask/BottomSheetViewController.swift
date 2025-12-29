//
//  BottomSheetViewController.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 29.12.2025.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    let subjectTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "subject text field"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "body text field"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 8
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .lightGray
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
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            contentStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        ])
        
        saveButton.layer.cornerRadius = 12
        saveButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 12
        cancelButton.layer.masksToBounds = true
    }
}
