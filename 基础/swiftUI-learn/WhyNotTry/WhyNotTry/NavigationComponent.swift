import SwiftUI

enum Route: Hashable {
    case profile
    case settings
    case article(id: Int)
}

struct NavigationComponent: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List{
                NavigationLink("个人资料", value: Route.profile)
                NavigationLink("设置", value: Route.settings)
                
                Button("打开文章 42") {
                    path.append(Route.article(id: 42))
                }
            }
            .navigationTitle("首页")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile:
                    Text("个人资料")
                case .settings:
                    Text("设置页")
                case let .article(id):
                    ArticleView(id:id)
                }
            }
        }
    }
}

struct ArticleView: View {
    let id:Int
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 16) {
                Text("文章 \(id)")
            Button("返回上一页") {
                dismiss()
            }
        }
        .navigationTitle("文章")
    }
}

#Preview {
    NavigationComponent()
}
