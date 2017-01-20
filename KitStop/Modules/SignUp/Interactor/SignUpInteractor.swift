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
import SwiftyJSON

final class SignUpInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: SignUpInteractorOutput!
    
    // MARK: - Networking stack
    fileprivate let dataManager: FacebookServiceProtocol!
    fileprivate let manager: LogInDataManagerProtocol
    
    init(dataManager: FacebookServiceProtocol, manager: LogInDataManagerProtocol) {
        self.dataManager = dataManager
        self.manager = manager
    }
    
    convenience init() {
        self.init(dataManager: FacebookService(), manager: LogInDataManager())
    }
    
}

// MARK: - SignUpInteractorInput

extension SignUpInteractor: SignUpInteractorInput {
    func signUpWithFacebook() {
        dataManager.authenticateUser(token: FBSDKAccessToken.current().tokenString!, completion: {
            [weak self] result, json in
            if result {
                if json != nil {
                    self?.manager.saveUserData(json: json!)
                }
                self?.presenter.openMainModule()
            }
        })
    }
    
    func userIsLoggedInWithFacebook() -> Bool {
        if FBSDKAccessToken.current() != nil {
            return true
        } else {
            return false
        }
    }
}
