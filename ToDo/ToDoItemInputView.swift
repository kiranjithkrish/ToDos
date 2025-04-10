//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by kiranjith on 02/04/2025.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    let apiClient: APIClientProtocol
    
    
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
        apiClient.coordinate(for: data.addressString) { coordinate in
            
        }
    }
}

#Preview("ToDo Item Input", traits: .sizeThatFitsLayout) {
    ToDoItemInputView(data: ToDoItemData(),
                      apiClient: APIClient())
}
