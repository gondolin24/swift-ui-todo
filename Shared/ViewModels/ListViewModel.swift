//
//  ListViewModel.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

/*
 CRUD FUNCTIONS
 */

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
        
    }
    
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems  = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {
            return
        }
        
        self.items = savedItems
       
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)

    }
    func moveItem(from:IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, date: Date){
        let newItem = ItemModel(title: title, isCompleted: false, date: date)
        items.append(newItem)
        
    }
    
    func updateItem(item: ItemModel){
        
        if let index = items.firstIndex(where: { $0.id == item.id}){
            // run this code
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems(){
        if let encodedData  = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
