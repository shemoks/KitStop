//
//  CreateSaleConfirmViewInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateSaleConfirmViewInput

protocol CreateSaleConfirmViewInput: class {
    func showAlert(title: String, message: String)
    func returnToMainModule()
    func reloadData()
    func setPriceLabels(priceModel: PriceModel)
    func setTitle(category: String) 
}
