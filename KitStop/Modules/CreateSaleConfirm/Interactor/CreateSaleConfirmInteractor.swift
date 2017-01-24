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
    func saveForSaleKit(price: String?, date: String?, condition: String?, weight: String?, isPrivate:Bool, post:Post) {
        self.saveImagesTo("Kits", images: post.images, success: { [weak self]
            imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, date: date!, condition: condition!, weight: weight!, isPrivate: isPrivate, post: post, imageArray: imageUrls)
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
    
    func requestBody(price: String, date: String, condition: String, weight: String, isPrivate:Bool, post: Post, imageArray: [String?]) -> KitsForSaleRequestBody {
        
        var metaData = [String:AnyObject]()
        
        var salesDetails = [String: AnyObject]()
        
        salesDetails.updateValue(condition as AnyObject, forKey: "Condition")
        salesDetails.updateValue(price as AnyObject, forKey: "Sale Price")
        salesDetails.updateValue(weight as AnyObject, forKey: "Package Weight")
        
        for item in post.metadata {
            metaData.updateValue(item.textValue as AnyObject, forKey: item.title)
        }
        
        let title = post.generalProperty[2].textValue
        let brandName = post.generalProperty.first?.textValue
        let model = post.generalProperty.last?.textValue
        let serialNumber = post.generalProperty[1].textValue
        
        var manufacturerCountry = ""
        
        if post.metadata.count > 1 {
            manufacturerCountry = post.metadata[1].textValue
        }
        
        var purchaseDate = TimeInterval()
        
        if !date.isEmpty {
            purchaseDate = date.date(format: "dd/MMM/yyyy").timeIntervalSince1970
        }
        
        let purchasePrice = String(price.formattedDouble(decimalPlaces: 2))
        let buyingPlace = ""
        let category = post.categoryId
        let userDescription = post.description.textValue
        let manufacturerDescription = post.notes.textValue
        
        let notes = post.notes.textValue
        let mainImage = imageArray.first
        let images = imageArray
        let condition = post.salesDetails.first?.textValue
        let tags = [String?]() 
        
        let kit = KitsForSaleRequestBody(title: title, brandName: brandName, model: model, serialNumber: serialNumber, manufacturerCountry: manufacturerCountry, purchaseDate: purchaseDate, purchasePrice: purchasePrice, buyingPlace: buyingPlace, category: category, userDescription: userDescription, manufacturerDescription: manufacturerDescription, notes: notes, mainImage: mainImage!!, images: images, condition: condition, tags: tags, metaData: metaData, salesDetails: salesDetails, isPrivate: isPrivate)
        
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
    
    func updateFinalPrice(pricingModel: KitsForSalePricingModel) {
        
    }
}
