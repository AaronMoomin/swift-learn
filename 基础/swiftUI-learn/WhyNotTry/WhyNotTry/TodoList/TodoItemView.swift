//
//  TodoItemView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/27.
//

import SwiftUI

struct TodoItemView: View {
    let title: String
    var isDone: Binding<Bool>? = nil
    
    var body: some View {
        if let isDone {
            Toggle(title, isOn: isDone)
        } else {
            Text(title)
                .foregroundStyle(.gray)
                .strikethrough()
        }
    }
}

#Preview {
    TodoItemView(title: "Test", isDone: .constant(false))
    TodoItemView(title: "Test")
}
