//
//  ToDoItemDetailsViewControllerTests.swift
//  ToDoTests
//
//  Created by kiranjith on 26/03/2025.
//

import XCTest
@testable import ToDo

final class ToDoItemDetailsViewControllerTests: XCTestCase {
    
    var sut: ToDoItemDetailsViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "ToDoItemDetailsViewController") as ToDoItemDetailsViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_view_shouldHaveTitleLabel() throws {
        let subview = try XCTUnwrap(sut.titleLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveLocationLabel() throws {
        let subview = try XCTUnwrap(sut.locationLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDescriptionLabel() throws {
        let subview = try XCTUnwrap(sut.locationLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveMapView() throws {
        let subview = try XCTUnwrap(sut.mapView)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDoneButton() throws
    {
        let subview = try XCTUnwrap(sut.doneButton)
        XCTAssertTrue(subview.isDescendant(of:
        sut.view))
    }
    
    func test_settingToDoItem_shouldUpdateTitleLabel() {
        let title = "dummy title"
        let todoItem = ToDoItem(title: title)
        sut.todoItem = todoItem
        XCTAssertEqual(sut.titleLabel.text, title)
    }
    
    func test_settingToDoItem_shouldUpdateDateLabel() {
        let date = Date()
        let todoItem = ToDoItem(title: "dummy 1", timestamp: date.timeIntervalSince1970)
        sut.todoItem = todoItem
        let actual = sut.dateLabel.text
        let expected = sut.dateFormatter.string(from: date)
        XCTAssertEqual(actual, expected)
    }

    func test_settingToDoItem_shouldUpdateDescriptionLabel() {
        let description = "dummy description"
        let todoItem = ToDoItem(title: "dummy title", description: description)
        sut.todoItem = todoItem
        XCTAssertEqual(sut.descriptionLabel.text, description)
    }
    
    func test_settingToDoItem_shouldUpdateLocationLabel() {
        let locationAt = "Kannur"
        let location = Location(name: locationAt)
        let todoItem = ToDoItem(title: "dummy title", location: location)
        sut.todoItem = todoItem
        XCTAssertEqual(sut.locationLabel.text, locationAt)
    }
    
    func test_settingToDoItem_shouldUpdateMapView() {
        let latitude = 51.22122
        let longitude = 44.55112
        let cordinate = Coordinate(latitude: latitude, longitude: longitude)
        let location = Location(name: "Kannur", coordinate: cordinate)
        let todoItem = ToDoItem(title: "dummy todo", location: location)
        sut.todoItem = todoItem
        let center = sut.mapView.centerCoordinate
        XCTAssertEqual(center.longitude, longitude, accuracy: 0.000_01)
        XCTAssertEqual(center.latitude, latitude, accuracy: 0.000_01)
        
    }
    
    func test_settingToDoItem_shouldUpdateButtonState() {
        var todoItem = ToDoItem(title:"dummy todo")
        todoItem.done.toggle()
        sut.todoItem = todoItem
        XCTAssertFalse(sut.doneButton.isEnabled)
    }
    
    func test_settingToDoItem_whenItemNotDone_shouldUpdateButtonState() {
        let todoItem = ToDoItem(title:"dummy todo")
        sut.todoItem = todoItem
        XCTAssertTrue(sut.doneButton.isEnabled)
    }
    
    func test_sendingButtonAction_shouldCheckItem() {
        let todoItem = ToDoItem(title:"dummy title")
        sut.todoItem = todoItem
        let storeMock = ToDoItemStoreMock()
        sut.todoStore = storeMock
        sut.doneButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(storeMock.checkLastCallArgument, todoItem)
    }
}

