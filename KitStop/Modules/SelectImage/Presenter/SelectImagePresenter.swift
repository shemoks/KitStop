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
    
    func cropImage(image: [UIImage], buttons: [UIButton]?, delegate: SelectImageContainerProtocol?) -> UIImageView{
        self.smallImage = image[0]
        self.bigImage = image[1].RBResizeImage(targetSize: CGSize.init(width: 1080, height: image[1].bigHeightSize()), staticWidth: true)
        delegate?.passImage(small: self.smallImage!, big: self.bigImage!)
        if let buttonArray = buttons {
            for button in buttonArray {
                view.removeButton(button: button)
            }
        }
        let imageView = UIImageView.init(image: self.bigImage)
        return imageView
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "", message: "Replace image", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Choose from camera", style: .default, handler: {
            res in
            self.view.openCamera()
        })
        let gallery = UIAlertAction(title: "Choose from gallary", style: .default, handler: {
            res in
            self.view.openGallary()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            cancel in
        })
        actionSheet.addAction(camera)
        actionSheet.addAction(gallery)
        actionSheet.addAction(cancel)
        view.presentActionSheet(actionSheet: actionSheet)
    }
}

// MARK: - SelectImageInteractorOutput

extension SelectImagePresenter: SelectImageInteractorOutput {
    
}

// MARK: - SelectImageModuleInput

extension SelectImagePresenter: SelectImageModuleInput {
    
}
