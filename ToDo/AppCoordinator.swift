//
//  AppCoordinator.swift
//  ToDo
//
//  Created by kiranjith on 16/04/2025.
//

import UIKit

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

extension AppCoordinator: ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem) {
        
    }
    
        
}
