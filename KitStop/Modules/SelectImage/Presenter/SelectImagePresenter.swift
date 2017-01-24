//
//  SelectImagePresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectImagePresenter

final class SelectImagePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: SelectImageViewInput!
    var interactor: SelectImageInteractorInput!
    var router: SelectImageRouterInput!
    
    fileprivate var smallImage: UIImage?
    fileprivate var bigImage: UIImage?

}

// MARK: - SelectImageViewOutput

extension SelectImagePresenter: SelectImageViewOutput {
    func openCamera() {
        view.openCamera()
    }
    
    func openGallary() {
        view.openGallary()
    }
    
    func cropImage(image: [UIImage], buttons: [UIButton], delegate: SelectImageContainerProtocol?) -> UIImageView{
        self.smallImage = image[0].cropToSmall()
        self.bigImage = image[1].cropToBig()
        delegate?.passImage(small: self.smallImage!, big: self.bigImage!)
        for button in buttons {
            view.removeButton(button: button)
        }
        let imageView = UIImageView.init(image: image[1])
        imageView.contentMode = .scaleToFill
        return imageView
    }
}

// MARK: - SelectImageInteractorOutput

extension SelectImagePresenter: SelectImageInteractorOutput {
    
}

// MARK: - SelectImageModuleInput

extension SelectImagePresenter: SelectImageModuleInput {

}
