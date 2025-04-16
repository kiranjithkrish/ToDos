//
//  Location.swift
//  ToDo
//
//  Created by kiranjith on 19/03/2025.
//

import Foundation

struct Location: Equatable, Codable {
    let name: String
    let coordinate: Coordinate?
    
    init(name: String, coordinate: Coordinate? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        guard let lhsCord = lhs.coordinate, let rhsCord = rhs.coordinate else {
            return false
        }
        if abs(lhsCord.latitude - rhsCord.latitude) > 0.000_000_1 {
             return false
        }
        if abs(lhsCord.longitude - rhsCord.longitude) > 0.000_000_1 {
             return false
        }
        return true
    }
}
