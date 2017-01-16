//
//  RestorePasswordPresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RestorePasswordViewOutput

protocol RestorePasswordViewOutput: class {
    func handleSubmitTap(email: String)
    func handleEditing(isEmpty: Bool)
    func dismissModule()
}

// MARK: - RestorePasswordInteractorOutput

protocol RestorePasswordInteractorOutput: class {
    func showAlert(message: String, shouldTransition: Bool)
}

// MARK: - RestorePasswordModuleInput

protocol RestorePasswordModuleInput: ModuleInput {

}

// MARK: - RestorePasswordModuleOutput

protocol RestorePasswordModuleOutput: ModuleOutput {

}
