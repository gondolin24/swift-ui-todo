//
//  AddView.swift
//  TodoList (iOS)
//
//  Created by Eduardo Guzman Diaz on 2022-01-28.
//

import SwiftUI

struct AddView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewMode: ListViewModel
    @State var textFieldText : String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Button (action: saveButtonPress,
                label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)

                })

            }
            .padding(14)
            }.navigationTitle("Add and Item 🖋")
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        
          
    }
    
    
    func getAlert()->Alert{
        return Alert(title: Text(alertTitle))
    }
    func saveButtonPress(){
        if textIsAppropriate(){
            listViewMode.addItem(title: textFieldText)
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

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
        }
        
    }
}
