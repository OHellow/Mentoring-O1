import UIKit
import SDWebImage

extension UIImageView {
    func setImage(imageURL: String?) {
        if let imgURL = imageURL {
            self.sd_setImage(with: URL(string: imgURL), completed: nil)
        }
    }

    func setImage(movieDBPathURL: String?) {
        self.setImage(imageURL: "https://image.tmdb.org/t/p/w500\(movieDBPathURL ?? "")")
    }
}
