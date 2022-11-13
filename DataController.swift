//
//  DataController.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/12.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDoList")
    
    init() {
        container.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
