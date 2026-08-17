//
//  ObservableView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/27.
//

import SwiftUI
import Observation

// @Observable 多个页面共享的业务数据
@Observable
final class UserStore {
    var name = "tom"
    var isLoggedIn = false
}

struct ObservableView: View {
    @State private var user = UserStore()
    
    var body: some View {
        VStack {
            Text(user.name)
            
            Button(user.isLoggedIn ? "logout" : "login") {
                user.isLoggedIn.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ObservableView()
}
