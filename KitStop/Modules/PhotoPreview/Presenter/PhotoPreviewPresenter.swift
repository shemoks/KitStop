//
//  PhotoPreviewPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - PhotoPreviewPresenter

final class PhotoPreviewPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: PhotoPreviewViewInput!
    var interactor: PhotoPreviewInteractorInput!
    var router: PhotoPreviewRouterInput!

}

// MARK: - PhotoPreviewViewOutput

extension PhotoPreviewPresenter: PhotoPreviewViewOutput {

}

// MARK: - PhotoPreviewInteractorOutput

extension PhotoPreviewPresenter: PhotoPreviewInteractorOutput {

}

// MARK: - PhotoPreviewModuleInput

extension PhotoPreviewPresenter: PhotoPreviewModuleInput {

}
