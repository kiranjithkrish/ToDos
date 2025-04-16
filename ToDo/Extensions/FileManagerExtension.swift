//
//  FileManagerExtension.swift
//  ToDo
//
//  Created by kiranjith on 21/03/2025.
//

import Foundation


extension FileManager {
    func documentsUrl(name: String) -> URL {
        guard let documentUrl = urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        return documentUrl.appendingPathComponent(name)
    }
}
