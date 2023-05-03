import UIKit

/// A custom table view cell used to display information about a repository.
final class RepositoryTableViewCell: UITableViewCell {

    // MARK: - Internal interface
    /// The reuse identifier for the table view cell.
    static let reuseID = "RepositoryTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configures the cell with the given view data.
    /// - Parameter viewData: The data to configure the cell with.
    func configureWith(_ viewData: RepositoryTableViewCellData) {
        titleLabel.text = viewData.title
        descriptionLabel.text = viewData.description
        sourceImageView.image = UIImage(named: viewData.source)
        imageURL = URL(string: viewData.userIcon)
    }

    // MARK: - UI elements
    private let userIconImageView: UIImageView = {
        let image = UIImage(named: "GitHubAvatar")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sourceImageView: UIImageView = {
        let image = UIImage(named: "GitHubIcon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       descriptionLabel,
                                                      ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var repositoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userIconImageView,
                                                       textStackView,
                                                       sourceImageView,
                                                      ])
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Private interface
    private var imageURL: URL? {
        didSet {
            updateImage()
        }
    }

    private func setupView() {
        backgroundColor = .black
        selectionStyle = .none
        contentView.addSubview(repositoryStackView)
    }

    private func setConstraints() {
        contentView.preservesSuperviewLayoutMargins = false
        let margins = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            userIconImageView.heightAnchor.constraint(equalToConstant: 42),
            userIconImageView.widthAnchor.constraint(equalToConstant: 42),

            sourceImageView.heightAnchor.constraint(equalToConstant: 42),
            sourceImageView.widthAnchor.constraint(equalToConstant: 42),

            repositoryStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            repositoryStackView.topAnchor.constraint(equalTo: margins.topAnchor),
            repositoryStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            repositoryStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }

    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                if imageURL == self.imageURL {
                    DispatchQueue.main.async {
                        self.userIconImageView.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
