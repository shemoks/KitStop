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
        self.smallImage = image[0].RBResizeImage(targetSize: CGSize(width: 500, height: 500), staticWidth: false)
        self.bigImage = image[1].RBResizeImage(targetSize: CGSize.init(width: 1080, height: image[1].bigHeightSize()), staticWidth: true)
        delegate?.passImage(small: self.smallImage!, big: self.bigImage!)
        for button in buttons {
            view.removeButton(button: button)
        }
        let imageView = UIImageView.init(image: self.bigImage)
        return imageView
    }
}

// MARK: - SelectImageInteractorOutput

extension SelectImagePresenter: SelectImageInteractorOutput {
    
}

// MARK: - SelectImageModuleInput

extension SelectImagePresenter: SelectImageModuleInput {
    
}
