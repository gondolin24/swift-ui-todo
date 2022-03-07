//
//  ApiClient.swift
//  TodoList
//
//  Created by Eduardo Guzman Diaz on 2022-03-06.
//

import Foundation
import SwiftUI

class ApiClient {
    private let API_KEY = ""
    
    func fetchItems()  async ->  [ItemModel] {
        let getItems = Task { () -> Items in
            let url = URL(string: "https://comguzmantodo.hasura.app/api/rest/items")!
            var request = URLRequest(url: url)
            request.setValue(API_KEY, forHTTPHeaderField: "x-hasura-access-key")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let decodedResponse = try? JSONDecoder().decode(Items.self, from: data)
            let listItems = decodedResponse ?? Items(TodoItems: [])
            return listItems
        }
        
        let result = await getItems.result
        
        do {
            let respone =  try result.get()
            return respone.TodoItems
        } catch {
            print("Unknown error.")
            return []
        }
    }
    
    
    
    
    func insertItem(pk: ItemModel) async -> Void{
        
        let updateItem = Task { () -> Void in
            let url = URL(string: "https://comguzmantodo.hasura.app/api/rest/insert")!
            var request = URLRequest(url: url)
            request.setValue(API_KEY, forHTTPHeaderField: "x-hasura-access-key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "PUT"
            
            let body:[String: Any] = [
                
                "obj" : [
                    "id": pk.id,
                    "date": pk.date,
                    "index": pk.index,
                    "isCompleted": pk.isCompleted,
                    "title": pk.title,
                ]
                
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
        }
        
        let result = await updateItem.result
        
        do {
            let respone =  try result.get()
        } catch {
            print("Unknown error.")
        }
    }
    
    
    
    func editItem(pk: ItemModel) async -> Void{
        
        let updateItem = Task { () -> Void in
            let url = URL(string: "https://comguzmantodo.hasura.app/api/rest/update")!
            var request = URLRequest(url: url)
            request.setValue(API_KEY, forHTTPHeaderField: "x-hasura-access-key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "PUT"
            
            let body:[String: Any] = [
                "pk": pk.id,
                "obj" : [
                    "date": pk.date,
                    "index": pk.index,
                    "isCompleted": pk.isCompleted,
                    "title": pk.title,
                ]
                
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
        }
        
        let result = await updateItem.result
        
        do {
            let respone =  try result.get()
        } catch {
            print("Unknown error.")
        }
    }
    
    func deleteItem(pk: ItemModel) async -> Void{
        let deleteItems = Task { () -> Void in
            let url = URL(string: "https://comguzmantodo.hasura.app/api/rest/delete")!
            var request = URLRequest(url: url)
            request.setValue(API_KEY, forHTTPHeaderField: "x-hasura-access-key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "DELETE"
            
            let body:[String: AnyHashable] = [
                "pk": pk.id
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
        }
        
        let result = await deleteItems.result
        
        do {
            let respone =  try result.get()
        } catch {
            print("Unknown error.")
        }
        
    }
    
}
