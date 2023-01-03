import UIKit

open class BHToast: UIView {
    private let toastView = UIView()
    private var message = UILabel()
    
    public convenience init(message: UILabel = UILabel()) {
        self.init(frame: CGRect.zero)
        self.message = message
    }
}

extension BHToast {
    public func showBHToast(text: String) {
        setAttribute(text: text)
        configureLayout(toastView)
        setConstraints(toastView)
    }
    
    private func configureLayout(_ rootView: UIView) {
        rootView.addSubview(self)
        self.addSubview(toastView)
        [message].forEach {
            toastView.addSubview($0)
        }
    }
    
    private func setConstraints(_ rootView: UIView) {
        
        self.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: rootView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: rootView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
        
        toastView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        toastView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        toastView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        toastView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true

        message.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 0).isActive = true
        message.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 0).isActive = true
        message.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: 0).isActive = true
        message.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: 0).isActive = true
    }
    
    public func setAttribute(text: String) {
        message.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        message.textColor = UIColor.white
        message.font = UIFont.systemFont(ofSize: 14)
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

