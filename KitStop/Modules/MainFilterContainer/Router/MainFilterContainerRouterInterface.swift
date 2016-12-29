//
//  MainFilterContainerRouterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerRouterInput

protocol MainFilterContainerRouterInput: class {
 //   func openSecondModule(secondModuleOutput: 'Second Module')
    func openFilterModule(selectedIndex: Int ,filterModuleOutput: FiltersModuleOutput)
}
