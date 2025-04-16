//
//  APIClient.swift
//  ToDo
//
//  Created by kiranjith on 10/04/2025.
//

import Foundation
import CoreLocation

protocol APIClientProtocol {
    func coordinate(for address: String, completion:@escaping (Coordinate?)->Void)
}

protocol GeocoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: GeocoderProtocol {}

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}


class APIClient: APIClientProtocol {
    
    lazy var geoCoder: GeocoderProtocol = CLGeocoder()
    lazy var session: URLSessionProtocol = URLSession.shared
    
    func coordinate(for address: String, completion:@escaping (Coordinate?)->Void) {
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let clCoordinate = placemarks?.first?.location?.coordinate else {
                completion(nil)
                return
            }
            let coordinate = Coordinate(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
            completion(coordinate)
        }
    }
    
    func fetchToDoItems() async throws -> [ToDoItem] {
        guard let url = URL(string: "dummy") else {
            return []
        }
        let request = URLRequest(url: url)
        let (data,_) = try await session.data(for: request, delegate: nil)
        
        let todos = try JSONDecoder().decode([ToDoItem].self, from: data)
        return todos
    }
}
