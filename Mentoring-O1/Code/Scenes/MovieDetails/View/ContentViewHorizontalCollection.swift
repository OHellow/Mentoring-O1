import UIKit

protocol ContentViewHorizontalCollectionDelegate {
    func didSelectItemAt(index: Int, cellClass: Reusable.Type?)
    func didTapSeeAllLabel()
}

final class ContentViewHorizontalCollection: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.seeAllLabelFontSize, weight: .regular)
        label.textColor = .gray
        label.text = "See all"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private var dataSource: UICollectionViewDataSource?
    private var collectionViewFlowLayout: HorizontalFlowLayout?
    private var cellClass: Reusable.Type?
    private var isSeeAllLabelHidden = false
    var delegate: ContentViewHorizontalCollectionDelegate?

    init(title: String,
         isSeeAllLabelHidden: Bool,
         collectionFlowLayout: HorizontalFlowLayout,
         cellClass: Reusable.Type) {
        super.init(frame: .zero)
        self.collectionViewFlowLayout = collectionFlowLayout
        self.isSeeAllLabelHidden = isSeeAllLabelHidden
        self.cellClass = cellClass
        titleLabel.text = title
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(seeAllLabel)
        addSubview(collectionView)
        setupCollectionView()
        setupSeeAllLabel()
        setupConstraints()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewFlowLayout ?? UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellClass?.reuseIdentifier ?? "")
    }

    private func setupSeeAllLabel() {
        if isSeeAllLabelHidden {
            seeAllLabel.isHidden = true
            return
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Constants.titleLabelLeadingAnchor),
            seeAllLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            seeAllLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: Constants.seeAllLabelTrailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Constants.collectionViewTopAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.collectionViewLeadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configureCollectionView(with dataSource: UICollectionViewDataSource) {
        self.dataSource = dataSource
        DispatchQueue.main.async {
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
}

extension ContentViewHorizontalCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(index: indexPath.row, cellClass: self.cellClass)
    }
}

extension ContentViewHorizontalCollection {
    struct Constants {
        static let titleLabelFontSize: CGFloat = 20
        static let seeAllLabelFontSize: CGFloat = 14
        static let titleLabelLeadingAnchor: CGFloat = 24
        static let seeAllLabelTrailingAnchor: CGFloat = -25
        static let collectionViewTopAnchor: CGFloat = 12
        static let collectionViewLeadingAnchor: CGFloat = 24
    }
}
