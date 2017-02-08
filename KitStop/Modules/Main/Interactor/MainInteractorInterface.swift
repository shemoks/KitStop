//
//  MainInteractorInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainInteractorInput
import UIKit

protocol MainInteractorInput: class {
    func handleKitsForSale(page: Int)
    func removeAllFromRealm()
}
