//
//  ListStore.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/06.
//

import Foundation

class ListStore: ObservableObject {
    
    @Published var list: [SthToDo]
    
    init(list: [SthToDo] = []) {
        self.list = list
    }
}
