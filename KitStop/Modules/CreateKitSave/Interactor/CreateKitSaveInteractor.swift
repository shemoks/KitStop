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



    // MARK: - Services
    fileprivate var createKitService: CreateKitsServiceProtocol?
    
    // MARK: - Services initializer
    init(createKitService: CreateKitsServiceProtocol) {

        self.createKitService = createKitService
    }
    
    convenience init() {
        self.init(createKitService: CreateKitsService())
    }

}

// MARK: - CreateKitSaveInteractorInput

extension CreateKitSaveInteractor: CreateKitSaveInteractorInput {
    
    func saveKit(price: String?, date: String?, isPrivate:Bool, post:Post, images: PostImagesModel) {
        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: images,  success: { [weak self]
            mainImage, imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, date: date!, isPrivate: isPrivate, post: post, imageArray: imageUrls, oldModel: "kit")
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
                self?.presenter.showAlertWith(title: "Error", message: "Image upload failed. Please try again later")
            }
        })
    }
    
    func updateKit(price: String?, date: String?, isPrivate: Bool, post: Post, images: PostImagesModel, oldModel: String) {
        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: images, success: { [weak self]
            mainImage, imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, date: date!, isPrivate: isPrivate, post: post, imageArray: imageUrls, oldModel: oldModel)
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
                self?.presenter.showAlertWith(title: "Error", message: "Image upload failed. Please try again later")
            }
        })
    }
    
    
    // MARK: - AWS3 image upload service
    func saveImagesTo(_ path: String, mainImage: UIImage, images: PostImagesModel, success: @escaping (_ mainImage: String, _ imageUrls: [OrderedImage?]) -> () ) {
        
        sortImages(images: images, completion: { imageUrls, imageObjects in
            
            let imagesCount = imageUrls.count + imageObjects.count
            
            var sortedImages: [OrderedImage?] = []
            
            for (index, image) in imageUrls.enumerated() {
                sortedImages.append(OrderedImage(key: index, url: image))
                print(index)
            }
            
            let awsManager = AWS3UploadImageService()
            
            var index = sortedImages.count
            
            awsManager.uploadImage(userImage: self.cropImage(image: mainImage), path: path, successBlock: { mainImage in
                if imageObjects.count == 0 {
                    success(mainImage!, sortedImages)
                } else {
                    for image in imageObjects {
                        let awsManager = AWS3UploadImageService()
                        awsManager.uploadImage(userImage: self.cropBigImage(image: image), path: path, successBlock: {
                            image in
                            print(index)
                            
                            sortedImages.append(OrderedImage(key: index, url: image!))
                            index += 1
                            
                            if sortedImages.count == imagesCount  {
                                success(mainImage!, sortedImages)
                            }
                        })
                    }
                }
            })
        })
    }
    
    
    // MARK: Image helper methods
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
    
    func sortImages(images: PostImagesModel, completion: @escaping (_ imageUrls: [String], _ imageObjects: [UIImage]) -> ()) {
        
        var imageUrls = [String]()
        var imageObjects = [UIImage]()
        
        for image in images.forGallery {
            switch image {
            case .Actual(let image):
                imageObjects.append(image)
            case .Remote(let url):
                imageUrls.append(url.absoluteString)
            default:
                break
            }
        }
        
        completion(imageUrls, imageObjects)
    }
    
    
    
    // MARK: - Request body initialization
    // Some questionable code here. Should probably take different approach to request body creation.
    func requestBody(price: String, date: String, isPrivate:Bool, post: Post, imageArray: [OrderedImage?], oldModel: String) -> CreateKitsRequestBody {
        
        var metaData:[String:AnyObject] = [:]
        
        for item in post.metadata {
            let key = item.title.capitalized.replacingOccurrences(of: " ", with: "")
            metaData[key.lowerCaseFirstLetter()] = item.textValue as AnyObject?
        }
        
        var title: String = ""
        var brand: String?
        var model: String?
        var serialNumber: String?
        var purchaseDate = TimeInterval()
        var purchasePrice = ""
        let category: String = post.categoryId
        let description = post.description.textValue
        let notes = post.notes.textValue
        let mainImage = imageArray.first??.url
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
        
        let kit = CreateKitsRequestBody(title: title, brand: brand, model: model, serialNumber: serialNumber, purchaseDate: purchaseDate, purchasePrice: purchasePrice, category: category, description: description, notes: notes, mainImage: mainImage!, images: images, tags: tags, metaData: metaData, isPrivate: isPrivate, oldModel: oldModel)
        
        return kit
    }
    
        

}
