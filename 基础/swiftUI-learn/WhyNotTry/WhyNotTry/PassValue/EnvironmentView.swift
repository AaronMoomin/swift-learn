
import SwiftUI

@Observable
final class EnvironmentStore {
    var theme = "dark"
}

struct EnvironmentView: View {
    @State private var env = EnvironmentStore()
    
    var body: some View {
        Parent()
            .environment(env)
    }
}

struct Parent: View {
    var body: some View {
        Child()
    }
}

struct Child: View {
    var body: some View {
        GrandChild()
    }
}

// @Environment 跨多层视图传共享数据
struct GrandChild: View {
    @Environment(EnvironmentStore.self) private var env
    
    var body: some View {
        Text("current theme is \(env.theme)")
        Button("change to light") {
            env.theme = "light"
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    EnvironmentView()
}
