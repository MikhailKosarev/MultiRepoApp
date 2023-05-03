import UIKit

/// A protocol to be implemented by any view controller that displays a list of repositories.
protocol RepositoryListViewProtocol: UIViewController {
    /// Notifies the view controller that the repository list section needs to be reloaded.
    func reloadRepositoryListSection()
}
