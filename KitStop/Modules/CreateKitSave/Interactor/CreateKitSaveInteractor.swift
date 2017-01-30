//
//  CreateKitSaveInteractor.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateKitSaveInteractor
import UIKit

final class CreateKitSaveInteractor {

    // MARK: - VIPER stack

    weak var presenter: CreateKitSaveInteractorOutput!


    fileprivate let createKitService: CreateKitsServiceProtocol?
    // MARK: -
    
    init(createKitService: CreateKitsServiceProtocol) {
        self.createKitService = createKitService
    }
    
    convenience init() {
        self.init(createKitService: CreateKitsService())
    }

}

// MARK: - CreateKitSaveInteractorInput

extension CreateKitSaveInteractor: CreateKitSaveInteractorInput {
    func saveKit(price: String?, date: String?, isPrivate:Bool, post:Post) {
        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: post.images,  success: { [weak self]
            mainImage, imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, date: date!, isPrivate: isPrivate, post: post, imageArray: imageUrls)
                self?.createKitService?.createKit(kit: kit!, completion: {
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
    
    func updateKit(price: String?, date: String?, isPrivate: Bool, post: Post) {
        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: post.images, success: { [weak self]
            mainImage, imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, date: date!, isPrivate: isPrivate, post: post, imageArray: imageUrls)
                self?.createKitService?.updateKit(id: post.id, kit: kit!, completion: {
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
    
    // Some questionable code here. Should probably take different approach to request body creation.
    func requestBody(price: String, date: String, isPrivate:Bool, post: Post, imageArray: [String?]) -> CreateKitsRequestBody {
        
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
        var purchaseDate = TimeInterval()
        var purchasePrice = ""
        let category: String = post.categoryId
        let description = post.description.textValue
        let notes = post.notes.textValue
        let mainImage = imageArray.first!
        let images = imageArray
        let tags  = [String?]()
        let isPrivate = isPrivate
        
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
        
        if !date.isEmpty {
            purchaseDate = date.date(format: "dd/MMM/yyyy").timeIntervalSince1970
        }
        
        if !price.isEmpty {
            purchasePrice = String(price.formattedDouble(decimalPlaces: 2))
        }
        
        let kit = CreateKitsRequestBody(title: title, brand: brand, model: model, serialNumber: serialNumber, purchaseDate: purchaseDate, purchasePrice: purchasePrice, category: category, description: description, notes: notes, mainImage: mainImage!, images: images, tags: tags, metaData: metaData, isPrivate: isPrivate)
        
        return kit
    }
    
    func saveImagesTo(_ path: String, mainImage: UIImage, images: [UIImage], success: @escaping (_ mainImage: String, _ imageUrls: [String?]) -> () ) {
        var imageUrls:[String?] = []
        
        let awsManager = AWS3UploadImageService()
        awsManager.uploadImage(userImage: cropImage(image: mainImage), path: path, successBlock: { mainImage in
            for image in images {
                
                let awsManager = AWS3UploadImageService()
                awsManager.uploadImage(userImage: self.cropBigImage(image: image), path: path, successBlock: {
                    image in
                    imageUrls.append(image)
                    if imageUrls.count == images.count {
                        success(mainImage!, imageUrls)
                    }
                })
            }
        })
        
    }
    
    func cropImage(image: UIImage) -> UIImage {
        if abs(image.size.width - image.size.height) > 50 {
            return UIImage().RBSquareImageTo(image: image, size: CGSize(width: 500, height: 500))
        } else {
            return image
        }
    }
    
    func cropBigImage(image: UIImage) -> UIImage {
        return image.RBResizeImage(targetSize: CGSize(width: 1080, height: image.bigHeightSize()), staticWidth: true)
    }
}
