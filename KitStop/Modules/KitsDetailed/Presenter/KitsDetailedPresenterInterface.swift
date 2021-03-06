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
    func generalProperty(for indexPath: IndexPath)-> Property
    func additionalProperty(for indexPath: IndexPath)-> Property
    func saleProperty(for indexPath: IndexPath)-> Property
    func numberOfGeneralProperties(inSection section: Int) -> Int
    func numberOfAdditionalProperties(inSection section: Int) -> Int
    func numberOfSaleProperties(inSection section: Int) -> Int
    func handleViewDidLoad(result: @escaping () -> ())
    func descriptions(for indexPath: IndexPath)-> Property
    func notes(for indexPath: IndexPath)-> Property
    func getTittle() -> String
    func updateData(xib: UIView) -> Bool
    func openChat()
    func numberOfSections() -> Int
    func getPrice() -> String
    func getSection() -> Bool
    func getImages() -> [String]
    func changeLike(like: UIButton)
    func isPrivatePost() -> Bool
    func removePost()
    func openEditForSale()
    func openEditKit()
    func handleKit()
    func handleKitForSale()
    func imageFromUrl() -> [URL]
    func getPost() -> PriceModel?
    func update()
    func beginView()
    func changeStatus()
    
}

// MARK: - KitsDetailedInteractorOutput

protocol KitsDetailedInteractorOutput: class {

    func setPost(post: Post)
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
    func setPostForChange(post: Post, oldModel: String)

}

// MARK: - KitsDetailedModuleInput

protocol KitsDetailedModuleInput: ModuleInput {

    func dataForView(forSale: Bool, idPost: String, idOwner: String?)
    func flagFromSearch(search: Bool)
    func returnCase(caseOf: ReturnCase)

}

// MARK: - KitsDetailedModuleOutput

protocol KitsDetailedModuleOutput: ModuleOutput {

   func updateKits()
   func updateKitForSale()

}
