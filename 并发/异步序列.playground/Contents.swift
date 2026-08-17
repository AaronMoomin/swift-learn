import Foundation

struct DataFetcher: AsyncSequence {
    typealias Element = Data
    let urls: [URL]
    
    struct AsyncIterator: AsyncIteratorProtocol {
        var index = 0
        let urls: [URL]
        
        mutating func next() async throws -> Data? {
            guard index < urls.count else {return nil}
            let url = urls[index]
            index += 1
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(urls: urls)
    }
}
Task {
    let urls = [
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1780109556378.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791398698.png")!,
        URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791375599.png")!
    ]
    
    var completed = 0
    
    for try await data in DataFetcher(urls: urls) {
        completed += 1
        let progress = Double(completed) / Double(urls.count)

        print("下载进度：\(completed)/\(urls.count)（\(Int(progress * 100))%），\(data.count) bytes")
    }
}

