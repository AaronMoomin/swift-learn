import SwiftUI
import SwiftData

struct MomentsView: View {
    @State private var showCreateMoment = false
    @Query(sort: \Moment.timestamp)
    private var moments: [Moment]
    
    static let offsetAmount: CGFloat = 70.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 8, pinnedViews: .sectionHeaders) {
                    Section {
                        pathItems
                            .frame(maxWidth: .infinity)
                    } header: {
                        streakHeader
                    }
                    
                }
                
            }
            .overlay {
                // 在列表为空时，可以使用 ContentUnavailableView 来提供指导信息， overlay 则表示该指导信息所在的位置
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreateMoment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showCreateMoment) {
                        MomentEntryView()
                    }
                }
            }
            // 使用 .defaultScrollAnchor 来配置滚动视图，使得最新的时刻能够显示出来 初次显示时，内容从底部开始
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            // 内容或容器尺寸变化后，保持底部锚定
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            // 内容不足以滚动时，整体靠顶部对齐
            .defaultScrollAnchor(.top, for: .alignment)
            .navigationTitle("Grateful Moments")
        }
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
    
    private var pathItems: some View {
        // 在 moments 数组上使用 .enumerated() 函数可以获取每个元素的索引。 sin 函数则利用这些索引来生成振荡效果，从而形成锯齿状的图案。
        ForEach(Array(moments.enumerated()), id:\.0) { index, moment in
            NavigationLink {
                MomentDetailView(moment: moment)
            } label: {
                if moment == moments.last {
                    MomentHexagonView(moment: moment, layout: .large)
                } else {
                    MomentHexagonView(moment: moment)
                        .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)
                }
            }
            // phase 表示视图在过渡过程中的状态，比如通过滚动来显示或隐藏某个内容。而 identity 则指的是内容正常显示的状态，即不在过渡过程中。
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
            }
        }
    }
    @ViewBuilder private var streakHeader: some View {
        let streak = StreakCalculator().calculateStreak(for: moments)
        if streak > 0 {
            HStack {
                Text(verbatim: "\(streak)")
                Text(Image(systemName: "flame.fill"))
                    .foregroundStyle(.ember)
                Spacer()
            }
            .font(.subheadline)
            .padding()
        }
    }
}


#Preview {
    MomentsView()
        .sampleDataContainer()
}

#Preview("no Moments") {
    MomentsView()
        .modelContainer(for: [Moment.self])
        .environment(DataContainer())
}
