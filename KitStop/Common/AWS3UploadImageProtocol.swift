//
//  AWS3UploadImageProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 29.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//
import UIKit
import Foundation

protocol AWS3UploadImageProtocol {
    func uploadImage(userImage: UIImage?, successBlock: @escaping (_ url: String?) -> ())
}
