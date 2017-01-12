//
//  RestorePasswordViewInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - RestorePasswordViewInput

protocol RestorePasswordViewInput: class {
    func showAlert(message: String)
    func changeSubmitStatus(status: Bool)
    func dismissAfterAlert(message: String)
}
