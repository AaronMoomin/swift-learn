//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by hcp on 2026/7/11.
//

import SwiftUI

@main
struct LandmarksApp: App {
    // 定义需要传递的数据 modelData
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            // 使用.environment(modelData) 给子孙传递数据
            ContentView()
                .environment(modelData)
        }
    }
}
