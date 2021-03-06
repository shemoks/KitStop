//
//  MainFilterContainerTransferDataProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 28.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol MainFilterContainerTransferDataProtocol {
    func stopRefresh()
    var page: Int {get set}
    func finishInfiniteScroll()
    func stopActivityIndicator()
    func startActivityIndicator()
}
