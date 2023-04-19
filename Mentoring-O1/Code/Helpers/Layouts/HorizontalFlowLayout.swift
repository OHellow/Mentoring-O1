import UIKit

final class HorizontalFlowLayout: UICollectionViewFlowLayout {
    private let cellHeight: CGFloat
    private let cellSpacing: CGFloat
    private let preferredWidth: CGFloat

    init(cellHeight: CGFloat, cellSpacing: CGFloat = 16, preferredWidth: CGFloat) {
        self.cellHeight = cellHeight
        self.cellSpacing = cellSpacing
        self.preferredWidth = preferredWidth
        super.init()

        minimumInteritemSpacing = cellSpacing
        sectionInsetReference = .fromSafeArea
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func prepare() {
        super.prepare()

        if let collectionView = collectionView {
            let collectionViewWidth = collectionView.bounds.width
            let totalHorizontalSpacing = sectionInset.left + sectionInset.right + minimumInteritemSpacing *
            CGFloat(collectionView.numberOfItems(inSection: 0) - 1)
            let availableWidth = collectionViewWidth - totalHorizontalSpacing
            let cellWidth = min(preferredWidth, availableWidth)
            itemSize = CGSize(width: preferredWidth, height: cellHeight)
        }
    }
}
