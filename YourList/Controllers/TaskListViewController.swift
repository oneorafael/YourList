//
//  TaskListViewController.swift
//  YourList
//
//  Created by Rafael Oliveira on 08/05/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class TaskListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay(value: [Task]())
    private var filteredTasks = [Task]()
    
    lazy private var filterSegmentedControl = UISegmentedControl(items: ["All","High","Medium", "Low"])
    lazy private var tableListView = UITableView()
    
    
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
        filterSegmentedControl.addTarget(self, action: #selector(segmentedControlHasChanged), for: .valueChanged)
        
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
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority!}
            }.subscribe(onNext: {tasks in
                self.filteredTasks = tasks
                self.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableListView.reloadData()
        }
    }
    
    @objc private func segmentedControlHasChanged() {
        let priority = Priority(rawValue: filterSegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    @objc private func addButtonPressed() {
        let vc = AddNewTaskViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        let priority = Priority(rawValue: self.filterSegmentedControl.selectedSegmentIndex - 1)
        vc.taskObservable.subscribe(onNext: { task in
            var exitingTasks = self.tasks.value
            exitingTasks.append(task)
            self.tasks.accept(exitingTasks)
            self.filterTasks(by: priority)
        }).disposed(by: disposeBag)
        
        present(navigationVC, animated:true)
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = filteredTasks[indexPath.row]
        cell.textLabel?.text =  task.title
        return cell
    }
}
