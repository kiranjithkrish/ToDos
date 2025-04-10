//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by kiranjith on 02/04/2025.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    
    
    var body: some View {
        VStack {
            TextField("Title", text: $data.title)
            Toggle("Add Date", isOn: $data.withDate)
            if data.withDate {
                DatePicker("Date", selection: $data.date)
            }
        }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
