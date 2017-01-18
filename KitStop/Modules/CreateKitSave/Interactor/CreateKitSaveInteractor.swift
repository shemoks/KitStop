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
    func saveKit(price: String, date: String, isPrivate:Bool, post:Post) {
        self.saveImagesTo("Kits", images: post.images, success: {
            imageUrls in
            if imageUrls.first != nil {
                let kit = self.requestBody(price: price, date: date, isPrivate: isPrivate, post: post, imageArray: imageUrls)
                self.createKitService?.createKit(kit: kit, completion: {
                    result , error, id in
                    LoadingIndicatorView.hide()
                    if result {
                        
                    } else {
                        let errorMessage = CustomError(code: error!).description
                        self.presenter.showAlertWith(title: "Error", message: errorMessage)
                    }
                })
            } else {
                LoadingIndicatorView.hide()
                self.presenter.showAlertWith(title: "Error", message: "Image upload fail")
            }
        })
    }
    
    // Some questionable code here. Should probably take different approach to request body creation.
    func requestBody(price: String, date: String, isPrivate:Bool, post: Post, imageArray: [String?]) -> CreateKitsRequestBody {
        
        var metaData = [String:AnyObject]()
        
        for item in post.metadata {
            metaData.updateValue(item.currentData! as AnyObject, forKey: item.title)
        }
        
        let title = post.generalProperty[2].textValue
        let brandName = post.generalProperty.first?.textValue
        let model = post.generalProperty.last?.textValue
        let serialNumber = post.generalProperty[1].textValue
        let manufacturerCountry = post.metadata[1].textValue
        let purchaseDate = date.date(format: "dd/MMM/yyyy").timeIntervalSince1970
        let purchasePrice = price
        let buyingPlace = ""
        let category = post.categoryId
        let userDescription = post.description.textValue
        let manufacturerDescription = ""
        let notes = post.notes.textValue
        let mainImage = imageArray.first
        let images = imageArray
        let condition = post.salesDetails.first?.textValue
        let tags = [String?]()
        
        let kit = CreateKitsRequestBody(title: title, brandName: brandName, model: model, serialNumber: serialNumber, manufacturerCountry: manufacturerCountry, purchaseDate: purchaseDate, purchasePrice: purchasePrice, buyingPlace: buyingPlace, category: category, userDescription: userDescription, manufacturerDescription: manufacturerDescription, notes: notes, mainImage: mainImage!!, images: images, condition: condition, tags: tags, metaData: metaData, isPrivate: isPrivate)
        
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
