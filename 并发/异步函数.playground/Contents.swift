import Foundation

func fetchData() async -> String {
    // 模拟一个耗时的操作
    await Task.sleep(2 * 1_000_000_000) // 等待2秒
    return "Data fetched"
}
func processData() async {
    let data = await fetchData()
    print(data)
}

// 异步函数的实际使用
func fetchUserData(from url: URL) async throws -> Data{
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
func displayUserData() async {
    let url = URL(string: "https://api.example.com/user")!
    do {
        let data = try await fetchUserData(from: url)
        print(data)
    } catch {
       print("failed to fetch data: \(error)")
    }
}

//同时开启多个异步任务
func fetchMultipleData() async {
    async let data1 = fetchData()
    async let data2 = fetchData()
    async let data3 = fetchData()
    
    let results = await [data1,data2,data3]
    print(results)
}
