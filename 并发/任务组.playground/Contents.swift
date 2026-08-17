/***
 任务组的主要特点包括：

 并发执行：任务组中的任务可以并发执行，充分利用多核处理器的性能。
 结果收集：任务组可以收集所有任务的结果，并在所有任务完成后统一处理。
 错误处理：任务组可以处理任务中的错误，并在必要时取消所有任务。
 */
import Foundation

func fetchData(from url: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
func fetchMultipleData() async throws -> [Data] {
    let urls = [
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1780109556378.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791398698.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791375599.png")!
    ]
    
    // 任务组的生命周期由 withTaskGroup 函数控制。当 withTaskGroup 函数返回时，任务组中的所有任务都会自动取消。这意味着你不需要手动管理任务的取消，Swift会自动处理
    // 任务组中的任务可能会抛出错误。如果任务组中的任何一个任务抛出错误，整个任务组都会被取消，并且错误会传播到 withTaskGroup 函数的调用者
    return try await withThrowingTaskGroup(of: Data.self) { group in
        for url in urls {
            group.addTask {
                try await fetchData(from: url)
            }
        }
        var results = [Data]()
        for try await data in group {
            results.append(data)
        }
        return results
    }
}
Task {
    let result = try await fetchMultipleData()
    print(result)
}
