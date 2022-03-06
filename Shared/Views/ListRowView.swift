
///

//
//  ListRowView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-28.
//

import SwiftUI

struct ListRowView: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    let item: ItemModel
    @Binding var updateMode: Bool
    
    
    
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        
        
        VStack{
            
            HStack {
                
                Image(systemName: item.isCompleted ? "checkmark.circle": "circle")
                    .foregroundColor(item.isCompleted ? .green : .red)
                
                VStack(alignment: .leading){
                    Text(item.title)
                }
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(dateFormatter.string(from: item.date))
                }
                
            }
            .font(.title2)
            .padding(.vertical, 8)
            
            
        }
    }
    
    
    
    
    
    
    func isEditMode() -> Bool{
        return editMode?.wrappedValue == .active
    }
    
    
    
}


struct ListRowView_Previews: PreviewProvider {
    
    static  var item1 = ItemModel(title: "Get eggs", isCompleted: false, date: Date(), index: 1)
    static  var item2 = ItemModel(title: "THIS IS A ERY LONG ITEMx", isCompleted: true, date: Date(), index: 0)
    
    
    @State static var editMode: Bool = false
    @State static var nonEditMode: Bool = true
    
    static var previews: some View {
        
        Group{
            ListRowView(item: item1, updateMode: $editMode)
                .environmentObject(ListViewModel())
            ListRowView(item: item2, updateMode: $nonEditMode)
                .environmentObject(ListViewModel())
            
        }
        .previewLayout(.sizeThatFits)
        
    }
}


