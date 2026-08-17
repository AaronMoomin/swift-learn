//
//  DiceView.swift
//  DiceRoller
//
//  Created by hcp on 2026/7/28.
//

import SwiftUI

struct DiceView: View {
    @State var numberOfPips: Int = 1
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(numberOfPips).fill")
            // 表示图像可以拉伸以填充所有可用的空间
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
            // .foregroundStyle 修饰符可以将主色设置为黑色，将次要色设置为白色
                .foregroundStyle(.black, .white)
            
            Button("Roll") {
                withAnimation {
                    numberOfPips = Int.random(in: 1...6)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    DiceView()
}
