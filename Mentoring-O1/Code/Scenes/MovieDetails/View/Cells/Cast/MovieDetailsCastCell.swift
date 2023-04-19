import UIKit

final class MovieDetailsCastCell: UICollectionViewCell, Reusable {
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let layer = CALayer()
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.25, b: 0, c: 0, d: 1.87, tx: -0.06, ty: -0.29))
        layer.bounds = imageView.bounds
        layer.position = imageView.center
        imageView.layer.addSublayer(layer)
        imageView.layer.cornerRadius = 16
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return imageView
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
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
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureCell() {
        guard let viewModel = viewModel else { return }
        if let profilePath = viewModel.profilePath {
            posterImageView.setImage(movieDBPathURL: profilePath)
        }
        nameLabel.text = viewModel.name
    }
}

extension MovieDetailsCastCell {
    struct Constants {
        static let titleLabelFontSize: CGFloat = 20
        static let seeAllLabelFontSize: CGFloat = 14
        static let titleLabelLeadingAnchor: CGFloat = 24
        static let seeAllLabelTrailingAnchor: CGFloat = -25
        static let collectionViewTopAnchor: CGFloat = 12
        static let collectionViewLeadingAnchor: CGFloat = 24
    }
}
