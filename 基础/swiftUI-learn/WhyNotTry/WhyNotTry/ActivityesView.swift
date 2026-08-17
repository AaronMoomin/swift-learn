//
//  ContentView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct ActivityesView: View {
    var activities = ["Archery", "Baseball", "Basketball", "Bowling", "Boxing", "Cricket", "Curling", "Fencing", "Golf", "Hiking", "Lacrosse", "Rugby", "Squash"]
    var colors: [Color] = [.white, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]


    // 在需要修改的任何视图属性之前加上 @State 被称为 属性包装器 会自动监控该属性的变化 确保用户页面保持最新值
    @State private var selected = "Basketball"
    @State private var id = 1
    
    var body: some View {
        VStack {
            Text("why not try")
                .font(.largeTitle.bold())
            
            Spacer()
            
            VStack {
                Circle()
                    .fill(.blue)
                    .padding()
                // overlay() 的修饰符，它能够将一个视图放置在另一个视图之上
                    .overlay(Image(systemName: "figure.\(selected.lowercased())"))
                    .font(.system(size: 144))
                    .foregroundColor(colors.randomElement() ?? .white)
                Text("\(selected)")
                // .title SwiftUI 内置的动态类型大小之一 这意味着字体会根据用户的设置进行缩放
                    .font(.title)
            }
            .transition(.slide)
            // 使用id() 来识别整个组
            .id(id)
            
            Spacer()
            
            Button("try again") {
                // 使用withAnimation 将需要动画处理的操作包裹起来
                withAnimation(.easeIn(duration: 1)) {
                    selected = activities.randomElement() ?? "Archery"
                    id += 1
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
