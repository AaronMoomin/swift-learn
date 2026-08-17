//
//  InteractionComponent.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct InteractionComponent: View {
    @State private var isOn = false
    @State private var text = ""
    @State private var progress = 50.0
    @State private var selectedFruit = "苹果"
    let fruits = ["苹果", "香蕉", "橙子", "葡萄"]
    @State private var selectedDate = Date()
    @State private var count = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    print("click")
                }) {
                    HStack {
                        Image(systemName: "paperplane")
                        Text("提交")
                    }
                }
    //           按钮样式 .plain/.bordered/.borderedProminent/.borderless
                .buttonStyle(.borderedProminent)
    //           按钮主色调
                .tint(.blue)
    //           是否禁用
                .disabled(false)
                .padding()
                
                Toggle(isOn: $isOn) {
                    Text("开启通知")
                }
    //           样式 .switch/.button
                .toggleStyle(.switch)
    //           开启颜色
                .tint(.yellow)
                .padding()
                
    //           占位符 绑定文本
                TextField("请输入用户名", text: $text)
    //              键盘类型 .numberPad/.emailAddress/.default
                    .keyboardType(.default)
    //              自动大小写 .none/.words
                    .autocapitalization(.none)
    //              是否禁用自动纠错
                    .disableAutocorrection(false)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onSubmit {
                        print($text.wrappedValue)
                    }
                
    //          绑定文本
                TextEditor(text: $text)
                    .font(.body)
                    .foregroundStyle(.black)
    //              是否显示滚动背景 .hidden可去除白色背景
                    .scrollContentBackground(.hidden)
                    .background(Color.gray.opacity(0.1))
                    .frame(height: 150)
                    .cornerRadius(8)
                    .padding(.horizontal)

                Slider(value: $progress, in: 0...100, step: 1)
                    .tint(.orange)
                    .padding()
                Text("进度 \($progress.wrappedValue)")
                
                Picker(selection: $selectedFruit, label: Text("选择水果")) {
                    ForEach(fruits, id: \.self) {
                        Text($0)
                    }
                }
    //          样式 .menu/.wheel/.segmented
                .pickerStyle(.wheel)
                .padding()
                
//              displayedComponents 显示组件.date/.hourAndMinute
                DatePicker("选择日期", selection: $selectedDate, displayedComponents: .date)
//                  样式 .compact/.wheel/.graphical
                    .datePickerStyle(.wheel)
                    .padding()
                
                Stepper("数量: \(count)",value: $count, in: 0...10, step: 1)
                    .padding()
            }
        }
    }
}

#Preview {
    InteractionComponent()
}
