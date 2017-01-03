//
//  SignUpInteractor.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - SignUpInteractor
import FBSDKLoginKit
import KeychainAccess

final class SignUpInteractor {

    // MARK: - VIPER stack

    weak var presenter: SignUpInteractorOutput!

    // MARK: - Networking stack
    fileprivate let dataManager: FacebookServiceProtocol!
    
    init(dataManager: FacebookServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: FacebookService())
    }

}

// MARK: - SignUpInteractorInput

extension SignUpInteractor: SignUpInteractorInput {
    func signUpWithFacebook() {
        dataManager.authenticateUser(token: FBSDKAccessToken.current().tokenString!, completion: {
            result in
            if result {
                self.presenter.openMainModule()
            }
        })
    }
}
