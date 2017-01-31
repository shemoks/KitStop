//
//  KitFolioDetailedPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import SDWebImage

// MARK: - KitFolioDetailedPresenter

final class KitFolioDetailedPresenter {
    
    // MARK: - VIPER stack
    
    weak var moduleOutput: ModuleOutput?
    weak var view: KitFolioDetailedViewInput!
    var interactor: KitFolioDetailedInteractorInput!
    var router: KitFolioDetailedRouterInput!
    
    fileprivate var id: String?
    fileprivate var ownerId: String?
    fileprivate var likeStatus = true
    var imageDeleteStatus = false
    fileprivate var picker: UIImagePickerController?
    var smallImage: UIImage?
    var bigImage: UIImage?
    var product: Product?
    var imageChange: Bool = false
    var mainOriginalImageUrl: String?
}

// MARK: - KitFolioDetailedViewOutput

extension KitFolioDetailedPresenter: KitFolioDetailedViewOutput {
    
    func checkXib(view: UIView?) {
        if view != nil {
            self.view.addXibOnView(view: view!)
        }
    }
    
    func handleKitData() {
        interactor.fetchKitFrom(id: self.id)
    }
    
    func addImageWithOrientation(imageView: UIImageView, imageUrl: String?, imageHeight: CGFloat, imageViewHeight: NSLayoutConstraint, bottomMask: UIImageView, topMask: UIImageView) {
        if imageUrl != nil && imageUrl != "" {
            let url = URL.init(string: imageUrl!)
            imageView.sd_setImage(with: url!, placeholderImage: UIImage(named: "placeholder1080x1080"), options: SDWebImageOptions.delayPlaceholder, completed: {
                completed in
                bottomMask.image = UIImage(named: "bottom_mask")
                topMask.image = UIImage(named: "top_mask")
            })
        } else {
            // whats happaned if image does return on server ???
        }
    }
    
    func checkUserInformation(xib: UIView, user: User) {
        if ownerId != nil && !checkUserInRealm(userId: self.ownerId!) {
            (xib as! UserInformationViewController).updateUser(user: user)
        }
    }
    
    func updateData(xib: UIView) -> Bool {
        if checkUserInRealm(userId: ownerId!) {
            (xib as! UserInformationViewController).updateUser(user: nil)
            return true
        }
        return false
    }
    
    func checkUserInRealm(userId: String) -> Bool {
        return User().checkUser(id: userId)
    }
    
    func openChat() {
        router.openChatModule()
    }
    
    func changeLike(like: UIButton) {
        if likeStatus {
            like.setImage(UIImage.init(named: "like_active"), for: .normal)
            likeStatus = false
        } else {
            like.setImage(UIImage.init(named: "like"), for: .normal)
            likeStatus = true
        }
    }
    
    func showActionSheet(image: UIImageView, picker: UIImagePickerController, bottomMask: UIImageView, topMask: UIImageView) {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        var addPhotoMessage = ""
        if !imageDeleteStatus {
            addPhotoMessage = "Replace Photo"
            let deletePhoto = UIAlertAction.init(title: "Delete Photo", style: .destructive, handler: {
                result in
                bottomMask.image = UIImage()
                topMask.image = UIImage()
                image.image = UIImage.init(named: "camera")
                self.imageDeleteStatus = true
            })
            alertController.addAction(deletePhoto)
        } else {
            addPhotoMessage = "Add Photo"
        }
        let replacePhoto = UIAlertAction.init(title: addPhotoMessage, style: .default, handler: {
            result in
            self.showAddPhotoActionSheet()
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        self.picker = picker
        
        alertController.addAction(replacePhoto)
        alertController.addAction(cancel)
        
        view.presentAlert(alert: alertController)
    }
    
    func showAddPhotoActionSheet() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction.init(title: "Take Photo", style: .default, handler: {
            result in
            print("take photo")
            self.openCamera()
        })
        let choosePhoto = UIAlertAction.init(title: "Choose Photo", style: .default, handler: {
            result in
            print("choose photo")
            self.openGallary()
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(takePhoto)
        alertController.addAction(choosePhoto)
        alertController.addAction(cancel)
        
        view.presentAlert(alert: alertController)
    }
    
    func openGallary() {
        if picker != nil {
            picker?.allowsEditing = true
            picker?.sourceType = .photoLibrary
            picker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker?.modalPresentationStyle = .popover
            view.presentPicker()
        }
    }
    
    func openCamera() {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            if picker != nil {
                picker?.allowsEditing = true
                picker?.sourceType = UIImagePickerControllerSourceType.camera
                picker?.cameraCaptureMode = .photo
                view.presentPicker()
            }
        } else {
            view.showAlert(title: "No Camera", message: "Sorry, this device has no camera")
        }
    }
    
    func cropImage(editedImage: UIImage?, originalImage: UIImage?) {
        self.smallImage = editedImage
        self.bigImage = originalImage?.RBResizeImage(targetSize: CGSize.init(width: 1080, height: (originalImage?.bigHeightSize())!), staticWidth: true)
        imageDeleteStatus = false
    }
    
    func deletePost() {
        interactor.delete(id: self.id!)
    }
    
    func addEditActionSheet() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let delete = UIAlertAction.init(title: "Delete post", style: .destructive, handler: {
            result in
            let yes = UIAlertAction.init(title: "Yes", style: .default, handler: {
                result in
                self.deletePost()
            })
            let no = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
            self.view.showSuccessAlert(title: "Delete", message: "Are you sure you want to delete this item?", action: [yes, no])
        })
        let edit = UIAlertAction.init(title: "Edit", style: .default, handler: {
            result in
            self.view.edit()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(edit)
        alertController.addAction(delete)
        alertController.addAction(cancel)
        
        view.presentAlert(alert: alertController)

    }
    
    func validation(data: [String : String], image: UIImage) {
        if data["title"] != product?.title || data["description"] != product?.description || imageChange || imageDeleteStatus {
            LoadingIndicatorView.show()
            if imageChange {
                interactor.save(images: [smallImage, bigImage], data: data, id: id!, mainImage: smallImage)
            } else {
                if imageDeleteStatus {
                    LoadingIndicatorView.hide()
                    view.showAlert(title: "Error", message: "Please add image")
                } else {
                    if let mainImage = product?.mainImage {
                        interactor.update(data: data, id: id!, mainImage: mainImage)
                    }
                }
            }
        } else {
            view.showAlert(title: "Error", message: "You must change your post before updating")
        }
    }
}

// MARK: - KitFolioDetailedInteractorOutput

extension KitFolioDetailedPresenter: KitFolioDetailedInteractorOutput {
    func updateProductData(product: Product, user: User?) {
        self.product = product
        view.updateProduct(product: product, user: user)
    }
    
    func showErrorAlert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
    
    func showSuccessAlert(title: String, message: String) {
        view.showSuccessAlert(title: title, message: message, action: [UIAlertAction.init(title: "Ok", style: .default, handler: {
            result in
            let moduleOutput = self.moduleOutput as! KitFolioDetailedModuleOutput
            self.router.closeModule(moduleOutput: moduleOutput)
        })])
    }
    
    func updateProduct(product: Product) {
        self.product = product
        let ok = UIAlertAction.init(title: "Ok", style: .default, handler: {
            result in
            self.view.refreshDataAfterUpdate()
        })
        view.showSuccessAlert(title: "Success", message: "Post is successfully updated", action: [ok])
    }
}

// MARK: - KitFolioDetailedModuleInput

extension KitFolioDetailedPresenter: KitFolioDetailedModuleInput {
    func handleKitId(id: String, ownerId: String) {
        self.id = id
        self.ownerId = ownerId
    }
}

