//
//  LocationTests.swift
//  ToDoTests
//
//  Created by kiranjith on 19/03/2025.
//

import XCTest
@testable import ToDo

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_setsCoordinate() throws {
        let cordinate = Coordinate(latitude: 1, longitude: 2)
        let location = Location(name: "dummy location", coordinate: cordinate)
        let resultCordinate = try XCTUnwrap(location.coordinate)
        XCTAssertEqual(resultCordinate.latitude, 1, accuracy: 0.000_001)
        XCTAssertEqual(resultCordinate.longitude, 2, accuracy: 0.000_001)
    }
    
    func test_init_setsName() {
        let location = Location(name: "Dummy")
        XCTAssertEqual(location.name, "Dummy")
    }
}
