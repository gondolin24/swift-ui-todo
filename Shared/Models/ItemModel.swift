//
//  ItemModel.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title : String
    let isCompleted: Bool
    
    
}
