//
//  ListRowView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-28.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
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


struct ListRowView_Previews: PreviewProvider {
    
    static  var item1 = ItemModel(title: "Get eggs", isCompleted: false, date: Date())
    static  var item2 = ItemModel(title: "THIS IS A ERY LONG ITEMx", isCompleted: true, date: Date())
    static var previews: some View {
        
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
            
        }
        .previewLayout(.sizeThatFits)
        
    }
}
