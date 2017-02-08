//
//  KitsDetailedInteractorInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitsDetailedInteractorInput

protocol KitsDetailedInteractorInput: class {

    func getPost(forSale: Bool, idPost: String)
    func removePost(section: Bool, idPost: String)
    func getPostAsForSale(idPost: String)
    func getPostAsKit(idPost: String)
    
}
