//
//  MainFilterContainerViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerViewInput

protocol MainFilterContainerViewInput: class {
    func fetchKits()
    func showAlert(title: String, message: String)
    func passData(selectedItem: Int)
    func stopRefresh()
    func addLoadingIndicatorView()
    func removeLoadingIndicatorView()
    func stopInfiniteScroll(finishSuccess: Bool)
    func refreshKitsWithFilter()
}
