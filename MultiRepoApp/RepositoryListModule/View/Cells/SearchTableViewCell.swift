import UIKit

/// A custom table view cell used to display a search bar for repositories.
final class SearchTableViewCell: UITableViewCell {

    // MARK: - Internal interface
    /// The reuse identifier for the table view cell.
    static let reuseID = "SearchTableViewCell"

    /// The delegate object that will be notified when the search text changes.
    weak var delegate: RepositorySearchDelegateProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI elements
    lazy var repositorySearchField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.textColor = .white
        searchTextField.tintColor = .white
        searchTextField.leftView?.tintColor = .gray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                   attributes: attributes)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        return searchTextField
    }()

    // MARK: - Private interface
    private func setupView() {
        backgroundColor = .black
        contentView.addSubview(repositorySearchField)
    }

    private func setConstraints() {
        contentView.preservesSuperviewLayoutMargins = false
        let margins = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            repositorySearchField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            repositorySearchField.topAnchor.constraint(equalTo: margins.topAnchor),
            repositorySearchField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            repositorySearchField.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }

    @objc private func searchTextChanged(_ sender: UISearchTextField) {
        guard let text = sender.text else { return }
        delegate?.searchTextChanged(searchText: text)
    }
}
