//
//  KitsDetailedRouterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitsDetailedRouterInput
import UIKit

protocol KitsDetailedRouterInput: class {
    
    func openModule(identifier: Int)
    func openChatModule()
    func closeModule(section: Bool)
    func openEditForSale(post: Post, oldModel: String, returnCase: ReturnCase)
    func openEditKit(post: Post, oldModel: String, returnCase: ReturnCase)

}
