import UIKit

final class DefaultRefreshControl: UIRefreshControl {

    private var refreshHandler: () -> Void

    init(backgroundColor: UIColor? = .clear,
         refreshHandler: @escaping () -> Void) {
        self.refreshHandler = refreshHandler
        super.init()
        self.backgroundColor = backgroundColor
        addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    @objc
    func refreshControlAction() {
        refreshHandler()
    }
}
