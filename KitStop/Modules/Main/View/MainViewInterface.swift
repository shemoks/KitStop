//
//  MainViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainViewInput
import UIKit

protocol MainViewInput: class {
    func presentAlert(alertController: UIAlertController)
    func passDataToSubmodule()
    func showAlert(title: String, message: String)
    func addLoadingIndicatorView()
    func removeLoadingIndicatorView()
    var page: Int {get set}
    func finishInfiniteScroll()
}
