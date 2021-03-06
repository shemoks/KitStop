//
//  SignUpEmailRouterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - SignUpEmailRouterInput

protocol SignUpEmailRouterInput: class {

    func openModuleTakePhoto(RegistrationTakePhotoModuleOutput: RegistrationTakePhotoModuleOutput)
    func openMainModule()
}
