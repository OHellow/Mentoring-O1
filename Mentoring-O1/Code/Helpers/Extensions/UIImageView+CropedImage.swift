import UIKit

extension UIImageView {
    func cropImageToSquare() {
        guard let cgImage = self.image?.cgImage else { return }
        let shorterSide = min(image!.size.width, image!.size.height)

        let size = CGSize(width: shorterSide, height: shorterSide)

        let refWidth: CGFloat = CGFloat(cgImage.width)
        let refHeight: CGFloat = CGFloat(cgImage.height)

        let xxx = (refWidth - size.width) / 2
        let yyy = (refHeight - size.height) / 2

        let cropRect = CGRect(x: xxx, y: yyy, width: size.height, height: size.width)
        if let imageRef = cgImage.cropping(to: cropRect) {
            self.image =  UIImage(cgImage: imageRef, scale: 0, orientation: image!.imageOrientation)
        }
    }
}
