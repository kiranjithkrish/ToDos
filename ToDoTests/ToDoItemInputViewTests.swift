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
    var todoItemData: ToDoItemData!

    override func setUpWithError() throws {
        todoItemData = ToDoItemData()
        sut = ToDoItemInputView(data: todoItemData)
    }

    override func tearDownWithError() throws {
        sut = nil
        todoItemData = nil
    }
    
    func test_titleInput_shouldSetValueInData() throws {
        let expected = "dummy title"
        try sut.inspect()
            .find(ViewType.TextField.self)
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

}
