import SwiftUI

struct StateView: View {
//    当前视图自己拥有的数据
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("count: \(count)")
            
            Button("+1") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    StateView()
}
