//
//  GridView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 8, verticalSpacing: 8) {
            GridRow {
                Text("1")
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                Text("2")
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
            GridRow {
                Text("3")
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                Text("4")
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
        }
        .padding()
    }
}

#Preview {
    GridView()
}
