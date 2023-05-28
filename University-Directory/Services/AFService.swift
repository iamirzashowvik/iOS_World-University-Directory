import Foundation


class API {
    func request<T>(url: String, method: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> T where T: Decodable {
        var request = URLRequest(url: URL( string:url)!)
        if (method == "POST" || method == "GET"){
        request.httpMethod = method
        request.httpBody = body
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw   CustomError.unexpected(code: 102)  }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
            
        }else{
            throw   CustomError.unexpected(code: 405)
        }
        
    }
    
}




enum CustomError: Error {
    // Throw when an invalid password is entered
    case invalidPassword

    // Throw when an expected resource is not found
    case notFound

    // Throw in all other cases
    case unexpected(code: Int)
}
