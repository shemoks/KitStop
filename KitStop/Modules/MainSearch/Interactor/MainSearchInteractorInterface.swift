//
//  MainSearchInteractorInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - MainSearchInteractorInput

protocol MainSearchInteractorInput: class {
    func commenceSearch(with title: String, selectedSegment: Int)
}
