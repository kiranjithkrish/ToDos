//
//  APIClientMock.swift
//  ToDoTests
//
//  Created by kiranjith on 10/04/2025.
//

import Foundation
@testable import ToDo

class APIClientMock: APIClientProtocol {
    
    var coordinateAddess: String?
    var coordinateReturnValue: Coordinate?
    
    func coordinate(for address: String, completion:(Coordinate?)->Void) {
        coordinateAddess = address
        completion(coordinateReturnValue)
    }
}
