//
//  AddNewTaskViewController.swift
//  YourList
//
//  Created by Rafael Oliveira on 08/05/23.
//

import Foundation
import UIKit

class AddNewTaskViewController: UIViewController {
    lazy var filterSegmentedControl = UISegmentedControl(items: ["High","Medium", "Low"])
    lazy var taskTextField = UITextField()
    
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
        view.addSubview(taskTextField)
        
        navigationItem.title = "YourList"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.placeholder = "What is your new task?"
    }
    
    private func setupContraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            filterSegmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            taskTextField.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 10),
            taskTextField.leadingAnchor.constraint(equalTo: filterSegmentedControl.leadingAnchor),
            taskTextField.trailingAnchor.constraint(equalTo: filterSegmentedControl.trailingAnchor),
           
        ])
    }
    
    @objc private func saveButtonPressed() {
        dismiss(animated: true)
    }
}

