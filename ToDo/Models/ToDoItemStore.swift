//
//  ToDoItemStore.swift
//  ToDo
//
//  Created by kiranjith on 20/03/2025.
//

import Foundation
import Combine

protocol ToDoItemStoreProtocol {
    var itemPublisher: CurrentValueSubject<[ToDoItem], Never> {
        get set
    }
    func check(_ item: ToDoItem)
}

class ToDoItemStore: ToDoItemStoreProtocol {
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    let fileName: String
    
    init(fileName: String = "todoitems") {
        self.fileName = fileName
        loadItems()
    }
    
    private func saveItems() {
        let url = FileManager.default
            .documentsUrl(name: fileName)
            do {
                let data = try JSONEncoder().encode(items)
                try data.write(to: url)
            } catch {
                print("error: \(error)")
            }
            
        
    }
    
    private func loadItems() {
        let url = FileManager.default
            .documentsUrl(name: fileName)
            do {
                let data = try Data(contentsOf: url)
                items = try JSONDecoder().decode([ToDoItem].self, from: data)
            } catch {
                print("error: \(error)")
            }
       
    }
    
    private var items: [ToDoItem] = [] {
        didSet {
            itemPublisher.send(items)
        }
    }
    
    func add(_ item: ToDoItem) {
        items.append(item)
        saveItems()
    }
    
    func check(_ item: ToDoItem) {
        guard let index = items.firstIndex(of: item) else {
            return
        }
        items[index].done.toggle()
        saveItems()
    }
}
