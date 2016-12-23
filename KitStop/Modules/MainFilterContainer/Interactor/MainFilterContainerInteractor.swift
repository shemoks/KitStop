//
//  MainFilterContainerInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerInteractor

final class MainFilterContainerInteractor {

    // MARK: - VIPER stack

    weak var presenter: MainFilterContainerInteractorOutput!

    // MARK: -

}

// MARK: - MainFilterContainerInteractorInput

extension MainFilterContainerInteractor: MainFilterContainerInteractorInput {

    func fetchKitsForCategory(category: Int) {
        //api call
        print(pathFromCategory(category: category))
    }
    
    func pathFromCategory(category: Int) -> String {
        switch category {
        case 0:
            return "kits-for-sale"
        case 1:
            return "kits"
        case 2:
            return "kit-folio"
        default:
            return "error"
        }
    }
}
