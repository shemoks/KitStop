//
//  SelectImageInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - SelectImageInteractor

import UIKit

final class SelectImageInteractor {

    // MARK: - VIPER stack

    weak var presenter: SelectImageInteractorOutput!

    fileprivate let awsManager: AWS3UploadImageProtocol
    // MARK: -
    
    init(awsManager: AWS3UploadImageProtocol) {
        self.awsManager = awsManager
    }
    
    convenience init() {
        self.init(awsManager: AWS3UploadImageService())
    }

}

// MARK: - SelectImageInteractorInput

extension SelectImageInteractor: SelectImageInteractorInput {
    
    func saveImageTo(_ path: String, image: UIImage) {
        awsManager.uploadImage(userImage: image, path: path, successBlock: {
            result in
            print(result!)
        })
    }
}
