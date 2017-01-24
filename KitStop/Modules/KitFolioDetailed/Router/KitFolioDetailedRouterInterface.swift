//
//  KitFolioDetailedRouterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioDetailedRouterInput

protocol KitFolioDetailedRouterInput: class {
    func openChatModule()
    func closeModule(moduleOutput: KitFolioDetailedModuleOutput)
}
