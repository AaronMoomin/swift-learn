
// 简单的异步函数
// 异步任务通过 async 和 await 关键字来实现。async 用于标记一个函数是异步的，而 await 用于等待异步函数的执行结果。
func fetchData() async -> String {
    await Task.sleep(2_000_000_000) // 等到2s
    return "数据加载完成"
}
func processData() async {
    let data = await fetchData()
    print(data)
}
Task {
    await processData()
}

// 结构并发
func fetchMultipleData() async {
    let urls = [
        "https://example.com/data1",
        "https://example.com/data2",
        "https://example.com/data3"
    ]
    
    await withTaskGroup(of: String.self) { group in
        for url in urls {
            group.addTask() {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                return "数据来自\(url.uppercased())"
            }
        }
        
        for await result in group {
            print(result)
        }
    }
}
Task {
    await fetchMultipleData()
}

// 实际场景
struct Data {
    var count: Int = 0
}
func downloadImage(from url: String) async -> Data {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    return Data()
}
func downloadImages() async {
    let imageURLs = [
        "https://example.com/image1",
        "https://example.com/image2",
        "https://example.com/image3"
    ]
    
    await withTaskGroup(of: Data.self) { group in
        for url in imageURLs {
            group.addTask {
                await downloadImage(from: url)
            }
        }
        for await imageData in group {
            print("图片下载完成，大小为 \(imageData.count) 字节")
        }
    }
}
Task {
   await downloadImages()
}
