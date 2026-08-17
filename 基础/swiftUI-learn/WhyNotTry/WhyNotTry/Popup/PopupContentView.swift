//
//  PopupContentView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/27.
//

import SwiftUI

struct PopupContentView: View {
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var showActions = false
    @State private var showPopover = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("编辑资料") { showSheet = true}
                .buttonStyle(.borderedProminent)
            Button("显示错误") { showAlert = true }.buttonStyle(.borderedProminent)
            Button("选择照片来源") { showActions = true }.buttonStyle(.borderedProminent)
            Button("筛选") { showPopover = true }.buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showSheet) {
            EditProfileView()
        }
        .alert("保存失败", isPresented: $showAlert) {
            Button("知道了", role: .cancel) {}
        } message: {
            Text("请检查网络后重试")
        }
        // 破坏性行为标记 role: .destructive，系统会用正确的强调样式
        .confirmationDialog("添加照片", isPresented: $showActions) {
            Button("拍照") {}
            Button("从相册选择") {}
            Button("删除当前照片", role: .destructive) {}
            Button("取消", role: .cancel) {}
        }
        // 在 iPad、Mac 上会贴着触发按钮展示；在 iPhone 这类紧凑宽度环境中通常会自适应成 sheet 风格
        .popover(isPresented: $showPopover, arrowEdge: .top) {
            VStack(alignment: .leading) {
                Text("筛选条件")
                Toggle("只看收藏", isOn: .constant(false))
            }
            .padding()
        }
    }
}

struct EditProfileView: View {
    // NavigationStackView、Sheet等产生的次级界面，可使用 @Environment(\.dismiss) var dismiss 自行控制消失
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("昵称", text: .constant(""))
            }
            .navigationTitle("编辑资料")
            .toolbar {
                Button("完成") { dismiss() }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PopupContentView()
}
