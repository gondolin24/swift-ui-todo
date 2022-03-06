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
        refresh()
        
    }
    func moveItem(from:IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
        refresh()
      
    }
    
    func refresh(){
        items = zip(items.indices, items).map({  (index, item)->ItemModel in
            
            return item.updateIndex(newIndex:index)
        })
    }
    
    func addItem(title: String, date: Date){
        let newItem = ItemModel(title: title, isCompleted: false, date: date, index: items.count)
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
    
    
    func overWriteItem(currentItem: ItemModel, title: String, date: Date){
        
        items = items.map({ (item) -> ItemModel in
            if item.id == currentItem.id {
                return ItemModel(title: title, isCompleted: item.isCompleted, date: date, index: item.index)
                
            }else{
                return item
                
            }
            
        })
        // persist items
        saveItems()
    }
    
}
