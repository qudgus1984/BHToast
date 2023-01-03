import UIKit

public enum BHToastStyle {
    case basic
    case long
    case short
}

open class BHToast: UIView {
    private let toastView = UIView()
    private var message = UILabel()
    
    public convenience init(message: UILabel = UILabel()) {
        self.init(frame: CGRect.zero)
        self.message = message
    }
}

extension BHToast {
    public func showBHToast(_ rootView: UIView, text: String, font: UIFont, Style: BHToastStyle) {
        setAttribute(text: text, font: font)
        configureLayout(rootView)
        setConstraints(rootView, Style: Style)
    }
    
    private func configureLayout(_ rootView: UIView) {
        rootView.addSubview(self)
        self.addSubview(toastView)
        toastView.addSubview(message)
    }
    
    private func setConstraints(_ rootView: UIView, Style: BHToastStyle) {
        switch Style {
        case .basic:
            self.message = UILabel(frame: CGRect(x: rootView.frame.size.width/2 - 75, y: rootView.frame.size.height-100, width: 150, height: 35))
            
        case .long:
            self.message = UILabel(frame: CGRect(x: rootView.frame.size.width/2 - 75, y: rootView.frame.size.height-100, width: 200, height: 35))

        case .short:
            self.message = UILabel(frame: CGRect(x: rootView.frame.size.width/2 - 75, y: rootView.frame.size.height-100, width: 100, height: 35))

        }
    }
    
    public func setAttribute(text: String, font: UIFont) {
        message.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        message.textColor = UIColor.white
        message.font = font
        message.textAlignment = .center;
        message.text = text
        message.alpha = 1.0
        message.layer.cornerRadius = 10;
        message.clipsToBounds  =  true
        toastView.addSubview(message)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: { [self] in
            message.alpha = 0.0
        }, completion: { [self](isCompleted) in
            message.removeFromSuperview()
        })
    }
}
