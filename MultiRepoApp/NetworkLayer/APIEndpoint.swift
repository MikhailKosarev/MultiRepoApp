import Foundation

/// Available API endpoints.
enum APIEndpoint {
    /// The endpoint for the GitHub API.
    case github
    /// The endpoint for the Bitbucket API.
    case bitbucket

    /// Returns a string containing the base URL for the selected API endpoint.
    var baseURL: String {
        switch self {
        case .github:
            return "https://api.github.com"
        case .bitbucket:
            return "https://api.bitbucket.org"
        }
    }

    /// Returns a string containing the path for the selected API endpoint.
    var path: String {
        switch self {
        case .github:
            return "/repositories"
        case .bitbucket:
            return "/2.0/repositories"
        }
    }

    /// Returns a dictionary containing the parameters for the selected API endpoint.
    var parameters: [String: String]? {
        switch self {
        case .github:
            return nil
        case .bitbucket:
            return ["fields": "values.name,values.owner,values.description"]
        }
    }
}
