//
//  MainFilterContainerTransferDataProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 28.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol MainFilterContainerTransferDataProtocol {
    func kitItems(transferData: [Product])
    func stopRefresh()
    func clearKitsPage()
    var page: Int {get}
}
