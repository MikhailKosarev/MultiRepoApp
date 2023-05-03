import UIKit

/// A view controller that displays a list of repositories
/// and communicates with its presenter to fetch the necessary data and manage user interactions.
class RepositoryListViewController: UITableViewController {

    // MARK: - Internal properties
    /// The presenter object responsible for fetching and processing the data.
    var presenter: RepositoryListPresenterProtocol?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setConstraints()
        presenter?.getRepositories()
        showSpinner()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateNavBarColor()
    }

    // MARK: - UI elements
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: - Private interface
    private func setupView() {
        title = "Repositories"
        view.backgroundColor = .black
        view.addSubview(activityIndicator)
    }

    private func setupTableView() {
        tableView.register(SearchTableViewCell.self,
                           forCellReuseIdentifier: SearchTableViewCell.reuseID)
        tableView.register(RepositoryTableViewCell.self,
                           forCellReuseIdentifier: RepositoryTableViewCell.reuseID)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                  action: #selector(didPullToResfresh),
                                  for: .valueChanged)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    private func updateNavBarColor() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBar = navigationController?.navigationBar
        navBar?.barStyle = .black
        navBar?.isTranslucent = false
        navBar?.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }

    private func showSpinner() {
        activityIndicator.startAnimating()
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
    }

    @objc private func didPullToResfresh() {
        presenter?.getRepositories()
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return RepositoryListTableViewSection.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = RepositoryListTableViewSection(sectionIndex: section) else { return 0 }
        switch section {
        case .searchSection:
            return 1
        case .repositoryListSection:
            return presenter?.getNumberOfRepositories() ?? 0
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = RepositoryListTableViewSection(sectionIndex: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .searchSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID,
                                                           for: indexPath) as? SearchTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case .repositoryListSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseID,
                                                     for: indexPath) as? RepositoryTableViewCell,
                  let viewData = presenter?.filteredRepositories[indexPath.row] else {
                return UITableViewCell()
            }

            cell.configureWith(viewData)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
}

// MARK: - CitySearchDelegateProtocol
extension RepositoryListViewController: RepositorySearchDelegateProtocol {
    func searchTextChanged(searchText: String) {
        presenter?.filterRepositoriesStarting(with: searchText)
    }
}

// MARK: - RepositoryListViewProtocol
extension RepositoryListViewController: RepositoryListViewProtocol {
    func reloadRepositoryListSection() {
        tableView.reloadSections(IndexSet(integer: RepositoryListTableViewSection.repositoryListSection.rawValue),
                                 with: .automatic)
        hideSpinner()
    }
}
