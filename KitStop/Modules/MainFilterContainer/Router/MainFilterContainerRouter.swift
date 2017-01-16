//
//  MainFilterContainerRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform

// MARK: - MainFilterContainerRouter

final class MainFilterContainerRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - MainFilterContainerRouterInput

extension MainFilterContainerRouter: MainFilterContainerRouterInput {
    
    func openFilterModule(selectedIndex: Int ,filterModuleOutput: FiltersModuleOutput) {
        flowController.openModule(using: .openFilterModule) {
            guard let moduleInput = $0 as? FiltersModuleInput else { fatalError() }
            if selectedIndex == 0 {
                moduleInput.priceVisible(visible: false)
            } else {
                moduleInput.priceVisible(visible: true)
            }
            return filterModuleOutput
        }
    }
    
    func openMainSearchModule(selectedSegment: Int) {
        flowController.openModule(using: .openMainSearch) {
            guard let moduleInput = $0 as? MainSearchModuleInput else { fatalError() }
            moduleInput.setSegment(selectedSegment: selectedSegment)
            return nil
        }
    }
}

extension Segue {
    
    static var openFilterModule: Segue<FiltersViewController> {
        return .init(identifier: "transitionToFilter")
    }
    
    static var openMainSearch: Segue<MainSearchViewController> {
        return .init(identifier: "transitionToMainSearch")
    }
}
