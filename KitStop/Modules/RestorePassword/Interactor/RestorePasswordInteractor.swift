//
//  RestorePasswordInteractor.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - RestorePasswordInteractor

final class RestorePasswordInteractor {

    // MARK: - VIPER stack

    weak var presenter: RestorePasswordInteractorOutput!

    // MARK: -
    
    fileprivate let dataManager: RestorePasswordServiceProtocol

    
    init(dataManager: RestorePasswordServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: RestorePasswordService())
    }
}

// MARK: - RestorePasswordInteractorInput

extension RestorePasswordInteractor: RestorePasswordInteractorInput {
    func restorePassword(email: String) {
        dataManager.requestPasswordRecovery(email: email, completion: { result, error in
            if result {
                self.presenter.showAlert(message: "Your password has been reset. Please check your email", shouldTransition: true)
            } else {
                self.presenter.showAlert(message: CustomError(code: error!).description, shouldTransition: false)
            }
        })
    }
}
