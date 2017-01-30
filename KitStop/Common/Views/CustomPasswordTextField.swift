//
//  CustomPassword.swift
//  KitStop
//
//  Created by sasha ataman on 12.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class CustomPasswordTextField: UITextField, UITextFieldDelegate {
    
    weak var passwordDelegate: CustomPasswordDelegateTextField?
    weak var email: UITextField?
    
    fileprivate let eyeView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
    fileprivate var tapCounter = false
    fileprivate let eyeImageInvisible = UIImage.init(named: "eye_invisible")
    fileprivate let eyeImageVisible = UIImage.init(named: "eye_visible")
    
    override func awakeFromNib() {
        let imageContainer = UIView.init(frame: CGRect.init(x: self.bounds.origin.x, y: self.bounds.origin.y, width: 40, height: 40))
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapOnEyeIcon))
        eyeView.isUserInteractionEnabled = true
        eyeView.addGestureRecognizer(tapGestureRecognizer)
        eyeView.image = eyeImageInvisible
        eyeView.center = imageContainer.center
        imageContainer.addSubview(eyeView)
        self.delegate = self
        self.rightViewMode = .always
        self.rightView = imageContainer
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldDidChange() {
        if !tapCounter {
            eyeView.image = self.text == "" ? eyeImageInvisible : eyeImageVisible
        }
    }
    
    func changeEyeImage() {
        eyeView.image = !tapCounter ? eyeImageInvisible : eyeImageVisible
        tapCounter = !tapCounter
    }
    
    func tapOnEyeIcon() {
        if self.text != "" {
            changeEyeImage()
            passwordDelegate?.tapOnPasswordImageSuccess(textField: self)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = string
        if string.range(of: "\n") != nil {
            textField.nextField?.becomeFirstResponder()
            if textField.returnKeyType == .done {
                passwordDelegate?.openNextModule()
            }
            return true
           // text = string.substring(to: string.index(before: string.endIndex))
        }
        if let start: UITextPosition = self.position(from: textField.beginningOfDocument, offset: range.location),
            let end: UITextPosition = self.position(from: start, offset: range.length),
            let textRange: UITextRange = self.textRange(from: start, to: end) {
            self.replace(textRange, withText: text)
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let email = self.email {
            UITextField().checkFieldFrom(email: email, textField: textField)
        }
    }
}
