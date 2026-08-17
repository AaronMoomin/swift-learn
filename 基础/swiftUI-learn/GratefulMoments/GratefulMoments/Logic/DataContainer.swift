import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    var badgeManager: BadgeManager

    var context: ModelContext {
        modelContainer.mainContext
    }

    init(includeSampleMoments: Bool = false) {
        // 定义“数据库里有哪些数据模型”
        let schema = Schema([
            Moment.self,
            Badge.self
        ])
        
        // isStoredInMemoryOnly: true 表示仅保存在内存，App 或 Preview 重启后数据会消失
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        
        do {
            // SwiftData 的“数据库总管”，持有 schema 和存储配置，并负责建立、打开数据库
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            badgeManager = BadgeManager(modelContainer: modelContainer)
            
            try badgeManager.loadBadgesIfNeeded()
            
            if includeSampleMoments {
                try loadSampleMonents()
            }
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func loadSampleMonents() throws {
        for moment in Moment.sampleData {
            context.insert(moment)
            try badgeManager.unlockBadges(newMoment: moment)
        }
    }
}

@MainActor
private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
        // 通过 .modelContainer(...) 把它注入视图树 之后可用 @Query、@Environment(\.modelContext)操作
            .modelContainer(sampleContainer.modelContainer)
    }
}
