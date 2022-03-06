//
//  +View.swift
//  TodoList
//
//  Created by Eduardo Guzman Diaz on 2022-03-06.
//

import Foundation

extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
