//
//  RootInteractor.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - RootInteractor

final class RootInteractor {

    // MARK: - VIPER stack

    weak var presenter: RootInteractorOutput!

    // MARK: -

}

// MARK: - RootInteractorInput

extension RootInteractor: RootInteractorInput {

    func verifyAutorization() {
        print(KeychainService().tokenExists())
        if !KeychainService().tokenExists() {
            presenter.changeModuleSignUp()
        } else {
            presenter.changeModuleMain()
        }
    }
    
}
