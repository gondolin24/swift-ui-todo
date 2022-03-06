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
    let date : Date
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, date: Date?){
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
        // default the dta
        self.date = date ?? Date()
    }
    
    func updateCompletion()->ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, date: date)
    }
}
