//
//  RootPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RootViewOutput

protocol RootViewOutput: class {
    func handleViewDidload()
}

// MARK: - RootInteractorOutput

protocol RootInteractorOutput: class {
    func changeModuleSignUp()
    func changeModuleMain()
}

// MARK: - RootModuleInput

protocol RootModuleInput: ModuleInput {

}

// MARK: - RootModuleOutput

protocol RootModuleOutput: ModuleOutput {

}
