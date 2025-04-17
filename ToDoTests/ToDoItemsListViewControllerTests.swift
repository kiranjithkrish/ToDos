//
//  ToDoItemsListViewController.swift
//  ToDoTests
//
//  Created by kiranjith on 24/03/2025.
//

import XCTest
@testable import ToDo
final class ToDoItemsListViewControllerTests: XCTestCase {

    var sut: ToDoItemsListViewController!
    var todoItemStoreMock: ToDoItemStoreMock!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = try XCTUnwrap(storyboard.instantiateViewController(withIdentifier: "ToDoItemsListViewController") as? ToDoItemsListViewController)
        todoItemStoreMock = ToDoItemStoreMock()
        sut.todoItemStore = todoItemStoreMock
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_shouldBeSetup() {
        XCTAssertNotNil(sut)
    }
    
    func test_shouldHaveTableView() {
        XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
    }
    
    func test_numberOfRows_whenOneItemIsSent_shouldReturnOne() {
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy1")])
        let result = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(result, 1)
    }
    
    func test_numberOfRows_whenTwoItemsAreSent_shouldReturnTwo() {
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy1"), ToDoItem(title: "dummy1")])
        let result = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(result, 2)
    }

    func test_cellForRowAt_shouldReturnCellWithTitle() throws {
        let titleUnderTest = "dummy 1"
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)) as? ToDoItemCell
        XCTAssertEqual(cell?.titleLabel.text, titleUnderTest)
    }
    
    func test_cellForRowAt_shouldReturnCellWithTitle2() throws {
        let titleUnderTest = "dummy 2"
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"), ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)) as? ToDoItemCell
        XCTAssertEqual(cell?.titleLabel.text, titleUnderTest)
    }
    
    func test_cellForRowAt_shouldReturnCellWithDate() throws {
        let date = Date()
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1", timestamp: date.timeIntervalSince1970)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)) as? ToDoItemCell
        let expectedDate = sut.dateFormatter.string(from: date)
        XCTAssertEqual(cell?.dateLabel.text, expectedDate)
    }
    
    func test_calulateSum_whenListIsofDepthOne() {
        XCTAssertEqual(sut.calculateSum(list: [1,2,4]), 7)
    }
    
    func test_whenStoreHasDoneItems_noOfSections_shouldReturnTwo() {
        var doneItem = ToDoItem(title: "dummy 2")
        doneItem.done.toggle()
        todoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"), doneItem])
        let result = sut.tableView.numberOfSections
        XCTAssertEqual(result, 2)
        
    }
    
    func test_didSelectCellAt_shouldCallDelegate() throws {
        let delegateMock = ToDoItemsListViewControllerProtocolMock()
        sut.delegate = delegateMock
        let todoItem = ToDoItem(title: "dummy 1")
        todoItemStoreMock.itemPublisher.send([todoItem])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(delegateMock.selectedToDoItemReceivedArguments?.item, todoItem)
    }
    
    func test_navigationBarButton_shouldCallDelegate() throws {
        let delegateMock = ToDoItemsListViewControllerProtocolMock()
        sut.delegate = delegateMock
        let addButton = sut.navigationItem.rightBarButtonItem
        let target = try XCTUnwrap(addButton?.target)
        let action = try XCTUnwrap(addButton?.action)
        _ = target.perform(action, with: addButton)
        XCTAssertEqual(delegateMock.addToDoItemCallCount, 1)
    }
}
