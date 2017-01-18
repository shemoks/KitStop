//
//  KitsDetailedPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitsDetailedViewOutput

protocol KitsDetailedViewOutput: class {
    func openModule(identifier: Int)
    func generalProperty(for indexPath: IndexPath)-> ViewProperty
    func additionalProperty(for indexPath: IndexPath)-> ViewProperty
    func saleProperty(for indexPath: IndexPath)-> ViewProperty
    func numberOfGeneralProperties(inSection section: Int) -> Int
    func numberOfAdditionalProperties(inSection section: Int) -> Int
    func numberOfSaleProperties(inSection section: Int) -> Int
    func handleViewDidLoad()
    func descriptions(for indexPath: IndexPath)-> ViewProperty
    func notes(for indexPath: IndexPath)-> ViewProperty
    func getTittle() -> String

}

// MARK: - KitsDetailedInteractorOutput

protocol KitsDetailedInteractorOutput: class {

    func setPost(post: ViewPost)
    func showError(title: String, message: String)

}

// MARK: - KitsDetailedModuleInput

protocol KitsDetailedModuleInput: ModuleInput {


}

// MARK: - KitsDetailedModuleOutput

protocol KitsDetailedModuleOutput: ModuleOutput {

}
