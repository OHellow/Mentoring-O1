import Foundation
import UIKit

class DetailsViewController: UIViewController {
    private let kTitleFontSize: CGFloat = 18

    lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: kTitleFontSize, weight: .semibold)
        return label
    }()

    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()

    let viewModel: DetailsViewModelProtocol?

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindables()
    }

    private func setupBindables() {
        viewModel?.detailsResult.bind({ [weak self] result in
            switch result {
            case .success(let details):
                self?.titleLabel.text = details.title
                self?.overviewLabel.text = details.overview
                self?.backdropImageView.setImage(movieDBPathURL: details.backdropPath)
            case .failure(let error):
                break
            case .none:
                break
            }
        })
    }
}
