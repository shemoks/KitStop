//
//  CreateSaleConfirmInteractorInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateSaleConfirmInteractorInput

protocol CreateSaleConfirmInteractorInput: class {
    func saveForSaleKit(price: String?, condition: String?, weight: String?, isPrivate:Bool, post:Post)
}
