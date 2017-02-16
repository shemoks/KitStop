//
//  MainRouterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainRouterInput

protocol MainRouterInput: class {
    func openCategoryModule(secondModuleOutput: SelectCategoryModuleOutput, category: Bool, returnCase: ReturnCase)
    func openKitFolioCreateModule(secondModuleOutput: KitFolioCreateModuleOutput, returnCase: ReturnCase)
    func openModule(identifier: Int)
}
