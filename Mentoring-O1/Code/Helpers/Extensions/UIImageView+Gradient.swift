import UIKit

extension UIImageView {
    func applyMovieDetailPosterGradient() {
        let topToBottomGradient = CAGradientLayer()
        topToBottomGradient.frame = self.bounds
        topToBottomGradient.colors = [hexStringToUIColor(hex: "#041D33").cgColor, UIColor.clear.cgColor]
        topToBottomGradient.startPoint = CGPoint(x: 0.5, y: 0)
        topToBottomGradient.endPoint = CGPoint(x: 0.5, y: 0.08)
        self.layer.addSublayer(topToBottomGradient)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [hexStringToUIColor(hex: "#041D33").cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.75)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        self.layer.addSublayer(gradientLayer)
    }

    private var kHexNumbersCount: Int {
        return 6
    }

    func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != kHexNumbersCount {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
