//
//  ScrollView_simple.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct ScrollView_simple: View {
    var body: some View {
//      showsIndicators 是否显示滚动条
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                ForEach(1...20, id: \.self) { i in
                        Text("滚动项\(i)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
//       滚动条样式 .hidden/.automatic/.visible
        .scrollIndicators(.hidden)
//       滚动时是否关闭键盘 .immediately/.interactively
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    ScrollView_simple()
}
