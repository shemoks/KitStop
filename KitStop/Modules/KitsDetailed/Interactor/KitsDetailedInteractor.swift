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
    // MARK: -



    init(dataManager: ViewPostServiceProtocol) {
        self.dataManager = dataManager
    }

    convenience init() {
        self.init(dataManager: ViewPostService())
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
            dataManager.getAllKitsForSale(idKit: idPost, forSale: forSale) { [weak self] object, error in
                if error == nil {
                    print(object)
                    self?.presenter.setPost(post: object)
                } else {
                    let error = CustomError(code: error!).description
                    self?.presenter.showError(title: "Error", message: error)
                }
            }

        }
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

}
