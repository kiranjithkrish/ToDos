//
//  AppCoordinatorTests.swift
//  ToDoTests
//
//  Created by kiranjith on 16/04/2025.
//

import XCTest
@testable import ToDo

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var navigationControllerMock: NavigationControllerMock!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow(frame: CGRectMake(0, 0, 200, 200))
        navigationControllerMock = NavigationControllerMock()
        sut = AppCoordinator(window: window, navigationController: navigationControllerMock)
        
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationControllerMock = nil
        window = nil
    }
    
    func test_start_shouldSetDelegate() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertIdentical(listViewController.delegate as? AppCoordinator, sut)
        
    }
    
    func test_start_shouldAssignToDoItemsStore() throws {
        sut.start()
        let listViewController = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemsListViewController)
        XCTAssertNotNil(listViewController.todoItemStore)
    }

}
