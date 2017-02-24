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
        let expression = "^[-\\w.]+@([A-z0-9]+\\.)+[A-z]{2,4}$"
        
        let emailTest: NSPredicate  = NSPredicate(format: "SELF MATCHES[c] %@", expression)
        
        let finishResult = emailTest.evaluate(with: textField.text)
        return finishResult
    }
    
    func checkFieldFrom(email: UITextField, textField: UITextField) {
        if textField != email && !UITextField().emailValidation(textField: email) {
            email.layer.borderColor = UIColor.red.cgColor
            email.textColor = UIColor.red
        } else {
            email.layer.borderColor = UIColor.white.cgColor
            email.textColor = UIColor.black
        }
    }
    
    func checkIfEmailIsValid(email: UITextField) -> Bool {
        if !UITextField().emailValidation(textField: email) {
            email.layer.borderColor = UIColor.red.cgColor
            email.textColor = UIColor.red
            return true
        } else {
            email.layer.borderColor = UIColor.white.cgColor
            email.textColor = UIColor.black
            return false
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
        if afterDot == "0" && afterDot.characters.count == 1 {
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
    
    func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage {
        return resizeImage(image: RBSquareImage(image: image), targetSize: size)
    }
    
    func RBSquareImage(image: UIImage) -> UIImage {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRect(x: posX, y: posY, width: edge, height: edge)
        
        let imageRef = image.cgImage!.cropping(to: cropSquare);
        return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func RBResizeImage(targetSize: CGSize, staticWidth: Bool) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        var newSize: CGSize
        var width: CGFloat = 500
        if staticWidth {
            width = 1080
        }
        
        if(widthRatio > heightRatio) {
            newSize = CGSize.init(width: width, height: size.height * widthRatio)
        } else {
            newSize = CGSize.init(width: width, height: size.height * heightRatio)
        }
        
        let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func heightWithOrientation(contentHeight: CGFloat) -> CGFloat {
        if size.width == size.height {
            return contentHeight * 2
        } else if size.height > size.width {
            return contentHeight * 2
        } else {
            return contentHeight
        }
    }
    
    public func bigHeightSize() -> CGFloat {
        var newHeight: CGFloat?
        if size.width == size.height {
            newHeight = 1080
        } else if size.height > size.width {
            newHeight = 1350
        } else {
            newHeight = 566
        }
        return newHeight!
    }
    
    public func cropToSmall() -> UIImage {
        let newSize = CGSize(width: 500, height: 500)
        let rect = CGRect.init(x: 0, y: 0, width: 500, height: 500)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
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

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func dividedByUppercaseLetter() -> String {
        var currentWord: String = ""
        var words: [String] = []
        
        for char in self.characters {
            let charString = String(char)
            
            if (charString == charString.uppercased()) && currentWord.characters.count > 0 {
                words.append(currentWord)
                currentWord = ""
            }
            
            currentWord.append(char)
        }
        
        if currentWord.characters.count > 0 {
            words.append(currentWord)
        }
        
        return words.joined(separator: " ")
    }
    
    func capitalizeFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    func lowerCaseFirstLetter() -> String {
        let first = String(characters.prefix(1)).lowercased()
        let other = String(characters.dropFirst())
        return first + other
    }
    
}



extension String {
    func formattedDouble(decimalPlaces: Int) -> Double {
        if self.contains(",") {
            let localizedDecimalString = self.replacingOccurrences(of: ",", with: ".")
            let formattedString = String(format: "%.\(decimalPlaces)f", Double(localizedDecimalString)!)
            return Double(formattedString)!
        }
        let formattedString = String(format: "%.\(decimalPlaces)f", Double(self)!)
        return Double(formattedString)!
    }
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

extension Request {
    public func debugLog() -> Self {
            debugPrint(self)
        return self
    }
}
