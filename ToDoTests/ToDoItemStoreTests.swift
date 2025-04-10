//
//  ToDoItemStoreTests.swift
//  ToDoTests
//
//  Created by kiranjith on 20/03/2025.
//

import XCTest
import Combine
@testable import ToDo

final class ToDoItemStoreTests: XCTestCase {

    var sut: ToDoItemStore!
    
    override func setUpWithError() throws {
        sut = ToDoItemStore(fileName: "dummy_store")
    }

    override func tearDownWithError() throws {
        let url = FileManager.default.documentsUrl(name: "dummy_store")
        try? FileManager.default.removeItem(at: url)
        sut = nil
    }

    func test_add_shouldPublishChange() throws {
        let todoItem = ToDoItem(title: "Dummy")
        let receivedItems = try wait(for: sut.itemPublisher) {
            sut.add(todoItem)
        }
        XCTAssertEqual(receivedItems, [todoItem])
    }
    
    func test_check_shouldPublishChangeInDoneItems() throws {
        let todoItemOne = ToDoItem(title: "Dummy")
        sut.add(todoItemOne)
        sut.add(ToDoItem(title: "Dummy2"))
        let receivedItems = try wait(for: sut.itemPublisher) {
            sut.check(todoItemOne)
        }
        let doneItems = receivedItems.filter{$0.done}
        XCTAssertEqual(doneItems, [todoItemOne])
    }
    
    func test_init_shouldLoadPreviousToDos() throws {
        
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "wait for publisher in \(#file)")
        let toDoItemOne = ToDoItem(title: "dummy title")
        sut1?.add(toDoItemOne)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher
            .sink { items in
                result = items
                print("called")
                publisherExpectation.fulfill()
            }
        waitForExpectations(timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [toDoItemOne])
    }
    
    func test_init_whenItemIsChecked_shouldLoadPreviousToDoItems() throws {
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "wait for publisher in \(#file)")
        let toDoItemOne = ToDoItem(title: "dummy title")
        sut1?.add(toDoItemOne)
        sut1?.check(toDoItemOne)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher
            .sink { items in
                result = items
                print("called")
                publisherExpectation.fulfill()
            }
        waitForExpectations(timeout: 1)
        token.cancel()
        XCTAssertEqual(result?.first?.done, true)
    }
    

}

extension XCTestCase {
    func wait<T: Publisher>(for publisher: T,
                            afterChange change: () -> Void,
                            file: StaticString = #file,
                            line: UInt = #line) throws
                            -> T.Output where T.Failure == Never {
        let publisherExcpectation = expectation(description: "Wait for publisher in\(#file)")
        var result: T.Output?
        let token = publisher
            .dropFirst()
            .sink { value in
                result = value
                publisherExcpectation.fulfill()
            }
        change()
        wait(for: [publisherExcpectation], timeout: 1)
        token.cancel()
        let unwrappedRes = try XCTUnwrap(result, "Publisher did not publish any value", file: file, line: line)
        return unwrappedRes
    }
}
