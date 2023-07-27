import UIKit

final class DefaultCollectionViewDataSource<CELL: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator = (T, CELL) -> Void

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    private let models: [T]

    init(cellViewModels: [T], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        self.models = cellViewModels
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CELL {
            cellConfigurator(model, cell)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func getItem(at indexPath: Int) -> T {
        return models[indexPath]
    }
}
