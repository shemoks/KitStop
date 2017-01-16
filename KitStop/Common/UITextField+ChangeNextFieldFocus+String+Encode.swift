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


