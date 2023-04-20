import UIKit

final class MovieDetailsRelatedCell: UICollectionViewCell, Reusable {
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        //imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.posterImageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.titleLabelFontSize)
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.749, green: 0.772, blue: 0.788, alpha: 1)
        //label.backgroundColor = .red
        return label
    }()

    var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.releaseDateLabelFontSize)
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.749, green: 0.773, blue: 0.788, alpha: 0.6)
        //label.backgroundColor = .green
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel: MovieDetailRelatedViewModel? {
        didSet {
            configureCell()
        }
    }

    private func setupView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor,
                                                    multiplier: Constants.posterImageViewHeightMultiplier),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,
                                            constant: Constants.titleLabelTopAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.releaseDateLabelTopAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureCell() {
        guard let viewModel = viewModel else { return }
        if let posterPath = viewModel.posterPath {
            posterImageView.setImage(movieDBPathURL: posterPath, completion: nil)
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
    }
}

extension MovieDetailsRelatedCell {
    struct Constants {
        static let posterImageViewHeightMultiplier: CGFloat = 0.76
        static let posterImageCornerRadius: CGFloat = 5
        static let titleLabelTopAnchor: CGFloat = 4
        static let titleLabelFontSize: CGFloat = 16
        static let releaseDateLabelTopAnchor: CGFloat = 4
        static let releaseDateLabelFontSize: CGFloat = 12
    }
}
