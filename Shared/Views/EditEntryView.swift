//
//  EditEntryView.swift
//  TodoList
//
//  Created by Eduardo Guzman Diaz on 2022-03-06.
//

import SwiftUI

struct EditEntryView: View {
    
    

    @State var itemToEdit: ItemModel

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewMode: ListViewModel
    @State var textFieldText : String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                DatePickerView(selectedDate: $selectedDate)
                Button (action: saveButtonPress,
                label: {
                    Text("UPDATE".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)

                })


            }
            .padding(14)
            
            }.navigationTitle("Update Content")
            .alert(isPresented: $showAlert) {
                getAlert()
            }.onAppear(perform: {
                textFieldText = itemToEdit.title
                selectedDate = stringToDate(strDate: itemToEdit.date)
            })
    }
    
    func stringToDate(strDate: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: strDate)!
    }
    
    
    func getAlert()->Alert{
        return Alert(title: Text(alertTitle))
    }
    func saveButtonPress(){
        if textIsAppropriate(){
            
            listViewMode.overWriteItem( currentItem: itemToEdit,  title: textFieldText, date: selectedDate)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    func textIsAppropriate()->Bool{
        if textFieldText.count < 3 {
            alertTitle = "Your new todo Item must me at least 2 characters long 🤪"
            showAlert.toggle()
            return false
        }
        return true
    }
}

struct EditEntryView_Previews: PreviewProvider {
    
    
    static var itemToEdit = ItemModel(title: "THIS IS A ERY LONG ITEMx", isCompleted: true, date: "2020-08-13", index: 0)
    
    static var previews: some View {
        
        
        EditEntryView(itemToEdit: itemToEdit)
            .environmentObject(ListViewModel())
    }
}
