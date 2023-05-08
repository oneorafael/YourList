//
//  TaskListViewController.swift
//  YourList
//
//  Created by Rafael Oliveira on 08/05/23.
//

import Foundation
import UIKit

class TaskListViewController: UIViewController {
    lazy var filterSegmentedControl = UISegmentedControl(items: ["All","High","Medium", "Low"])
    lazy var tableListView = UITableView()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupContraints()
    }
    
//    MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(filterSegmentedControl)
        view.addSubview(tableListView)
        
        navigationItem.title = "YourList"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        tableListView.translatesAutoresizingMaskIntoConstraints = false
        tableListView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableListView.dataSource = self
        tableListView.delegate = self
    }
    
    private func setupContraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            filterSegmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            tableListView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 10),
            tableListView.leadingAnchor.constraint(equalTo: filterSegmentedControl.leadingAnchor),
            tableListView.trailingAnchor.constraint(equalTo: filterSegmentedControl.trailingAnchor),
            tableListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    @objc private func addButtonPressed() {
        let vc = AddNewTaskViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated:true)
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  "TEST"
        return cell
    }
}
