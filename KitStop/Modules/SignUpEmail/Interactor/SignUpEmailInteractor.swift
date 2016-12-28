//
//  SignUpEmailInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - SignUpEmailInteractor

final class SignUpEmailInteractor {

    // MARK: - VIPER stack

    weak var presenter: SignUpEmailInteractorOutput!

    fileprivate let dataManager: SignUpServiceProtocol
    // MARK: -
    
    init(dataManager: SignUpServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: SignUpService())
    }


}

// MARK: - SignUpEmailInteractorInput

extension SignUpEmailInteractor: SignUpEmailInteractorInput {
    func addUser(user: SignUpUserModel) {
        dataManager.addNewUser(email: user.email, password: user.password, photoUrl: user.photoUrl, completionBlock: {
            result in
            if result {
                self.presenter.openMainModule()
            }
        })
    }
}
