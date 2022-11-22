//
//  WeekCalendarView.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/16.
//

import SwiftUI

struct WeekCalendarView: View {
    @StateObject var weekStore = WeekStore()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeekCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalendarView()
    }
}
