//
//  UnderConstructionPresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UnderConstructionViewOutput

protocol UnderConstructionViewOutput: class {
    func logOut()
}

// MARK: - UnderConstructionInteractorOutput

protocol UnderConstructionInteractorOutput: class {

}

// MARK: - UnderConstructionModuleInput

protocol UnderConstructionModuleInput: ModuleInput {
    func addLogOut()
}

// MARK: - UnderConstructionModuleOutput

protocol UnderConstructionModuleOutput: ModuleOutput {

}
