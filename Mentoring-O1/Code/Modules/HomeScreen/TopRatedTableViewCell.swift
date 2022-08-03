import UIKit
import SDWebImage

class TopRatedTableViewCell: UITableViewCell {

    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupView()
       }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    private func setupView() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            posterImage.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configureCell(with movie: Movie) {
        posterImage.setImage(movieDBPathURL: movie.posterPath)
        titleLabel.text = movie.title
    }
}
