//
//  MainFilterContainerInteractorInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerInteractorInput
import UIKit

protocol MainFilterContainerInteractorInput: class {
    func fetchKitsForCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton)
}
