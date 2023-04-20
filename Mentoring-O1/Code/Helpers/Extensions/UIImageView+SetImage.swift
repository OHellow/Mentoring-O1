import UIKit
import SDWebImage

extension UIImageView {
    func setImage(imageURL: String?, completion: (() -> Void)?) {
        if let imgURL = imageURL {
            self.sd_setImage(with: URL(string: imgURL)) { _, _, _, _ in
                completion?()
            }
        }
    }

    func setImage(movieDBPathURL: String?, completion: (() -> Void)?) {
        self.setImage(imageURL: "https://image.tmdb.org/t/p/w500\(movieDBPathURL ?? "")", completion: completion)
    }
}
