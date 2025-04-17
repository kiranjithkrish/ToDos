//
//  ToDoItemInputViewDelegateMock.swift
//  ToDoTests
//
//  Created by kiranjith on 11/04/2025.
//

import Foundation
@testable import ToDo

class ToDoItemInputViewDelegateMock: ToDoItemInputViewDelegate {
    
    var lastToDoItem: ToDoItemData?
    var lastCoordinate: Coordinate?
    
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?) {
        self.lastCoordinate = coordinate
        self.lastToDoItem = data
    }
    
}
