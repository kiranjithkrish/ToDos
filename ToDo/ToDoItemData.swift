//
//  ToDoItemData.swift
//  ToDo
//
//  Created by kiranjith on 02/04/2025.
//

import Foundation

class ToDoItemData: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var withDate = false
}
