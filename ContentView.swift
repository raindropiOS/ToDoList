//
//  ContentView.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/06.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var listStore: ListStore = ListStore(list: listData)
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    
                    ForEach(0..<listStore.list.count, id: \.self) { idx in
                        HStack {
                            Button {
                                listStore.list[idx].isClear.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: listStore.list[idx].isClear ? "checkmark.square.fill" : "square" )
                                        .resizable()
                                        .foregroundColor(.orange)
                                        .frame(width: 20, height: 20)
                                  
                                }
                            }
                            TextField(listStore.list[idx].contents, text: $listStore.list[idx].contents)
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                    
                   
                    
                }
                .navigationTitle(Text("To Do List"))
                .navigationBarItems(trailing: EditButton())
                
                
                
            }
            
            Button {
                listStore.list.append(SthToDo(contents: "", isClear: false))
            } label: {
                Text("Add new task")
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        listStore.list.remove(atOffsets: offsets)
    }
    func moveItem(from source: IndexSet, to destination: Int) {
        listStore.list.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
