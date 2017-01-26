//
//  CreateSaleConfirmInteractor.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateSaleConfirmInteractor
import UIKit

final class CreateSaleConfirmInteractor {

    // MARK: - VIPER stack

    weak var presenter: CreateSaleConfirmInteractorOutput!

    fileprivate let kitForSaleService: CreateForSaleServiceProtocol?
    // MARK: -
    
    init(kitForSaleService: CreateForSaleServiceProtocol) {
        self.kitForSaleService = kitForSaleService
    }
    
    convenience init() {
        self.init(kitForSaleService: CreateForSaleService())
    }

}

// MARK: - CreateSaleConfirmInteractorInput

extension CreateSaleConfirmInteractor: CreateSaleConfirmInteractorInput {
    func saveForSaleKit(price: String?,  condition: String?, weight: String?, isPrivate:Bool, post:Post) {
        self.saveImagesTo("Kits", images: post.images, success: { [weak self]
            imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, condition: condition!, weight: weight!, post: post, imageArray: imageUrls)
                self?.kitForSaleService?.createKit(kit: kit!, completion: {
                    result , error, id in
                    LoadingIndicatorView.hide()
                    if result {
                        self?.presenter.returnToMainModule()
                    } else {
                        let errorMessage = CustomError(code: error!).description
                        self?.presenter.showAlertWith(title: "Error", message: errorMessage)
                    }
                })
            } else {
                LoadingIndicatorView.hide()
                self?.presenter.showAlertWith(title: "Error", message: "Image upload failed")
            }
        })
    }
    
    func requestBody(price: String, condition: String, weight: String, post: Post, imageArray: [String?]) -> KitsForSaleRequestBody {
        
        var metaData:[String:AnyObject] = [:]
        
        for item in post.metadata {
            let key = item.title.capitalized.replacingOccurrences(of: " ", with: "")
            metaData[key.lowerCaseFirstLetter()] = item.textValue as AnyObject?
        }
        
        print(metaData)
        
        var title: String = ""
        var brand: String?
        var model: String?
        var serialNumber: String?
        let category: String = post.categoryId
        let description = post.description.textValue
        let notes = post.notes.textValue
        let mainImage = imageArray.first!
        let images = imageArray
        let tags  = [String?]()
        
        for item in post.generalProperty {
            switch item.title {
            case "Title":
                title = item.textValue
            case "Brand":
                brand = item.textValue
            case "Model":
                model = item.textValue
            case "Serial #":
                serialNumber = item.textValue
            default:
                _ = "Default"
            }
        }
    
        var salesDetails: [String:AnyObject] = [:]
        
        salesDetails["сondition"] = condition as AnyObject?
        salesDetails["salePrice"] = price as AnyObject?
        salesDetails["packageWeight"] = weight as AnyObject?
        
        let kit = KitsForSaleRequestBody(title: title, brand: brand, model: model, serialNumber: serialNumber, category: category, description: description, notes: notes, mainImage: mainImage!, images: images, tags: tags, metaData: metaData, salesDetails: salesDetails, isPrivate: false)
        
        return kit
    }
    
    func saveImagesTo(_ path: String, images: [UIImage], success: @escaping (_ imageUrls: [String?]) -> () ) {
        var imageUrls:[String?] = []
        for image in images {
            let awsManager = AWS3UploadImageService()
            awsManager.uploadImage(userImage: image, path: path, successBlock: {
                image in
                imageUrls.append(image)
                if imageUrls.count == images.count {
                    success(imageUrls)
                }
            })
        }
        
    }
    
}
