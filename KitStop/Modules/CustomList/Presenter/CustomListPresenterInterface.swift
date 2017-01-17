//
//  CustomListPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomListViewOutput

protocol CustomListViewOutput: class {
    
    func numberOfElements() -> Int
    func elementList(for indexPath: IndexPath) -> String
    func handleCellTap(for indexPath: IndexPath)

}

// MARK: - CustomListInteractorOutput

protocol CustomListInteractorOutput: class {

}

// MARK: - CustomListModuleInput

protocol CustomListModuleInput: ModuleInput {

    func setElements(list: [Other])

}

// MARK: - CustomListModuleOutput

protocol CustomListModuleOutput: ModuleOutput {

    func getData(data: Other)
    func getDataWithInput(data: Other)

}
