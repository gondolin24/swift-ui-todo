//
//  ListRowView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-28.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
            Text(title)
            Spacer()
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "This is the first Title!")
    }
}
