//
//  KitsDetailedViewInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitsDetailedViewInput

import Chamomile

protocol KitsDetailedViewInput: class {
    
    func reloadData()
    func showError(title: String, message: String)
    func reloadHeader(url: URL, userInfo: User, dateUpdate: String)
    func showSuccessAlert(title: String, message: String, action: [UIAlertAction])
    func isVisibleTableView(flag: Bool)
    func update()

}
