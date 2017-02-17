//
//  SelectCategoryRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - SelectCategoryRouter

final class SelectCategoryRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - SelectCategoryRouterInput

extension SelectCategoryRouter: SelectCategoryRouterInput {

    func openAddKitModule(categoryID: String, category: Bool, returnCase: ReturnCase) {
        flowController.openModule(using: .openAddKitModule) {
            guard let moduleInput = $0 as? CreatePostModuleInput else { fatalError() }
            moduleInput.valuesFromCategoryList(forSale: category, idCategory: categoryID)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }

    func openMainModule() {
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            return nil
        }
    }

}

extension Segue {

        static var openAddKitModule: Segue<CreatePostViewController> {
            return .init(identifier: "transitionToAddKitModule")
        }

}
