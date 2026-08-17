//
//  ScrollView_lazyVStack.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct ScrollView_lazyVStack: View {
    var body: some View {
        ScrollView {
//          pinnedViews 固定视图 .sectionHeaders/.sectionFooters
            LazyVStack(spacing: 10, pinnedViews: .sectionHeaders) {
                Section(header: Text("头部固定").font(.title).background(Color.white)) {
                    ForEach(1...100, id: \.self) { i in
                        Text("懒加载项 \(i)")
                            .frame(height: 50)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollView_lazyVStack()
}
