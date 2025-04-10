//
//  ToDoItemInputViewTests.swift
//  ToDoTests
//
//  Created by kiranjith on 02/04/2025.
//

import XCTest
import ViewInspector
@testable import ToDo


final class ToDoItemInputViewTests: XCTestCase {
    
    var sut: ToDoItemInputView!
    var apiClientMock: APIClientMock!
    var todoItemData: ToDoItemData!

    override func setUpWithError() throws {
        todoItemData = ToDoItemData()
        apiClientMock = APIClientMock()
        sut = ToDoItemInputView(
            data: todoItemData,
            apiClient: apiClientMock
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        todoItemData = nil
        apiClientMock = nil
    }
    
    func test_titleInput_shouldSetValueInData() throws {
        let expected = "dummy title"
        try sut.inspect()
            .find(ViewType.TextField.self, where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Title"
            })
            .setInput(expected)
        let input = todoItemData.title
        XCTAssertEqual(input, expected)
    }
    
    func test_whenWithoutDate_shouldNotShowDateInput() {
        XCTAssertThrowsError(try sut.inspect().find(ViewType.DatePicker.self))
    }
    
    func test_whenWithDate_shouldAllowDateInput() throws {
        let expected = Date()
        try sut.inspect().find(ViewType.Toggle.self).tap()
        try sut.inspect()
            .find(ViewType.DatePicker.self)
            .select(date: expected)
        let input = self.todoItemData.date
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldAllowDescriptionInput() throws {
        let expected = "dummy description"
        try sut
            .inspect()
            .find(ViewType.TextField.self) { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Description"
            }
            .setInput(expected)
        let input = todoItemData.itemDescription
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldAllowLocationInput() throws {
        let expected = "dummy location"
        try sut
            .inspect()
            .find(ViewType.TextField.self) { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Location Name"
            }
            .setInput(expected)
        let input = todoItemData.locationName
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldAllowAddressInput() throws {
        let expected = "dummy address"
        try sut
            .inspect()
            .find(ViewType.TextField.self) { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Address"
            }
            .setInput(expected)
        let input = todoItemData.addressString
        XCTAssertEqual(input, expected)
    }
    
    func test_shouldHaveASaveButton() throws {
        XCTAssertNoThrow(try sut
            .inspect()
            .find(ViewType.Button.self, where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
            }))
    }
    
    func test_saveButton_shouldFetchCoordinate() throws {
        todoItemData.title = "dummy title"
        let expected = "dummy address"
        todoItemData.addressString = expected
        try sut.inspect()
            .find(ViewType.Button.self, where: { view in
                let label = try view
                    .labelView()
                    .text()
                    .string()
                return label == "Save"
            })
            .tap()
            
        XCTAssertEqual(apiClientMock.coordinateAddess, expected)
    }

}
