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
    }
    
    var taskStorage: [Task] = []
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupMockData()
        setupStorage()
        setupNavBar()
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
    }
    
    func setupNavBar() {
        self.title = Constants.appName
        let addButton = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func didTapAddButton() {
        print("button taped")
    }
    
    func setupMockData() {
        taskStorage = [
            Task(id: UUID(), subject: "task 1", body: "hello"),
            Task(id: UUID(), subject: "task 2", body: "bye"),
            Task(id: UUID(), subject: "task 3", body: "hi")
        ]
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
        cell.contentConfiguration = config
        return cell
    }
}

