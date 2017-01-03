//
//  RestorePasswordInteractorInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - RestorePasswordInteractorInput

protocol RestorePasswordInteractorInput: class {
    func restorePassword(email: String)
}
