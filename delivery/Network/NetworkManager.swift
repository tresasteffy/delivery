import Foundation

enum VendorError: LocalizedError {
    case invalidURL
    case networkError(String)
    case decodingError(String)
    case serverError(String)
    case noInternetConnection
    case timeoutError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please try again later."
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError(let message):
            return "Data format error: \(message)"
        case .serverError(let message):
            return "Server error: \(message)"
        case .noInternetConnection:
            return "No internet connection. Please check your connection."
        case .timeoutError:
            return "Request timed out. Please try again."
        }
    }
}

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class NetworkManager: NetworkService {
    
    static let shared: NetworkService = NetworkManager()
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
            guard let url = endpoint.url else {
                throw VendorError.invalidURL
            }
            
            do {
                let (data, response) = try await session.data(from: url)
                return try handleResponse(data: data, response: response)
            } catch {
                throw handleNetworkError(error)
            }
        }
        
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw VendorError.networkError("Invalid response type")
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case 400...499:
            throw VendorError.serverError("Bad request: \(httpResponse.statusCode)")
        case 500...599:
            throw VendorError.serverError("Server error: \(httpResponse.statusCode)")
        default:
            throw VendorError.networkError("Unexpected status code: \(httpResponse.statusCode)")
        }
    }

    // Handle specific network errors
    private func handleNetworkError(_ error: Error) -> VendorError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternetConnection
            case .timedOut:
                return .timeoutError
            default:
                return .networkError(error.localizedDescription)
            }
        }
        return .networkError(error.localizedDescription)
    }
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL? {
        var components = URLComponents(string: "http://eindi.thecodelab.me")
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
    
    static func vendorDetails(vendorID: Int, lang: String, userID: Int) -> Endpoint {
        return Endpoint(
            path: "/api/v3/getVendorDetails",
            queryItems: [
                URLQueryItem(name: "vendor_id", value: "\(vendorID)"),
                URLQueryItem(name: "lang", value: lang),
                URLQueryItem(name: "user_id", value: "\(userID)")
            ]
        )
    }
}


