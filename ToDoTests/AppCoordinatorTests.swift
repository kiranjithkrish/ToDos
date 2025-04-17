//
//  AppCoordinatorTests.swift
//  ToDoTests
//
//  Created by kiranjith on 16/04/2025.
//

import XCTest
import SwiftUI
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
    
    func test_selectToDoItem_pushesDetails() throws {
        let dummyVC = UIViewController()
        let item = ToDoItem(title: "dummy")
        sut.selectToDoItem(dummyVC, item: item)
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertEqual(detail.todoItem, item)
        
    }
    
    func test_selectToDoItem_shouldSetToDoItemStore() throws {
        let dummyVC = UIViewController()
        let item = ToDoItem(title: "dummy")
        sut.selectToDoItem(dummyVC, item: item)
        let detail = try XCTUnwrap(navigationControllerMock.lastPushedViewController as? ToDoItemDetailsViewController)
        XCTAssertIdentical(detail.todoStore as? ToDoItemStore, sut.todoItemsStore)
    }
    
    func test_addToDoItem_shouldPresentInputView() throws {
        let viewControllerMock = ViewControllerMock()
        sut.addToDoItem(viewControllerMock)
        let lastPresented = try XCTUnwrap(viewControllerMock.lastPresented as? UIHostingController<ToDoItemInputView>)
        XCTAssertIdentical(lastPresented.rootView.delegate as? AppCoordinator, sut)
    }
    
   

}
