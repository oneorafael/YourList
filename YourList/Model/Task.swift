//
//  Task.swift
//  YourList
//
//  Created by Rafael Oliveira on 08/05/23.
//

import Foundation

enum Priority: Int {
    case high,medium,low
}
struct Task {
    let title: String
    let priority: Priority
}
