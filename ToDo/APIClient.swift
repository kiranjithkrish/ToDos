//
//  APIClient.swift
//  ToDo
//
//  Created by kiranjith on 10/04/2025.
//

import Foundation


protocol APIClientProtocol {
    func coordinate(for address: String, completion:(Coordinate?)->Void)
}


class APIClient: APIClientProtocol {
    func coordinate(for address: String, completion:(Coordinate?)->Void) {
        
    }
}
