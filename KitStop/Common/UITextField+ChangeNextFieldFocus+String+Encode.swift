//
//  UITextField+ChangeNextFieldFocus.swift
//  KitStop
//
//  Created by sasha ataman on 16.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func emailValidation(textField: UITextField) -> Bool {
        let expression = "^[-\\w.]+@([A-z0-9][-A-z0-9]+\\.)+[A-z]{2,4}$"
        
        let emailTest: NSPredicate  = NSPredicate(format: "SELF MATCHES[c] %@", expression)
        
        let finishResult = emailTest.evaluate(with: textField.text)
        return finishResult
    }
    
    func checkFieldFrom(email: UITextField, textField: UITextField) {
        if textField != email && email.text != "" && !UITextField().emailValidation(textField: email) {
            email.layer.borderColor = UIColor.red.cgColor
            email.textColor = UIColor.red
        } else {
            email.layer.borderColor = UIColor.white.cgColor
            email.textColor = UIColor.black
        }

    }
}

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
    public func getUUID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    public func getUniqueName() -> String {
        return NSUUID().uuidString
    }
    
    func date(format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)!
    }
    
}

extension Double {
    public func checkNumberAfterDot(number: Double) -> String {
        let beforeDot = "\(number)".components(separatedBy: ".")[0]
        let afterDot = "\(number)".components(separatedBy: ".")[1]
        if afterDot == "0" {
            return beforeDot
        }
        return "\(number)"
    }
}

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        for view in UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil){
                if let xib = (view as? UIView) {
                    return xib
                }
        }
        return nil
    }
}

extension UIImage {
    
    public func heightWithOrientation(contentHeight: CGFloat) -> CGFloat {
        if size.width == size.height {
            return contentHeight * 2
        } else if size.height > size.width {
            return contentHeight * 2
        } else {
            return contentHeight
        }
    }
    
    public func cropToSmall() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 500, height: 500))
        self.draw(in: CGRect(x: 0, y: 0, width: 500, height: 500))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func cropToBig() -> UIImage {
        let newWidth: CGFloat = 1080
        var newHeight: CGFloat?
        if size.width == size.height {
            newHeight = newWidth
        } else if size.height > size.width {
            newHeight = 1350
        } else {
            newHeight = 566
        }
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight!))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight!))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension Date {
    
    public func dateFrom(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let format = dateFormatter.date(from: string)
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.dateStyle = .medium
        var date = dateFormatter.string(from: format!).replacingOccurrences(of: ",", with: "").components(separatedBy: " ")
        
        swap(&date[1], &date[0])
        
        return date.joined(separator: " ")
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    
}

extension UIColor {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
