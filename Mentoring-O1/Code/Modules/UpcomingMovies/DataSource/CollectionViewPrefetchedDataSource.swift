import UIKit

final class CollectionViewPrefetchedDataSource: NSObject, UICollectionViewDataSourcePrefetching {
    let cellCount: Int
    let prefetchHandler: (() -> Void)

    init(cellCount: Int, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.prefetchHandler = prefetchHandler
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetchRowsAt \(indexPaths.map { $0.item })")
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellCount - 1
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths.map { $0.item })")
    }
}
