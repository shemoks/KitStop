//
//  KitsDetailedInteractor.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitsDetailedInteractor

final class KitsDetailedInteractor {

    // MARK: - VIPER stack

    weak var presenter: KitsDetailedInteractorOutput!

    fileprivate let dataManager: ViewPostServiceProtocol
    fileprivate let dataManagerRates: CreateForSaleServiceProtocol
    // MARK: -



    init(dataManager: ViewPostServiceProtocol, dataManagerRates: CreateForSaleServiceProtocol) {
        self.dataManager = dataManager
        self.dataManagerRates = dataManagerRates
    }

    convenience init() {
        self.init(dataManager: ViewPostService(), dataManagerRates: CreateForSaleService())
    }

}

// MARK: - KitsDetailedInteractorInput

extension KitsDetailedInteractor: KitsDetailedInteractorInput {

    func getPost(forSale: Bool, idPost: String) {
        if !forSale {
            dataManager.getAllKits(idKit: idPost, forSale: false) { [weak self] object, error in
                if error == nil {
                    self?.presenter.setPost(post: object)
                } else {
                    let error = CustomError(code: error!).description
                    self?.presenter.showError(title: "Error", message: error)
                }
            }
        } else {
            dataManager.getAllKitsForSale(idKit: idPost, forSale: true) { [weak self] object, error in
                if error == nil {
                    print(object)
                    self?.dataManagerRates.getRates { [weak self] flag, error, rates in
                        if error == nil {
                            let priceModel = self?.getValuesForView(post: object, rates: rates!)
                            self?.presenter.setRates(rates: priceModel!)
                        }
                    }
                    self?.presenter.setPost(post: object)
                } else {
                    let error = CustomError(code: error!).description
                    self?.presenter.showError(title: "Error", message: error)
                }
            }


        }
    }

    func getValuesForView(post: Post, rates: RatesModel) -> PriceModel {
        var resultRate = 0.00
        var stringRate = ""
        var price = "0.00"
        for index in post.salesDetails {
            if index.title == "Package Weight" {
                let value = index.textValue
                for (rate, rateValue) in rates.weight {
                    if rate == value {
                        resultRate = rateValue
                        stringRate = rate
                    }
                }
            }
            if index.title == "Sale price" {
                price = index.textValue
            }
        }

        let transactionPrice = Double(price)! * (rates.transactionPercent)/100
        let transactionRatePrice = Double(price)! * (rates.transactionRate)/100
        let kitStopPrice = Double(price)! * (rates.kitStopFee)/100
        let userPrice = Double(price)! - transactionPrice - transactionRatePrice - kitStopPrice - resultRate
        let priceModel = PriceModel(weight: "Shipping UDSP \(stringRate):", weightRate: "$\(String(format: "%.2f", resultRate))" ,startingPrice: "$\(price.formattedDouble(decimalPlaces: 2))", transactionPrice: "$\(String(format: "%.2f", transactionPrice))", transactionRatePrice: "$\(String(format: "%.2f", transactionRatePrice))", kitStopPrice: "$\(String(format: "%.2f", kitStopPrice))", finalPrice: "$\(String(format: "%.2f", userPrice))")

        return priceModel
    }

    func removePost(section: Bool, idPost: String) {
        if section {
            dataManager.removeKitForSale(idKit: idPost) {
                [weak self] error in
                if error == nil {
                    self?.presenter.showSuccess(title: "Success", message: "The item has been deleted")
                } else {
                    let message = CustomError.init(code: error!).description
                    self?.presenter.showError(title: "Error", message: message)
                }
            }

        } else {
            dataManager.removeKit(idKit: idPost) {
                [weak self] error in
                if error == nil {
                    self?.presenter.showSuccess(title: "Success", message: "The item has been deleted")
                } else {
                    let message = CustomError.init(code: error!).description
                    self?.presenter.showError(title: "Error", message: message)
                }
            }
        }
    }

    func getPostAsKit(idPost: String) {
        dataManager.getAllKits(idKit: idPost, forSale: false) { [weak self] object, error in
            if error == nil {
                self?.presenter.setPostForChange(post: object)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
            }
        }
    }

    func getPostAsForSale(idPost: String) {
        dataManager.getAllKitsForSale(idKit: idPost, forSale: true) { [weak self] object, error in
            if error == nil {
                print(object)
                self?.presenter.setPostForChange(post: object)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
            }
        }
    }
    
    func calculateView(price: String, post: Post, rates: RatesModel) {
        
    }
    
}
