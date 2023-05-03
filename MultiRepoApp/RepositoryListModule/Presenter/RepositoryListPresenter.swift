import Foundation
/// A presenter that manages the repositories data and updates the view accordingly.
final class RepositoryListPresenter: RepositoryListPresenterProtocol {

    // MARK: - Internal interface
    weak var view: RepositoryListViewProtocol?
    var repositories = [RepositoryTableViewCellData]()
    var filteredRepositories = [RepositoryTableViewCellData]()

    init(view: RepositoryListViewProtocol) {
        self.view = view
    }

    func getNumberOfRepositories() -> Int {
        return filteredRepositories.count
    }

    func getViewDataFor(_ index: Int) -> RepositoryTableViewCellData {
        return filteredRepositories[index]
    }

    /// Fetches the repositories data from GitHub and BitBucket endpoints, merges them,
    /// and passes the list to the view for display.
    func getRepositories() {
        repositories.removeAll()

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.getData(from: .github) { result in
                switch result {
                case .success(let data):
                    self.fillGitHubRepositories(with: data)
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.enter()
        DispatchQueue.global().async {
            self.getData(from: .bitbucket) { result in
                switch result {
                case .success(let data):
                    self.fillBitBucketRepositories(with: data)
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("All requests finished")
            print("Merges repositories: \(self.repositories.count)")

            self.filteredRepositories = self.repositories
            self.view?.reloadRepositoryListSection()
        }
    }

    func filterRepositoriesStarting(with searchText: String) {
        filteredRepositories = repositories.filter { repository in
            repository.title.hasPrefix(searchText)
        }
        self.view?.reloadRepositoryListSection()
    }

    // MARK: - Private interface
    private let repositoriesFillingQueue = DispatchQueue(label: "com.repositoriesFillingQueue", attributes: .concurrent)

    private func getData(from endpoint: APIEndpoint, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.sendRequest(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                print("\(endpoint) data received: \(data)")
                completionHandler(.success(data))
            case .failure(let error):
                print("\(endpoint) error: \(error)")
                completionHandler(.failure(error))
            }
        }
    }

    private func fillGitHubRepositories(with data: Data) {

        do {
            let gitHubRepositories = try JSONDecoder().decode(GitHubRepositories.self, from: data)
            print("GitHub repositories: \(gitHubRepositories.count)")
            gitHubRepositories.forEach { repository in
                let repositoryViewData = RepositoryTableViewCellData(userIcon: repository.owner.avatarURL,
                                                            title: repository.name,
                                                            description: repository.description ?? "",
                                                            source: "GitHubIcon")
                repositoriesFillingQueue.async(flags: .barrier) {
                    self.repositories.append(repositoryViewData)
                }
            }
        } catch {
            print(error)
        }
    }

    private func fillBitBucketRepositories(with data: Data) {
        do {
            let bitBucketRepository = try JSONDecoder().decode(BitBucketRepositories.self, from: data)
            print("BitBucket repositories: \(bitBucketRepository.values.count)")
            bitBucketRepository.values.forEach { repository in
                let repositoryViewData = RepositoryTableViewCellData(userIcon: repository.owner.links.avatar.href,
                                                            title: repository.name,
                                                            description: repository.description,
                                                            source: "BitBucketIcon")
                repositoriesFillingQueue.async(flags: .barrier) {
                    self.repositories.append(repositoryViewData)
                }
            }
        } catch {
            print(error)
        }
    }
}
