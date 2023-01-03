import UIKit

/*
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
*/

@available(iOS 13.0, *)
open class BHToast: UIView {
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var lineView: UIView!
    private var confirmButton: UIButton!

    private var titleText: String?
    private var confirmText: String?
    private var completion: (() -> Void)?

    public convenience init(title: String, confirm: String, completion: (() -> Void)?) {
        self.init(frame: CGRect.zero)

        self.titleText = title
        self.confirmText = confirm
        self.completion = completion
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        contentView = UIView()
        titleLabel = UILabel()
        lineView = UIView()
        confirmButton = UIButton(type: .custom)

        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setAttribute() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        contentView.layer.cornerRadius = 14.0
        contentView.backgroundColor = .white

        lineView.backgroundColor = .lightGray

        titleLabel.text = titleText ?? "Title"

        confirmButton.setTitle(confirmText ?? "confirm", for: .normal)
        confirmButton.setTitleColor(.blue, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }

    open func show(in superview: UIView) {
        setAttribute()

        superview.addSubview(self)
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true

        self.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 270.0).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50.0).isActive = true

        contentView.addSubview(lineView)
        lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        contentView.addSubview(confirmButton)
        confirmButton.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }

    @objc
    private func confirmAction() {
        self.removeFromSuperview()
        completion?()
    }
}
