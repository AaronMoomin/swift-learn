//
//  ListView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct ListView: View {
    @State private var items = ["苹果", "香蕉", "橙子"]
    @State private var editing = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.self){ item in
                    Text(item)
                }
                .onDelete { index in
                    items.remove(atOffsets: index)
                }
                .onMove { source, destination in
                    items.move(fromOffsets: source, toOffset: destination)
                }
            }
//           .plain/.grouped/.insetGrouped/.sidebar
            .listStyle(.insetGrouped)
            .navigationTitle("水果列表")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ListView()
}
