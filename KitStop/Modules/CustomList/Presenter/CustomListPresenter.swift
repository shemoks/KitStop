//
//  CustomListPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomListPresenter

final class CustomListPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CustomListViewInput!
    var interactor: CustomListInteractorInput!
    var router: CustomListRouterInput!
    var list = [Other]()

}

// MARK: - CustomListViewOutput

extension CustomListPresenter: CustomListViewOutput {

    func numberOfElements() -> Int {
        return self.list.count
    }

    func elementList(for indexPath: IndexPath) -> String {
        return self.list[indexPath.row].name
    }

    func handleCellTap(for indexPath: IndexPath) {
        if indexPath.row == self.numberOfElements() - 1 {
//            router.openCustomInputModule(data: self.list.last)
        } else {
            let customListModuleOutput = moduleOutput as! CustomListModuleOutput
            customListModuleOutput.getData(data: self.list[indexPath.row])
            router.closeModule()
        }
    }

}

// MARK: - CustomListInteractorOutput

extension CustomListPresenter: CustomListInteractorOutput {

}

// MARK: - CustomListModuleInput

extension CustomListPresenter: CustomListModuleInput {
    func setElements(list: [Other]) {
        self.list = list
    }

}
