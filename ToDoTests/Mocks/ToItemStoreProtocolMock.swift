//
//  ToItemStoreProtocolMock.swift
//  ToDoTests
//
//  Created by kiranjith on 24/03/2025.
//

import Foundation

import Foundation
import Combine
@testable import ToDo

class ToDoItemStoreMock: ToDoItemStoreProtocol {
    var itemPublisher =  CurrentValueSubject<[ToDo.ToDoItem], Never>([])
    
    var checkLastCallArgument: ToDoItem?
    
    func check(_ item: ToDo.ToDoItem) {
        checkLastCallArgument = item
    }
    
}
