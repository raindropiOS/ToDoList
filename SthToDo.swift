//
//  ListData.swift
//  ToDoList
//
//  Created by 박시현 on 2022/11/06.
//

import Foundation

struct SthToDo: Identifiable {
    
    let id = UUID()
    // 프라퍼티 : 날짜, 내용, 클리어 여부
    var contents: String
    var isClear: Bool
    
    mutating func changeClearStatus() {
        isClear.toggle()
    }
}
