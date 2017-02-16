//
//  MainSearchRouterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - MainSearchRouterInput

protocol MainSearchRouterInput: class {
    func closeModule()
    func openDetailedView(postID: String, ownerID: String, selectedSegment: Int, moduleOutput: KitsDetailedModuleOutput, returnCase: ReturnCase)
}
