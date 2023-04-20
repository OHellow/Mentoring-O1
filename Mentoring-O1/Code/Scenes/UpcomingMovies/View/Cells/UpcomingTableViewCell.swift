import UIKit

protocol UpcomingCollectionViewCellProtocol {
    var posterImageView: UIImageView { get }
    var viewModel: UpcomingCellViewModelProtocol? { get set }
}

final class UpcomingCollectionViewCell: UICollectionViewCell, UpcomingCollectionViewCellProtocol, Reusable {
    var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel: UpcomingCellViewModelProtocol? {
        didSet {
            configureCell()
        }
    }

    private func setupView() {
        contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureCell() {
        guard let viewModel = viewModel else { return }
        if let posterPath = viewModel.posterPath {
            posterImageView.setImage(movieDBPathURL: posterPath, completion: nil)
        } else {
            posterImageView.backgroundColor = .darkGray
        }
    }
}
