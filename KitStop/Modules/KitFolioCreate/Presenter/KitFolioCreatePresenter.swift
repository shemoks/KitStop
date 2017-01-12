//
//  KitFolioCreatePresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreatePresenter

final class KitFolioCreatePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: KitFolioCreateViewInput!
    var interactor: KitFolioCreateInteractorInput!
    var router: KitFolioCreateRouterInput!

}

// MARK: - KitFolioCreateViewOutput

extension KitFolioCreatePresenter: KitFolioCreateViewOutput {
    func checkXib(view: UIView?) {
        if view != nil {
            self.view.addXibOnView(view: view!)
        }
    }
    
    func saveKitFolio(postTitle: String, postDescription: String, smallImage: UIImage?, bigImage: UIImage?) {
        if postTitle != "" && smallImage != nil && bigImage != nil {
            LoadingIndicatorView.show()
            interactor.save(postTitle: postTitle, postDescription: postDescription, smallImage: smallImage, bigImage: bigImage)
        } else {
            view.showAlert(title: "Error", message: "Please fill all the fields")
        }
    }
}

// MARK: - KitFolioCreateInteractorOutput

extension KitFolioCreatePresenter: KitFolioCreateInteractorOutput {
    func showAlertWith(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
    
    func handleViewWillDisappear() {
        let alertAction = UIAlertAction.init(title: "OK", style: .default, handler: {
            _ in
            let mainModuleOutput = self.moduleOutput as! MainModuleOutput
            self.router.returnToMainModule(moduleOutput: mainModuleOutput)
        })
        view.showAlert(title: "Success", message: "Your post was successfully added", action: [alertAction])
    }
}

// MARK: - KitFolioCreateModuleInput

extension KitFolioCreatePresenter: KitFolioCreateModuleInput {
    
}
