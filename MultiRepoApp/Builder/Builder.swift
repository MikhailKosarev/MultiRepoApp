import UIKit

/// A protocol that defines methods for creating a particular `UIViewController` instance.
protocol Builder {
    /// Creates and returns a `UIViewController` instance of a RepositoryListModule.
    static func createRepositoryListModule() -> UIViewController
}
