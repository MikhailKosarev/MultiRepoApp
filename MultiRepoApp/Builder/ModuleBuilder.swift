import UIKit

/// An implementation of the Builder protocol, responsible for creating the modules.
final class ModuleBulder: Builder {
    /// Creates and returns the repository list module as a UIViewController.
    static func createRepositoryListModule() -> UIViewController {
        let view = RepositoryListViewController()
        let presenter = RepositoryListPresenter(view: view)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
