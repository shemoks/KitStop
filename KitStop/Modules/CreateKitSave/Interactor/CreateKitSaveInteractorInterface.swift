//
//  CreateKitSaveInteractorInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateKitSaveInteractorInput

protocol CreateKitSaveInteractorInput: class {
    func saveKit(kit: CreateKitsRequestBody)    
}
