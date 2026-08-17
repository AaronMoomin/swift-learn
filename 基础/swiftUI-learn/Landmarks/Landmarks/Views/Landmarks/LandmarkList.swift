//
//  LandmarkList.swift
//  Landmarks
//
//  Created by hcp on 2026/7/11.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modalData
    @State private var showFavoriteOnly = false
    
    var filteredLandmarks: [Landmark] {
        modalData.landmarks.filter { landmark in
            (!showFavoriteOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoriteOnly) {
                    Text("Favoroites only")
                }
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
                
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
        } detail: {
            Text("select a landmark")
        }
    }
}

#Preview {
    LandmarkList()
}
