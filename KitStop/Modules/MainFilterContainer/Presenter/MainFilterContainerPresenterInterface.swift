//
//  MainFilterContainerPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerViewOutput

protocol MainFilterContainerViewOutput: class {
    func openFilterModule(selectedIndex: Int)
    func openSearchModule(selectedSegment: Int)
    func handleKitsForCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton)
    func openKitFolioDetailedModule(kitId: String, ownerId: String)
    func openKitsModule(segmentedIndex: Bool ,kitId: String, ownerId: String)
    func changeCollectionViewStatus(index: Int)
}

// MARK: - MainFilterContainerInteractorOutput

protocol MainFilterContainerInteractorOutput: class {
    func showAlert(title: String, message: String)
    func stopRefresh()
    func addLoadingIndicatorView()
    func removeLoadingIndicatorView()
    func stopInfiniteScroll(finishSuccess: Bool)
}

// MARK: - MainFilterContainerModuleInput

protocol MainFilterContainerModuleInput: ModuleInput {

}

// MARK: - MainFilterContainerModuleOutput

protocol MainFilterContainerModuleOutput: ModuleOutput {
    
}
