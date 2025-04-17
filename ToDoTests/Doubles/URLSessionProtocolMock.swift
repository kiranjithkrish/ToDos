//
//  URLSessionProtocolMock.swift
//  ToDoTests
//
//  Created by kiranjith on 15/04/2025.
//

import Foundation
@testable import ToDo

class URLSessionProtocolMock: URLSessionProtocol {
    
    var dataForDelegateReturnValue: (Data, URLResponse)?
    var dataForDelegateRequest: URLRequest?
    var dataForDelegateError: Error?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let error = dataForDelegateError {
            throw error
        }
        dataForDelegateRequest = request
        guard let data = dataForDelegateReturnValue else {
            fatalError()
        }
        return data
    }
}
