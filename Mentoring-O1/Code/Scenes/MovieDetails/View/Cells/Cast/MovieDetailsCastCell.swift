import UIKit

final class MovieDetailsCastCell: UICollectionViewCell, Reusable {
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.posterImageCornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.nameLabelFontSize)
        label.numberOfLines = Constants.nameLabelNumberOfLines
        label.textColor = UIColor(red: 0.376, green: 0.376, blue: 0.376, alpha: 1)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel: MovieDetailCastViewModel? {
        didSet {
            configureCell()
        }
    }

    private func setupView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: Constants.posterImageWidht),
            posterImageView.heightAnchor.constraint(equalToConstant: Constants.posterImageHeight),
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: Constants.nameLabelTopAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureCell() {
        guard let viewModel = viewModel else { return }
        if let profilePath = viewModel.profilePath {
            posterImageView.setImage(movieDBPathURL: profilePath, completion: nil)
            nameLabel.text = viewModel.name
        }
    }
}

extension MovieDetailsCastCell {
    struct Constants {
        static let posterImageWidht: CGFloat = 44
        static let posterImageHeight: CGFloat = 44
        static let posterImageCornerRadius: CGFloat = 10
        static let nameLabelFontSize: CGFloat = 12
        static let nameLabelNumberOfLines: Int = 2
        static let nameLabelTopAnchor: CGFloat = 4
    }
}
