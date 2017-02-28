//
//  MyTextView.swift
//  TextViewPlaceholder
//
//  Created by Alexander Tovstonozhenko on 26.01.2017.
//  Copyright © 2017 Alexander Tovstonozhenko. All rights reserved.
//

import UIKit

class MyTextView: UITextView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        sharedInit()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        sharedInit()
    }

    func sharedInit() {
        let views: [String: Any] = [
            "self": self,
            "placeholderLabel": placeholderLabel
        ]
        let metrics = [
            "left": textContainerInset.left + textContainer.lineFragmentPadding,
            "top": textContainerInset.top,
            "right": textContainerInset.right + textContainer.lineFragmentPadding,
            "bottom": textContainerInset.bottom
        ]

        addSubview(placeholderLabel)
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(left)-[placeholderLabel(<=self)]-(right)-|",
            options: [],
            metrics: metrics,
            views: views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(top)-[placeholderLabel(<=self)]-(>=bottom)-|",
            options: [],
            metrics: metrics,
            views: views))

        setNeedsLayout()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textViewDidBeginEditing(notification:)),
            name: .UITextViewTextDidBeginEditing,
            object: self)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textViewDidEndEditing(notification:)),
            name: .UITextViewTextDidEndEditing,
            object: self)
    }

    func updatePlacePlaceholder() {
        placeholderLabel.removeFromSuperview()
        sharedInit()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textViewDidBeginEditing(notification: NSNotification) {
        placeholderLabel.isHidden = true
    }

    @objc private func textViewDidEndEditing(notification: NSNotification) {
        placeholderLabel.isHidden = !text.isEmpty
    }

    private(set) lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Широкая электрификация южных губерний даст мощный толчок подъёму сельского хозяйства."
        label.font = self.font
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}
