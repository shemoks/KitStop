//
//  CustomInputPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputViewOutput

protocol CustomInputViewOutput: class {

    func inputData(for: IndexPath) -> Other
    func getTitle() -> String
    func handleViewDidLoad()
    func returnOther(dataText: String)
    func getText() -> String

}

// MARK: - CustomInputInteractorOutput

protocol CustomInputInteractorOutput: class {

}

// MARK: - CustomInputModuleInput

protocol CustomInputModuleInput: ModuleInput {

    func setInput(data: Other)

}

// MARK: - CustomInputModuleOutput

protocol CustomInputModuleOutput: ModuleOutput {
    
    func setOther(data: Other)

}
