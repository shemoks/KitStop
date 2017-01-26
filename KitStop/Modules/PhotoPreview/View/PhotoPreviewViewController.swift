//
//  PhotoPreviewViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - PhotoPreviewViewController

final class PhotoPreviewViewController: UIViewController, FlowController {
    
    // MARK: - VIPER stack
    
    var presenter: PhotoPreviewViewOutput!
    fileprivate var image: UIImage?
    fileprivate var isEditMode: Bool = false
    
    override func viewDidLoad() {
        let gallery = SwiftPhotoGallery.init(delegate: self, dataSource: self, trashButtonStatus: isEditMode)
        
        gallery.backgroundColor = .black
        gallery.currentPageIndicatorTintColor = .white
        
        if isEditMode {
            gallery.hidePageControl = false
        } else {
            gallery.hidePageControl = true
        }
        
        present(gallery, animated: false, completion: nil)
    }
    
    func handleImage(image: UIImage, isEditMode: Bool) {
        self.image = image
        self.isEditMode = isEditMode
    }
}

// MARK: - PhotoPreviewViewInput

extension PhotoPreviewViewController: PhotoPreviewViewInput {
    
}

extension PhotoPreviewViewController: SwiftPhotoGalleryDataSource {
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return 1
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return image
    }
}

extension PhotoPreviewViewController: SwiftPhotoGalleryDelegate {
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: false, completion: nil)
        if let navController = self.navigationController {
            for controller in navController.viewControllers as Array {
                if controller.isKind(of: KitFolioDetailedViewController.self) {
                    let _ = self.navigationController?.popToViewController(controller as! KitFolioDetailedViewController, animated: false)
                    break
                }
            }
        }
    }
}

