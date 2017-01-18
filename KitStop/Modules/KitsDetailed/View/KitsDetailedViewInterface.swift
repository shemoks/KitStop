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
    func reloadHeader(url: URL)

}
