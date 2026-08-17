import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T
    let message: String
    let success: Bool
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPError: Error {
    case badStatus(Int)
}

enum LoadState<Value> {
    case idle
    case loading
    case success(Value)
    case failure(Error)
}

enum APIError: LocalizedError {
    case httpStatus(Int)
    case business(code: Int, message: String)
    
    var errorDescription: String? {
        switch self {
        case .httpStatus(let code):
            return "HTTP 请求失败: \(code)"
        case .business(_, let message):
            return message
        }
    }
}

let TOKEN = "Bearer qUy43wryban68DVMqrquURN1lzdPBQnu6oNKgqO9gNU"

func httpRequest<T: Decodable>(_ url: String, method: HTTPMethod = .get, body: Data? = nil) async throws -> T {
    let url = URL(string: url)!
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    request.setValue(TOKEN, forHTTPHeaderField: "authorization")
    if body != nil {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let http = response as? HTTPURLResponse,
          200..<300 ~= http.statusCode else {
        throw HTTPError.badStatus((response as? HTTPURLResponse)?.statusCode ?? -1)
    }
    
    let result = try JSONDecoder().decode(APIResponse<T>.self, from: data)
    
    guard result.success, result.code == 0 else {
        throw APIError.business(code: result.code, message: result.message)
    }
    return result.data
}
