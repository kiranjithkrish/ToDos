//
//  ToDoItemsListViewControllerProtocolMock.swift
//  ToDoTests
//
//  Created by kiranjith on 26/03/2025.
//

import Foundation

import UIKit
@testable import ToDo

class ToDoItemsListViewControllerProtocolMock: ToDoItemsListViewControllerProtocol {
    
    var addToDoItemCallCount = 0
    var selectedToDoItemReceivedArguments: (viewController: UIViewController, item: ToDoItem)?
    
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        selectedToDoItemReceivedArguments = (viewController, item)
    }
    
    func addToDoItem(_ viewController: UIViewController) {
        addToDoItemCallCount += 1
    }
}
