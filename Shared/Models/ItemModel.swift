//
//  ItemModel.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

import Foundation

//Immutable Struct

struct ItemModel: Identifiable, Codable {
    let id: String
    let title : String
    let isCompleted: Bool
    let date : String
    let index: Int
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, date: String, index: Int){
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
        // default the dta
        self.date = date
        self.index = index
    }
    
    func updateIndex(newIndex: Int)->ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, date: date, index: newIndex)
    }
    
    func updateCompletion()->ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, date: date, index: index)
    }
}
