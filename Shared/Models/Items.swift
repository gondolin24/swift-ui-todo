//
//  Items.swift
//  TodoList
//
//  Created by Eduardo Guzman Diaz on 2022-03-06.
//

import Foundation

struct Items:  Codable {
    let TodoItems: [ItemModel]

    init(TodoItems: [ItemModel]){
        self.TodoItems = TodoItems
    }
    

}
