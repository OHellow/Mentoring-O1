import UIKit

final class DefaultLoaderView: UIView, LoadingViewProtocol {
    static let defaultFrame: CGRect = CGRect(x: .zero, y: .zero, width: 50, height: 50)
    var isPresented: Bool = false

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        return activityIndicatorView
    }()

    init() {
        super.init(frame: DefaultLoaderView.defaultFrame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Private
    private func setupUI() {
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }

    // MARK: - Internal
    func startLoading() {
        activityIndicatorView.startAnimating()
    }

    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }

}
