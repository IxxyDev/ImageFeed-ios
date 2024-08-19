import Foundation

extension URLRequest {
  static func makeHTTPRequest(
    path: String,
    httpMethod: String?,
    baseURL: URL? = Constants.defaultBaseURL
  ) -> URLRequest {
    guard let url = URL(string: path, relativeTo: baseURL) else { preconditionFailure("Unable to create url") }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    return request
  }
}
