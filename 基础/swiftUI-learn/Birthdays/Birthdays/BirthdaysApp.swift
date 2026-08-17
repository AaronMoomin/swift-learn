//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by hcp on 2026/7/29.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
