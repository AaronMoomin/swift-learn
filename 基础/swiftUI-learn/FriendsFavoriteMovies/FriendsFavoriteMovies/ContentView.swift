//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by hcp on 2026/7/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Friends" ,systemImage: "person.and.person") {
                FriendList()
            }
            Tab("Movies", systemImage: "film.stack") {
                FilteredMovieList()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
