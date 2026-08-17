//
//  BindingView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/27.
//

import SwiftUI

// 子视图修改父视图的数据
struct BindingView: View {
    @State private var name = ""
    
    var body: some View {
        VStack {
            Text("name: \(name)")
            NameEditor(name: $name)
        }
    }
}

struct NameEditor: View {
    @Binding var name: String
    
    var body: some View {
        TextField("enter name", text: $name)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(16)
            .padding(.horizontal)
    }
}

#Preview {
    BindingView()
}
