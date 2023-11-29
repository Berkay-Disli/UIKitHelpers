// Use it like this:
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.showToast(message: "This is a toast alert",
                           font: UIFont.systemFont(ofSize: 14, weight: .semibold), 
                           toastColor: UIColor.black, toastBackground: UIColor.white)
    }
}

// ------------ 

extension UIViewController {
    
    func showToast(message : String, font: UIFont, toastColor: UIColor = UIColor.white, 
                   toastBackground: UIColor = UIColor.black) {
        let toastLabel = UILabel()
        toastLabel.textColor = toastColor
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 6
        toastLabel.backgroundColor = toastBackground

        toastLabel.clipsToBounds  =  true

        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2), 
                                  y: self.view.frame.height - (toastHeight * 3), 
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
