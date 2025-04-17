//
//  NavigationControllerMock.swift
//  ToDoTests
//
//  Created by kiranjith on 16/04/2025.
//

import UIKit

class NavigationControllerMock: UINavigationController {
    var lastPushedViewController: UIViewController?
    override func pushViewController(_ viewController: UIViewController,animated: Bool) {
    lastPushedViewController = viewController
    super.pushViewController(viewController,animated: animated)
    }
}
