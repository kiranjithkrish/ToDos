//
//  GeoCoderProtocolMock.swift
//  ToDoTests
//
//  Created by kiranjith on 11/04/2025.
//

import Foundation
@testable import ToDo
import CoreLocation

class GeoCoderProtocolMock: GeocoderProtocol {
    var geocodeAddressString: String?
    var completion: CLGeocodeCompletionHandler?
    
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        geocodeAddressString = addressString
        completion = completionHandler  
    }
}
