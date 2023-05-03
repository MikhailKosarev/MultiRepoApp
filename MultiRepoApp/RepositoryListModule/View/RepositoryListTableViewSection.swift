import UIKit

/// Represents the sections in the `RepositoryListViewController` table view.
enum RepositoryListTableViewSection: Int {

    // MARK: - Internal interface
    /// The number of sections in the table view.
    static let numberOfSections = 2

    /// The search section.
    case searchSection = 0
    /// The repository list section.
    case repositoryListSection = 1

    /// Initializes a section with the given section index.
    /// - Parameter sectionIndex: The index of the section to be initialized.
    init?(sectionIndex: Int) {
        guard let section = RepositoryListTableViewSection(rawValue: sectionIndex) else {
            return nil
        }
        self = section
    }

    /// The height of the cells in the section.
    var cellHeight: CGFloat {
        switch self {
        case .searchSection:
            return CGFloat(100)
        case .repositoryListSection:
            return CGFloat(40)
        }
    }
}
