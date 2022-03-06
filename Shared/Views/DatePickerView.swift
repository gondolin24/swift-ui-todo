//
//  DatePickerView.swift
//  TodoList
//
//  Created by Eduardo Guzman Diaz on 2022-03-06.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate : Date
    let startingDate: Date = Date()
    
  
    
    var body: some View {
       
        VStack{
            
        DatePicker("select a date", selection: $selectedDate,
                    displayedComponents: [.date])
            .datePickerStyle(
                 GraphicalDatePickerStyle()
            )
            .preferredColorScheme(.dark)

        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var selectedDate = Date()

    static var previews: some View {
        DatePickerView(selectedDate: $selectedDate)
    }
}
