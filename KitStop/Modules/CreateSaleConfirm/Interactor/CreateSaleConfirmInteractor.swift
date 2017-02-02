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
    func saveForSaleKit(price: String?,  condition: String?, weight: String?, post:Post, images: PostImagesModel) {
        
        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: images, success: { [weak self]
            mainImage, imageUrls in
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
    
    func updateForSaleKit(price: String?, condition: String?, weight: String?, post: Post, images: PostImagesModel) {

        self.saveImagesTo("Kits", mainImage: post.mainImageObject, images: images, success: { [weak self]
            mainImage, imageUrls in
            if imageUrls.first != nil {
                let kit = self?.requestBody(price: price!, condition: condition!, weight: weight!, post: post, imageArray: imageUrls)
                self?.kitForSaleService?.updateKit(id: post.id, kit: kit!, completion: {
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
        
        salesDetails["condition"] = condition as AnyObject?
        salesDetails["price"] = price as AnyObject?
        salesDetails["weight"] = weight as AnyObject?
        
        let kit = KitsForSaleRequestBody(title: title, brand: brand, model: model, serialNumber: serialNumber, category: category, description: description, notes: notes, mainImage: mainImage!, images: images, tags: tags, metaData: metaData, salesDetails: salesDetails, oldModel: "")
        
        return kit
    }
    
    func saveImagesTo(_ path: String, mainImage: UIImage, images: PostImagesModel, success: @escaping (_ mainImage: String, _ imageUrls: [String?]) -> () ) {

        sortImages(images: images, completion: { imageUrls, imageObjects in
           
            let imagesCount = imageUrls.count + imageObjects.count
        
            var imageStrings = imageUrls
            
            let awsManager = AWS3UploadImageService()
            
            awsManager.uploadImage(userImage: self.cropImage(image: mainImage), path: path, successBlock: { mainImage in
                if imageObjects.count == 0 {
                    success(mainImage!, imageStrings)
                } else {
                    for image in imageObjects {
                        let awsManager = AWS3UploadImageService()
                        awsManager.uploadImage(userImage: self.cropBigImage(image: image), path: path, successBlock: {
                            image in
                            imageStrings.append(image!)
                            if imageStrings.count == imagesCount  {
                                success(mainImage!, imageStrings)
                            }
                        })
                    }
                }
            })
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
    
    func getRates(completion: @escaping () -> Void) {
        kitForSaleService?.getRates(completion: { [weak self]
            success, error, rates in
            if success {
                self?.presenter.setRates(rates: rates!)
                completion()
            } else {
                self?.presenter.setRates(rates: nil)
                self?.presenter.showAlertWith(title: "Error", message: CustomError.init(code: error!).description)
            }
        })
    }
    func getRates() {
      
    }
    
    func calculatePrice(price: String, weight: String, rates: RatesModel?, completion: @escaping (_ priceModel: (PriceModel?)) -> ()) {
        if !price.isEmpty && !weight.isEmpty && rates != nil{
            
            let weightRate = rates?.weight["\(weight)"]
            let transactionPrice = Double(price)! * (rates?.transactionPercent)!/100
            let transactionRatePrice = Double(price)! * (rates?.transactionRate)!/100
            let kitStopPrice = Double(price)! * (rates?.kitStopFee)!/100
            let userPrice = Double(price)! - transactionPrice - transactionRatePrice - kitStopPrice - weightRate!
            
            let priceModel = PriceModel(weight: "Shipping UDSP \(weight):", weightRate: "$\(String(format: "%.2f", weightRate!))" ,startingPrice: "$\(price.formattedDouble(decimalPlaces: 2))", transactionPrice: "$\(String(format: "%.2f", transactionPrice))", transactionRatePrice: "$\(String(format: "%.2f", transactionRatePrice))", kitStopPrice: "$\(String(format: "%.2f", kitStopPrice))", finalPrice: "$\(String(format: "%.2f", userPrice))")
            
            completion(priceModel)
        } else {
            completion(PriceModel())
        }
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
    
}
