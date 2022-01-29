//
//  ListView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

import SwiftUI

struct ListView: View {
    
    @State var items : [ItemModel] = [
        ItemModel(title: "Loblaws", isCompleted: false),
        ItemModel(title: "Bike", isCompleted: true),
        ItemModel(title: "swift work", isCompleted: false)
    
    ]
    var body: some View {
        List{
            ForEach(items){ item in
                ListRowView(item: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List")
        .navigationBarItems(leading: EditButton(), trailing:
                  NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()

        }
    }
}
