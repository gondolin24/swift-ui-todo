//
//  ListView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-29.
//

import SwiftUI

struct ListView: View {
    
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var editMode: EditMode = .inactive

    
    @State var updateMode: Bool = false
    

    
    func isEditMode() -> Bool{
        return editMode == .active
    }
    
    
    var body: some View {
        ZStack {
           
            
            if listViewModel.items.isEmpty{
                NoItemsView()
            }else{
                List{
                   
                    ForEach(listViewModel.items){ item in
                        
                        if(updateMode){
                            NavigationLink(destination: EditEntryView(itemToEdit: item)) {
                                
                                ListRowView(item: item, updateMode: $updateMode)
                            }
                        }else{
                            ListRowView(item: item, updateMode: $updateMode)
                                .onTapGesture {
                                    withAnimation(.linear){
                                        listViewModel.updateItem(item: item)
                                    }
                                }
                            
                        }
                        
                        
                    }.onDelete(perform: listViewModel.deleteItem)
                        .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                if(!updateMode){
                    EditButton()

                }

            }
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if (editMode != .active) {

                    Button( updateMode ? "Done": "Update") {
                        updateMode = !updateMode
                    }
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        }
        .environment(\.editMode, self.$editMode)
    }
    

    
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

