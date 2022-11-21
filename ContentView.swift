//
//  ContentView.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/06.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \SthToDo.userOrder, ascending: true),
        NSSortDescriptor(keyPath: \SthToDo.timeAdded, ascending: true),
        
    ]) var toDoList: FetchedResults<SthToDo>
    @State private var textInput: String = ""
    @State private var showingInputAlert: Bool = false
    @State private var showingRemoveAllAlert: Bool = false
    
    
    //    @ObservedObject var listStore: ListStore = ListStore(list: listData)
    
    var body: some View {
        
        VStack {
            NavigationView {
                List {
                    ForEach(toDoList, id: \.self) { sthToDo in
                        HStack {
                            Button {
                                sthToDo.isClear.toggle()
                            } label: {
                                Image(systemName: sthToDo.isClear ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:25)
                                    .foregroundColor(.orange)
                            }
                            
                            Text(sthToDo.content ?? "Unknown")
                        }
                    }
                    .onDelete(perform: deleteTask)
                    .onMove(perform: moveTask)
                    
                    Button {
                        showingInputAlert = true
                    } label: {
                        Text("Add task")
                            .foregroundColor(.blue)
                    }
                    .alert("You're gonna do...", isPresented: $showingInputAlert) {
                        TextField(text: $textInput, label: {
                            Text("input here")
                        })
                        .keyboardType(.default)
                        
                        HStack {
                            Button("Cancel", role: .cancel) {}
                            Button("Add task", role: nil) {
                                let sthToDo = SthToDo(context: moc)
                                sthToDo.id = UUID()
                                sthToDo.content = textInput
                                sthToDo.timeAdded = Date()
                                sthToDo.isClear = false
                                
                                try? moc.save()
                                
                                textInput = ""
                            }
                        }
                    }
                    
//                    Button {
//
//                    } label: {
//                        Text("Remove All")
//                    }
//                    .alert("Are sure to remove all?", isPresented: $showingRemoveAllAlert) {
//                        HStack {
//                            Button {
//
//                            } label: {
//                                Text("Delete")
//                                    .foregroundColor(.red)
//
//                            }
//
//                            Button("Cancel", role: .cancel) {}
//                        }
//                    }
                }
                .navigationTitle(Text("To Do List"))
                .navigationBarItems(trailing: EditButton())
                //                .toolbar(content: EditButton())
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = toDoList[index]
            moc.delete(task)
        }
    }
    
    func moveTask( from source: IndexSet, to destination: Int)
    {
        // Make an array of items from fetched results
        var revisedItems: [ SthToDo ] = toDoList.map{ $0 }
        
        // change the order of the items in the array
        revisedItems.move(fromOffsets: source, toOffset: destination )
        
        // update the userOrder attribute in revisedItems to
        // persist the new order. This is done in reverse order
        // to minimize changes to the indices.
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[ reverseIndex ].userOrder =
            Int16( reverseIndex )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
