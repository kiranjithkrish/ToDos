//
//  ToDoItemCellTests.swift
//  ToDoTests
//
//  Created by kiranjith on 25/03/2025.
//

import XCTest
@testable import ToDo

final class ToDoItemCellTests: XCTestCase {
    
    var sut: ToDoItemCell!

    override func setUpWithError() throws {
        sut = ToDoItemCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_cellHasTitleLabelSubview() {
        let subview = sut.titleLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
    
    func test_cellHasDateLabelSubview() {
        let subview = sut.dateLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
        
    }
    
    func test_cellHasLocationLabelSubview() {
        let subview = sut.locationLabel 
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
}
