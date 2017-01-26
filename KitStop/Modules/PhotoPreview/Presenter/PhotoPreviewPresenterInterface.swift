//
//  PhotoPreviewPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - PhotoPreviewViewOutput

protocol PhotoPreviewViewOutput: class {
    func closeModule()
}

// MARK: - PhotoPreviewInteractorOutput

protocol PhotoPreviewInteractorOutput: class {

}

// MARK: - PhotoPreviewModuleInput

protocol PhotoPreviewModuleInput: ModuleInput {
    func handleImages(images: UIImage, isEditMode: Bool)
}

// MARK: - PhotoPreviewModuleOutput

protocol PhotoPreviewModuleOutput: ModuleOutput {

}
