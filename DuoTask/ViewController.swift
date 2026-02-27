//
//  ViewController.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 17.12.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let idCell = "taskCell"
        static let appName = "DuoTask"
        static let imageSize: CGFloat = 50
        static let addButtonImage = "plus.circle.fill"
        static let addButtonOffsetBottom: CGFloat = 40
        static let addButtonHeight: CGFloat = 50
        static let addButtonWidth: CGFloat = 50
        static let sheetCornerRadius: CGFloat = 12
    }
    
    var taskStorage: [Task] = []
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var newAddButton: UIButton = {
        let button = UIButton()
        button.setImage(addButtonImage, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addButtonImage: UIImage? = {
        let config = UIImage.SymbolConfiguration(pointSize: Constants.imageSize)
        let image = UIImage(systemName: Constants.addButtonImage, withConfiguration: config)
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = Constants.appName
        setupTableView()
        setupStorage()
        setupAddButton()
    }
    
    func setupTableView() {
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    func setupStorage() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: Constants.idCell)
        tableview.dataSource = self
        tableview.delegate = self
        taskStorage = TaskUserDefaultsStorage.load()
    }
    
    func setupAddButton() {
        view.addSubview(newAddButton)

        NSLayoutConstraint.activate([
            newAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.addButtonOffsetBottom),
            newAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newAddButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeight),
            newAddButton.widthAnchor.constraint(equalToConstant: Constants.addButtonWidth)
        ])
        
        newAddButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc func didTapAddButton() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        
        bottomSheetVC.delegate = self
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = Constants.sheetCornerRadius
        }
            
        self.present(bottomSheetVC, animated: true)
    }
    
    private func deleteTasks(row: Int) {
        taskStorage.remove(at: row)
        TaskUserDefaultsStorage.save(tasks: taskStorage)
        tableview.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idCell, for: indexPath)
        let item = taskStorage[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = item.subject
        config.secondaryText = item.body
        cell.contentConfiguration = config
        return cell
    }
}

extension ViewController: TaskStorageDelegate {
    
    func giveTask(task: Task) {
        taskStorage.append(task)
        TaskUserDefaultsStorage.save(tasks: taskStorage)
        tableview.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] action, view, compl in
            
            guard let self else {
                return
            }
            
            deleteTasks(row: indexPath.row)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}
