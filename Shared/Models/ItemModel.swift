//
//  ItemModel.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

import Foundation

//Immutable Struct

struct ItemModel: Identifiable {
    let id: String
    let title : String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool){
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion()->ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
