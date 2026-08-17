import Foundation
/**
 AsyncSequence 协议
 AsyncSequence 是一个协议，定义了如何以异步方式遍历序列。它要求实现一个 makeAsyncIterator() 方法，返回一个符合 AsyncIteratorProtocol 的迭代器。
 */
//protocol AsyncSequence {
//    associatedtype Element
//    associatedtype AsyncIterator: AsyncIteratorProtocol where AsyncIterator.Element == Element
//    func makeAsyncIterator() -> AsyncIterator
//}

/**
 AsyncIteratorProtocol 协议
 AsyncIteratorProtocol 定义了如何异步地获取序列中的下一个元素。它要求实现一个 next() 方法，返回一个 Element? 类型的值，或者抛出错误。
 */
//protocol AsyncIteratorProtocol {
//    associatedtype Element
//    mutating func next() async throws -> Element?
//}


struct NetworkDataFetcher: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Data
    
    var urlSession: URLSession
    var urls: [URL]
    var currentIndex = 0
    
    mutating func next() async throws -> Data? {
        guard currentIndex < urls.count else {return nil}
        let url = urls[currentIndex]
        currentIndex += 1
        let (data, _) = try await urlSession.data(from: url)
        return data
    }
    
    func makeAsyncIterator() -> Self {
        return self
    }
    
}

let urls = [
    URL(string: "https://static.ieltsbro.com/base_service/base/image/1780109556378.png")!,
    URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791398698.png")!,
    URL(string: "https://static.ieltsbro.com/base_service/base/image/1779791375599.png")!
]
Task {
    let fetcher = NetworkDataFetcher(urlSession: URLSession.shared, urls: urls)
    for try await data in fetcher {
        print(data)
    }
}

// 处理文件读取
struct FileLineReader: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = String
    
    var fileHandle: FileHandle
    var buffer: Data
    
    mutating func next() async throws -> String? {
        while true {
            if let line = buffer.withUnsafeBytes({ $0.split(separator: UInt8(ascii: "\n")).first }) {
                buffer.removeSubrange(0..<line.count + 1)
                return String(data: Data(line), encoding: .utf8)
            }
            let newData = try fileHandle.read(upToCount: 1024)
            guard let newData = newData, !newData.isEmpty else {return nil}
            buffer.append(newData)
        }
    }
    
    func makeAsyncIterator() -> Self {
        return self
    }
}
let fileURL = URL(fileURLWithPath: "/Users/hcp/WebstormProjects/swift-learn/并发/file.txt")
let fileHandle = try FileHandle(forReadingFrom: fileURL)
let reader = FileLineReader(fileHandle: fileHandle, buffer: Data())

for try await line in reader {
    print("读取到行: \(line)")
}
