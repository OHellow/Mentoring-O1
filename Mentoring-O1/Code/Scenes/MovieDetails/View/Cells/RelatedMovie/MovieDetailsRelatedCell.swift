import UIKit

final class MovieDetailsRelatedCell: UICollectionViewCell, Reusable {
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

//        var shadows = UIView()
//        shadows.frame = imageView.frame
//        shadows.clipsToBounds = false
//        imageView.addSubview(shadows)
//
//        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 16)
//        let layer0 = CALayer()
//        layer0.shadowPath = shadowPath0.cgPath
//        layer0.shadowColor = UIColor(red: 0.546, green: 0.531, blue: 0.496, alpha: 0.5).cgColor
//        layer0.shadowOpacity = 1
//        layer0.shadowRadius = 10
//        layer0.shadowOffset = CGSize(width: 2, height: 4)
//        layer0.bounds = shadows.bounds
//        layer0.position = shadows.center
//        shadows.layer.addSublayer(layer0)
//
//        var shapes = UIView()
//        shapes.frame = imageView.frame
//        shapes.clipsToBounds = true
//        imageView.addSubview(shapes)
//
//        let layer1 = CALayer()
//        //layer1.contents = image1
//        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.11, tx: 0, ty: -0.06))
//        layer1.bounds = shapes.bounds
//        layer1.position = shapes.center
//        shapes.layer.addSublayer(layer1)
//        shapes.layer.cornerRadius = 16
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.749, green: 0.772, blue: 0.788, alpha: 1)
        label.backgroundColor = .red
        return label
    }()

    var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.749, green: 0.773, blue: 0.788, alpha: 0.6)
        label.backgroundColor = .green
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
            releaseDateLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func configureCell() {
        guard let viewModel = viewModel else { return }
        if let posterPath = viewModel.posterPath {
            posterImageView.setImage(movieDBPathURL: posterPath)
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
    }
}

extension MovieDetailsRelatedCell {
    struct Constants {
        static let posterImageViewHeightMultiplier: CGFloat = 0.76
        static let titleLabelTopAnchor: CGFloat = 4
    }
}
