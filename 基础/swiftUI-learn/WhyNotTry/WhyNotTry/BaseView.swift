//
//  BaseView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/24.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, World!Hello, World!Hello, World!Hello, World!")
                //           设置字体
                    .font(.largeTitle.bold())
                //          设置对齐方式 .leading左对齐 .center居中对齐 .trailing右对齐
                    .multilineTextAlignment(.center)
                //          文本颜色(支持渐变)
                    .foregroundStyle(LinearGradient(colors: [.red,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                //          行数限制 nil表示无限制
                    .lineLimit(1)
                //          截断方式 .head头部... .tail尾部... .middle中间...
                    .truncationMode(.middle)
                    
                
    //          本地图片
                Image("chilkoottrail")
    //              自适应尺寸
                    .resizable()
    //              适配方式
                    .scaledToFit()
    //              大小
                    .frame(width: 200,height: 200)
    //              裁剪 Circle()圆形 RoundedRectangle(cornerRadius: 16)圆角
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
    //           网图
                AsyncImage(url: URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791375599.png")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure(_):
                        Image(systemName: "photo.badge.exclamationmark")
                    @unknown default: EmptyView()
                    }
                }
                .frame(width: 200,height: 100)
                
    //           内置图标 SF Symbols
                Image(systemName: "heart.fill")
    //              图标大小
                    .font(.system(size: 32))
    //               颜色
                    .foregroundStyle(.red)
    //              图标变体 .fill/.circle/.square
                    .symbolVariant(.circle)
            }
        }
    }
}

#Preview {
    BaseView()
}
