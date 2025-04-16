//
//  ToDoItem.swift
//  ToDo
//
//  Created by kiranjith on 19/03/2025.
//

import Foundation

struct ToDoItem: Equatable, Codable {
    let title: String
    let id: UUID
    let description: String?
    let timestamp: TimeInterval?
    let location: Location?
    var done = false
    
    init(title: String, description: String? = nil, timestamp: TimeInterval? = nil, location: Location? = nil) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.location = location
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ToDoItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
