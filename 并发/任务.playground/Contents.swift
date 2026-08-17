import Foundation
/**
 什么是任务
 1. 异步执行: 任务可以在后台线程中执行, 不会阻塞主进程
 2. 并发性: 多个任务可以同时进行, 充分利用多核处理器的能力
 3. 结构化并发: 任务可以嵌套, 形成任务树, 便于管理
 */

// 任务返回值
let task = Task<String, Error> {
    print("任务开始执行")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return "任务执行完成"
}
task.cancel()
//do {
//    let result = try await task.value
//    print(result)
//} catch {
//    print(error)
//}

// 并发下载图片
func downloadImage(from url: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
func downloadImages() async {
    let urls = [
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1780109556378.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791398698.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791375599.png")!
    ]
    
    let tasks = urls.map { url in
        Task {
            try await downloadImage(from: url)
        }
    }
    
    for task in tasks {
        do {
            let imageData = try await task.value
            print("下载完成: \(imageData.count) 字节")
        } catch {
            print("下载失败: \(error)")
        }
    }
}
Task {
    await downloadImages()
}
