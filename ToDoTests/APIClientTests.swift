//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by kiranjith on 11/04/2025.
//

import XCTest
@testable import ToDo
import Intents
import Contacts

final class APIClientTests: XCTestCase {
    var sut: APIClient!

    override func setUpWithError() throws {
        sut = APIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_coordinate_fetchesCoordinate() {
        let geocoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geocoderMock
        let location = CLLocation(latitude: 1, longitude: 2)
        let placemark = CLPlacemark(location: location, name: nil, postalAddress: nil)
        let expectedAddress = "dummy address"
        var result: Coordinate?
        sut.coordinate(for: expectedAddress) { coordinate in
            result = coordinate
        }
        geocoderMock.completion?([placemark],nil)
        XCTAssertEqual(result?.latitude, location.coordinate.latitude)
        XCTAssertEqual(result?.longitude, location.coordinate.longitude)
    }
    
    func test_test_coordinate_shouldCallGeoCoderWithAddress() {
        let geocoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geocoderMock
        let location = CLLocation(latitude: 1, longitude: 2)
        let placemark = CLPlacemark(location: location, name: nil, postalAddress: nil)
        let expectedAddress = "dummy address"
        sut.coordinate(for: expectedAddress) { _ in
        }
        geocoderMock.completion?([placemark],nil)
        XCTAssertEqual(geocoderMock.geocodeAddressString, expectedAddress)
    }
    
    func test_toDoItems_shouldFetchToDoItems() async throws {
        let url = try XCTUnwrap(URL(string: "http://todo.app/items"))
        let urlSessionMock = URLSessionProtocolMock()
        let expected = [ToDoItem(title: "dummy")]
        urlSessionMock.dataForDelegateReturnValue = (try JSONEncoder().encode(expected), HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!)
        sut.session = urlSessionMock
        let items = try await sut.fetchToDoItems()
        XCTAssertEqual(items, expected)
        XCTAssertEqual(urlSessionMock.dataForDelegateRequest, URLRequest(url: url))
    }
    
    func test_toDoItems_whenError_shouldThrowError() async throws {
        let url = try XCTUnwrap(URL(string: "http://todo.app/items"))
        let urlSessionMock = URLSessionProtocolMock()
        let expected = NSError(domain: "", code: 1234)
        
        urlSessionMock.dataForDelegateError = expected
        sut.session = urlSessionMock
        do {
            let _ = try await sut.fetchToDoItems()
            XCTFail()
        } catch {
            let nsError = try XCTUnwrap(error as NSError)
            XCTAssertEqual(nsError, expected)
        }
    }
    
    func test_toDoItems_whenJSONIsWrong_shouldFetcheItems()
    async throws {
        let url = try XCTUnwrap(URL(string: "foo"))
        let urlSessionMock = URLSessionProtocolMock()
        urlSessionMock.dataForDelegateReturnValue = (
            try JSONEncoder().encode("dummy"),
            HTTPURLResponse(url: url,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil)!
        )
        sut.session = urlSessionMock
        do {
            _ = try await sut.fetchToDoItems()
            XCTFail()
        } catch {
            XCTAssertTrue(error is Swift.DecodingError)
        }
    }
    
    // add more tests for http status codes other than 200

}
