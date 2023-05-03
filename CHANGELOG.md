# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- ### Added

- Network layer consisting of:
    - `NetworkManager` for handling network requests and responses.
    - `NetworkError` representing the possible error that can occur during network communication.
    - `API endpoints` representing the available API endpoints.
- Common models `BitBucketRepositories` and `GitHubRepository` to parse data from the API in them.
- `RepositoryListModule` folder with MVP structure and general empty files inside.
- `RepositoryTableViewCellData` implementation.
- `RepositoryListViewProtocol` implementation.
- `RepositoryListPresenterProtocol` implementation.
- `RepositoryListPresenter` implementation.
- Icons of GitHub and BitBucket for the assets.
- `RepositoryTableViewCell` implementation.
- `SearchTableViewCell` implementation.
- `RepositorySearchDelegateProtocol` implementation.
- `RepositoryListViewController` implementation.
- `RepositoryListTableViewSection` implementation.
- `Builder` protocol implementation.
- `ModuleBuilder` implementation.

## [0.1.0] - 2023-05-02

### Added

- This CHANGELOG file to hopefully serve as an evolving example of a standardized open source project CHANGELOG.
- `.gitignore` file to lists all of the files that are local to a project that Git should not push to GitHub.
- Initial Xcode project with customized conifguration.
- SwiftLint with custom rules as the run script to the build phase.
- Add `README.md` with the description of the app.
