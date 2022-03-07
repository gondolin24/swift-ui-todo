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
import SwiftUI

class ListViewModel: ObservableObject {
    
    private var apiClient = ApiClient()
    
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
        
    }
    
    @Published var isLoaded : Bool = false
    
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        self.isLoaded = false

        Task {
            await GetItems() { items in
                   DispatchQueue.main.async {
                       

                       self.items = items.sorted {
                           $0.index < $1.index
                       }
  
                       self.isLoaded = true
                   }
               }
        }
     
    }
    
    func MigrateData(){
        Task{
            await withTaskGroup(of: Bool.self, body: { group in
                for index in self.items {
                            group.addTask {
                                await self.apiClient.editItem(pk: index)
                                return true
                            }
                  }
                
                for await _ in group {
                    print("Deleted")
                }
            })
            
        }
        
    }
    
    
    func GetItems(completionHandler: @escaping ([ItemModel])-> Void) async{
        
        return  completionHandler(await apiClient.fetchItems())
    }
    
    func UpdateItem(item: ItemModel, completionHandler: @escaping (Void)-> Void)async {

        return  completionHandler(await apiClient.editItem(pk: item))

    }
    
    func InsertItem(item: ItemModel, completionHandler: @escaping (Void)-> Void)async {

        return  completionHandler(await apiClient.insertItem(pk: item))

    }
    
    func DeleteItem(itemsToDelete:[Int] ,completionHandler: @escaping (Void)-> Void) async{

        return completionHandler(  await withTaskGroup(of: Bool.self, body: { group in
            for index in itemsToDelete {
                        group.addTask {
                            await self.apiClient.deleteItem(pk: self.getItemById(id: index))
                            return true
                        }
              }
            
            for await _ in group {
                print("Deleted")
            }
        }))
    }
    
    
    func getItemById(id: Int) -> ItemModel{
        
        return self.items[id]
    }
    
    func deleteItem(indexSet: IndexSet) {
        self.isLoaded = false
        Task {
            await DeleteItem(itemsToDelete: Array(indexSet), completionHandler: { Void in
                DispatchQueue.main.async {
                    self.items.remove(atOffsets: indexSet)
                    self.isLoaded = true

                }
            })

        }
        

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
    
 
    
    func dateToString(date: Date)->String{
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "yyyy-MM-dd"
        return formatter3.string(from: date)
    }
    
    func updateItem(item: ItemModel){
        
        if let index = items.firstIndex(where: { $0.id == item.id}){
            // run this code
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems(){
    }
    
    
    func addItem(title: String, date: Date){
     
        
        let newItem = ItemModel(title: title, isCompleted: false, date: dateToString(date: date) , index: items.count)
        self.isLoaded = false

        Task {

            await InsertItem(item: newItem, completionHandler: { Void in
                DispatchQueue.main.async {
                    self.items.append(newItem)
                    self.isLoaded = true
                }
            })
        }
    }
    
    
    func overWriteItem(currentItem: ItemModel, title: String, date: Date){
        
        if let index = items.firstIndex(where: { $0.id == currentItem.id}){
            // run this code
            let item = self.items[index]
            let newItem = ItemModel(title: title, isCompleted: item.isCompleted, date: dateToString(date: date), index: item.index)
            self.isLoaded = false

            Task {
                await UpdateItem(item: newItem, completionHandler: { Void in
                    DispatchQueue.main.async {
                        self.items = self.items.map({ (item) -> ItemModel in
                            if item.id == currentItem.id {
                                return ItemModel(title: title, isCompleted: item.isCompleted, date: self.dateToString(date: date), index: item.index)
                                
                            }else{
                                return item
                            }
                            
                        })
                        self.isLoaded = true

                    }
                })

            }
            
        }
        
    }
    
}
