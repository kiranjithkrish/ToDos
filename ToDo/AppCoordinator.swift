//
//  AppCoordinator.swift
//  ToDo
//
//  Created by kiranjith on 16/04/2025.
//

import UIKit
import SwiftUI

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let viewController: UIViewController
    private let navigationController: UINavigationController
    let todoItemsStore: ToDoItemStore
    
    init(window: UIWindow?,
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ToDoItemsListViewController")
        todoItemsStore = ToDoItemStore()
    }
    
    func start() {
        navigationController.pushViewController(viewController, animated: true)
        window?.rootViewController = navigationController
        if let listViewController = viewController as? ToDoItemsListViewController {
            listViewController.delegate = self
            listViewController.todoItemStore = todoItemsStore
        }
    }
    
    
}

extension AppCoordinator: ToDoItemInputViewDelegate {
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?) {
        
    }
}

extension AppCoordinator: ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let next = storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as? ToDoItemDetailsViewController else {
            return
        }
        next.loadViewIfNeeded()
        next.todoItem = item
        next.todoStore = todoItemsStore
        navigationController.pushViewController(next, animated: true)
    }
    
    func addToDoItem(_ viewController: UIViewController) {
        let data = ToDoItemData()
        let next = UIHostingController(rootView: ToDoItemInputView(data: data, apiClient: APIClient(), delegate: self))
        viewController.present(next, animated: true)
    }
    
        
}
