//
//  StackView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct StackView: View {
    var body: some View {
    //          垂直布局
            VStack {
                VStack(alignment: .center, spacing: 12) {
                    Text("标题")
                        .font(.headline)
                    Text("副标题")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding()
            
            
    //              水平布局
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "bell")
                Text("消息通知")
                Spacer() // 推挤右侧视图到最右
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
        
    //               层级栈
            ZStack(alignment: .bottomTrailing) {
                Image("chilkoottrail")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
    //                      层级
                    .zIndex(1)
                Text("标签")
                    .font(.title)
                    .foregroundStyle(.white)
                    .cornerRadius(4)
                    .padding(8)
                    .zIndex(1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    StackView()
}
