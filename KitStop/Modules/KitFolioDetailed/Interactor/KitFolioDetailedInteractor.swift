//
//  KitFolioDetailedInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioDetailedInteractor
import UIKit

final class KitFolioDetailedInteractor {

    // MARK: - VIPER stack

    weak var presenter: KitFolioDetailedInteractorOutput!

    // MARK: -
    fileprivate let kitFolioDetailerManager: KitFolioDetailedServiceProtocol?
    fileprivate var awsManager = AWS3UploadImageService()
    
    init(kitFolioDetailerManager: KitFolioDetailedServiceProtocol) {
        self.kitFolioDetailerManager = kitFolioDetailerManager
    }
    
    convenience init() {
        self.init(kitFolioDetailerManager: KitFolioDetailedService())
    }
}

// MARK: - KitFolioDetailedInteractorInput

extension KitFolioDetailedInteractor: KitFolioDetailedInteractorInput {
    func fetchKitFrom(id: String?) {
        kitFolioDetailerManager?.fetchKit(id: id!, completitionBlock: {
            [weak self] product, user, error in
            if error == nil {
                self?.presenter.updateProductData(product: product!, user: user)
            } else {
                // show alert
            }
        })
    }
    
    func delete(id: String) {
        kitFolioDetailerManager?.deleteKitFolio(id: id, completitionBlock: {
            [weak self] error in
            if error == nil {
                self?.presenter.showSuccessAlert(title: "Success", message: "Delete success")
            } else {
                let message = CustomError.init(code: error!).description
                self?.presenter.showErrorAlert(title: "Error", message: message)
            }
        })
    }
    
    func save(images: [UIImage?], data: [String : String], id: String, mainImage: UIImage?) {
        self.saveImageTo(["KitFolio/small", "KitFolio/big"], images: images as! [UIImage], success: {
            [weak self] smallImageUrl, bigImageUrl in
            if smallImageUrl != nil && bigImageUrl != nil {
                self?.kitFolioDetailerManager?.saveKitFolio(id: id, imageArray: [smallImageUrl!, bigImageUrl!], data: data, mainImage: smallImageUrl!, completitionBlock: {
                    [weak self] product, error in
                    LoadingIndicatorView.hide()
                    if error == nil {
                        self?.presenter.updateProduct(product: product!)
                    } else {
                        let message = CustomError.init(code: error!).description
                        self?.presenter.showErrorAlert(title: "Error", message: message)
                    }
                })
                } else {
                LoadingIndicatorView.hide()
                self?.presenter.showErrorAlert(title: "Error", message: "Image upload fail")
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
