/// A protocol for a presenter for RepisotoryList module.
protocol RepositoryListPresenterProtocol: AnyObject {
    /// The view that the presenter is managing.
    var view: RepositoryListViewProtocol? { get set }
    /// The list of repositories managed by the presenter.
    var repositories: [RepositoryTableViewCellData] { get set }
    /// The filtered list of repositories.
    var filteredRepositories: [RepositoryTableViewCellData] { get set }

    /// Initializes a new instance of the presenter.
    /// - Parameter view: The view that the presenter is managing.
    init(view: RepositoryListViewProtocol)

    /// Returns the number of repositories in the list.
    /// - Returns: The number of repositories in the list.
    func getNumberOfRepositories() -> Int

    /// Returns the repository view data for a given index in the list.
    /// - Parameter index: index: The index of the repository in the list.
    /// - Returns: The repository view data for the given index.
    func getViewDataFor(_ index: Int) -> RepositoryTableViewCellData

    /// Fetches the list of repositories from the network and updates the managed list of repositories.
    func getRepositories()

    /// Filters the list of repositories based on a search text.
    /// - Parameter searchText: The search text to filter the repositories by.
    func filterRepositoriesStarting(with searchText: String)
}
