//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by kiranjith on 02/04/2025.
//

import SwiftUI

protocol ToDoItemInputViewDelegate {
    func addToDoItem(with data: ToDoItemData, coordinate: Coordinate?)
}

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    let apiClient: APIClientProtocol
    var delegate: ToDoItemInputViewDelegate?
    
    
    var body: some View {
        Form {
            SwiftUI.Section {
                TextField("Title", text: $data.title)
                Toggle("Add Date", isOn: $data.withDate)
                if data.withDate {
                    DatePicker("Date", selection: $data.date)
                }
                TextField("Description", text: $data.itemDescription)
            }
            
            SwiftUI.Section {
                TextField("Location Name", text: $data.locationName)
                TextField("Address", text: $data.addressString)
            }
            
            SwiftUI.Section {
                Button(action: addToDoItem) {
                    Text("Save")
                }
            }
        }
    }
    
    func addToDoItem() {
        if !data.addressString.isEmpty {
            apiClient.coordinate(for: data.addressString) { coordinate in
                self.delegate?.addToDoItem(with: data, coordinate: coordinate)
            }
        } else {
            self.delegate?.addToDoItem(with: data, coordinate: nil)
        }
        
    }
}

#Preview("ToDo Item Input", traits: .sizeThatFitsLayout) {
    ToDoItemInputView(data: ToDoItemData(),
                      apiClient: APIClient())
}
