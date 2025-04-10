//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by kiranjith on 19/03/2025.
//

import XCTest
@testable import ToDo
final class ToDoItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_whenGivenTitle_setsTitle() {
       let item = ToDoItem(title: "dummy")
        XCTAssertEqual(item.title, "dummy")
    }
    
    func test_init_whenGivenTitleAndDescription_setsTitleAndDescription() {
        let _ = ToDoItem(title: "dummy", description: "description")
        
    }
    
    func test_init_setsTimeStamp() throws {
        let dummyTimestamp: TimeInterval = 42.0
        let item = ToDoItem(title: "dummy", description: nil, timestamp: dummyTimestamp)
        let timestamp = try XCTUnwrap(item.timestamp)
        XCTAssertEqual(timestamp, dummyTimestamp, accuracy: 0.000_001)
    }
    
    func test_init_whenGivenLocation_setsLocation() {
        let dummylocation = Location(name: "dummy location", coordinate: nil)
        let item = ToDoItem(title: "dummy", location: dummylocation)
        
        XCTAssertEqual(item.location?.name, dummylocation.name)
    }

}
