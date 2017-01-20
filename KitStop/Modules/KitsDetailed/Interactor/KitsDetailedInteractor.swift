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
        dataManager.getKit(idKit: idPost, forSale: false) { [weak self] object, error in
            if error == nil {
                self?.presenter.setPost(post: object)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
            }
        }
        } else {
            dataManager.getKitForSale(idKit: idPost, forSale: forSale) { [weak self] object, error in
                if error == nil {
                    self?.presenter.setPost(post: object)
                } else {
                    let error = CustomError(code: error!).description
                    self?.presenter.showError(title: "Error", message: error)
                }
            }
            
        }
    }

}
