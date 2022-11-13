//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/06.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
