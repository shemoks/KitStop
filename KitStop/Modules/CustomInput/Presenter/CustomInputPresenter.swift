//
//  CustomInputPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputPresenter

final class CustomInputPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CustomInputViewInput!
    var interactor: CustomInputInteractorInput!
    var router: CustomInputRouterInput!
    var data: Other?

}

// MARK: - CustomInputViewOutput

extension CustomInputPresenter: CustomInputViewOutput {

    func inputData(for indexPath: IndexPath) -> Other {

      return self.data!

    }

    func getTitle() -> String {
        return (self.data?.title)!
    }

    func handleViewDidLoad() {
        view.reloadData()
    }

    func returnOther(dataText: String) {
         let customInputModuleOutput = moduleOutput as! CustomInputModuleOutput
        print(self.data?.data)
        router.closeModule(data: self.data!, moduleOutput: customInputModuleOutput)
    }

    func getText() -> String {
        return (data?.data)!
    }

}

// MARK: - CustomInputInteractorOutput

extension CustomInputPresenter: CustomInputInteractorOutput {

}

// MARK: - CustomInputModuleInput

extension CustomInputPresenter: CustomInputModuleInput {

    func setInput(data: Other) {
        self.data = data
    }

}

