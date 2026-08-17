//
//  DemoView.swift
//  WhyNotTry
//
//  Created by hcp on 2026/7/27.
//

import SwiftUI

struct Source: Identifiable, Decodable {
    let id: String
    let parentId: String?
    let sourceName: String
    let children: [Source]?
}

struct DemoView: View {
    @State private var state: LoadState<[Source]> = .idle
    @State private var sourcePick: String = ""

    var body: some View {
        Group {
            switch state {
            case .idle, .loading:
                ProgressView("加载中...")
            case .success(let data):
                Picker("资源", selection: $sourcePick) {
                    ForEach(data) { source in
                        Text(source.sourceName)
                            .tag(source.id)
                    }
                }
                .pickerStyle(.inline)
                .padding()
            
            case .failure(let error):
                ContentUnavailableView(
                    "加载失败",
                    systemImage: "wifi.exclamationmark",
                    description: Text(error.localizedDescription)
                )
            }
        }
        .task {
            do {
                let result: [Source] = try await fetchSources()
                dump(result)
                sourcePick = result[0].id
                state = .success(result)
            } catch {
                state = .failure(error)
            }
        }
    }

    @MainActor
    private func fetchSources() async throws -> [Source] {
        state = .loading
        let result: [Source] = try await httpRequest(
            "https://dev-ysg-bff.ieltsbro.com/api/admin/cdp/promotion/sources/options"
        )
        return result
    }
}

#Preview {
    DemoView()
}
