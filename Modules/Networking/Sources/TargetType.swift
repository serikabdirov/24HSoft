import Alamofire
import Foundation

public protocol TargetType: URLRequestConvertible {
    var baseURL: URL { get }

    var path: String { get }

    var method: HTTPMethod { get }

    var parameters: RequestParameters { get }

    var headers: HTTPHeaders? { get }
    
    var multipartFormData: (MultipartFormData) -> Void { get }
}

public extension TargetType {
    var headers: HTTPHeaders? { nil }
    
    var multipartFormData: (MultipartFormData) -> Void {
        return { _ in }
    }
}

public extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method, headers: headers)
        request = try parameters.fill(request: request)
        return request
    }
}
