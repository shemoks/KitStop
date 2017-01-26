//
//  CreateSaleConfirmRouterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateSaleConfirmRouterInput

protocol CreateSaleConfirmRouterInput: class {
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput, name: String)

}
