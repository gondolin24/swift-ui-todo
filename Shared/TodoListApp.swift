//
//  TodoListApp.swift
//  Shared
//
//  Created by Eduardo Guzman Diaz on 2022-01-28.
//

import SwiftUI

/*
 MVV Architecture
 
 Model - data point
 View - UI
 ViewModel - Manages Models for View
 */

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .preferredColorScheme(.dark)
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
