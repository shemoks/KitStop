//
//  KitFolioCreateInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioCreateInteractor
import UIKit

final class KitFolioCreateInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: KitFolioCreateInteractorOutput!
    
    fileprivate var awsManager = AWS3UploadImageService()
    fileprivate let kitFolioService: CreateKitFolioServiceProtocol?
    fileprivate var successBlock: (() -> ())? = nil
    // MARK: -
    
    init(kitFolioService: CreateKitFolioServiceProtocol) {
        self.kitFolioService = kitFolioService
    }
    
    convenience init() {
        self.init(kitFolioService: CreateKitFolioService())
    }
    
}

// MARK: - KitFolioCreateInteractorInput

extension KitFolioCreateInteractor: KitFolioCreateInteractorInput {
    
    func save(postTitle: String, postDescription: String, smallImage: UIImage?, bigImage: UIImage?) {
        self.saveImageTo(["KitFolio/small", "KitFolio/big"], images: [smallImage!, bigImage!], success: {
            smallImageUrl, bigImageUrl in
            if smallImageUrl != nil && bigImageUrl != nil {
                self.kitFolioService?.createKitFolioItem(postTitle: postTitle, postDescription: postDescription, mainImageUrl: smallImageUrl!, arrayImageUrl: [smallImageUrl!, bigImageUrl!], completionBlock: {
                    [weak self] result , error in
                    LoadingIndicatorView.hide()
                    if result {
                        self?.presenter.handleViewWillDisappear()
                    } else {
                        let errorMessage = CustomError(code: error!).description
                        self?.presenter.showAlertWith(title: "Error", message: errorMessage)
                    }
                })
            } else {
                LoadingIndicatorView.hide()
                self.presenter.showAlertWith(title: "Error", message: "Image upload failed. Please try again later")
            }
        })
    }
    
    func saveImageTo(_ path: [String], images: [UIImage], success: @escaping (_ smallImageUrl: String?, _ bigImageUrl: String?) -> () ) {
            awsManager.uploadImage(userImage: images[0], path: path[0], successBlock: {
                [weak self] smallImageUrl in
                self?.awsManager = AWS3UploadImageService()
                DispatchQueue.main.async {
                    self?.awsManager.uploadImage(userImage: images[1], path: path[1], successBlock: {
                        bigImageUrl in
                        success(smallImageUrl, bigImageUrl)
                    })
                }
            })
    }
    
}
