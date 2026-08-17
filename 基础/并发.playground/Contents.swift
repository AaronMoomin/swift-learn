import Foundation

// 定义和调用异步函数 async -》 await
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}
// 由于 Playground 默认是在一个同步的、顶层（Top-level）上下文中按顺序执行代码的 所以使用Task包裹
Task {
    do {
        let photos = try await listPhotos(inGallery: "A Rainy Weekend")
        print(photos)
    } catch {
        print(error)
    }
}

// 异步序列
//let handle = FileHandle.standardInput
//for try await line in handle.bytes.lines {
//    print(line)
//}

// 并行调用异步函数
/**
 let firstPhoto = await downloadPhoto(named: photoNames[0])
 let secondPhoto = await downloadPhoto(named: photoNames[1])
 let thirdPhoto = await downloadPhoto(named: photoNames[2])

 let photos = [firstPhoto, secondPhoto, thirdPhoto]
 show(photos)
 
 以上写法有个显著缺点 尽管下载是异步的,并且其他任务也可以在下载过程中继续执行,但是只有上一张照片下载后才会开始下一张照片的下载
 
 优化 async-let
 async let firstPhoto = downloadPhoto(named: photoNames[0])
 async let secondPhoto = downloadPhoto(named: photoNames[1])
 async let thirdPhoto = downloadPhoto(named: photoNames[2])

 let photos = await [firstPhoto, secondPhoto, thirdPhoto]
 show(photos)
 */

/**
 任务和任务组
 1.杜绝了父任务中忘记等待子任务完成的可能性
 2.当子任务被赋予更高的优先级时,父任务的优先级也会随之自动提高
 3.当父任务被取消时,其所有的子任务都会被自动取消
 4.一项任务的本地值会自动而高效地扩散到子任务中
 
 await withTaskGroup(of: Data.self) { group in
     let photoNames = await listPhotos(inGallery: "Summer Vacation")
     for name in photoNames {
         group.addTask {
             return await downloadPhoto(named: name)
         }
     }
     
     for await photo in group {
         show(photo)
     }
 }
 
 若需返回值
 let photos = await withTaskGroup(of: Data.self) { group in
     let photoNames = await listPhotos(inGallery: "Summer Vacation")
     for name in photoNames {
         group.addTask {
             return await downloadPhoto(named: name)
         }
     }

     var results: [Data] = []
     for await photo in group {
         results.append(photo)
     }

     return results
 }
 */

/**
 任务取消 !Task
 1.抛出类似CancellationError的错误
 2.返回nil或是一个空的合集
 3.返回部分完成的任务
 
 let photos = await withTaskGroup(of: Optional<Data>.self) { group in
     let photoNames = await listPhotos(inGallery: "Summer Vacation")
     for name in photoNames {
         let added = group.addTaskUnlessCancelled {
             guard !Task.isCancelled else { return nil }
             return await downloadPhoto(named: name)
         }
         guard added else { break }
     }


     var results: [Data] = []
     for await photo in group {
         if let photo { results.append(photo) }
     }
     return results
 }
 */

/**
 隔离
 1.不可变数据始终是隔离的
 2.仅由当前任务引用的数据始终是隔离的.局部变量可以安全地读写,因为任务外的代码没有对该内存的引用,所以其他代码无法修改该数据,
 3.由 actor 保护的数据是隔离的,前提是访问该数据的代码也隔离到该 actor
 
 let photo = await downloadPhoto(named: "Trees at Sunrise")
 Task { @MainActor in
     show(photo)
 }
 */

// 自定义actor

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
Task {
    let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
    print(await logger.max)
}


func downloadImage(id: Int) async -> String {
    try? await Task.sleep(for: .seconds(1))
    return "image\(id)"
}
let ids = [1,2,3,4,5]

Task{
    let results = await withTaskGroup(of: String.self, returning: [String].self) {
        group in
        
        for id in ids {
            group.addTask {
                await downloadImage(id: id)
            }
        }
        
        var images: [String] = []
        
        for await image in group {
            images.append(image)
        }
        
        return images
    }
    
    print(results)
}
// 按顺序输出
Task {
    let resultWithSort = await withTaskGroup(of: (Int, String).self) { group in
        
        for id in ids {
            group.addTask { (id, await downloadImage(id: id)) }
        }
        
        var dict: [Int: String] = [:]
        
        for await (id, image) in group {
            dict[id] = image
        }
        
        return ids.compactMap { dict[$0] }
    }
    print(resultWithSort)
}

// 如果抛出异常
func fetch(id: Int) async throws -> String { return "" }
Task {
    let resultWithError = try await withThrowingTaskGroup(of: String.self) {
        group in
        
        for id in ids {
            group.addTask { try await fetch(id: id)}
        }
        
        var results: [String] = []
        
        for try await result in group {
            results.append(result)
        }
        return results
    }
}
