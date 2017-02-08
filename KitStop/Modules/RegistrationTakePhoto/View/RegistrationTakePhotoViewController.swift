//
//  RegistrationTakePhotoViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import MobileCoreServices

// MARK: - RegistrationTakePhotoViewController

final class RegistrationTakePhotoViewController: UIViewController, FlowController, UINavigationControllerDelegate {

    // MARK: - VIPER stack
    let imagePicker = UIImagePickerController()
    var presenter: RegistrationTakePhotoViewOutput!

    @IBAction func takePhotoTap(_ sender: AnyObject) {
        presenter.openCamera()
    }

    @IBAction func choosePhotoTap(_ sender: AnyObject) {
        presenter.openGallery()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
    }

}

// MARK: - RegistrationTakePhotoViewInput

extension RegistrationTakePhotoViewController: RegistrationTakePhotoViewInput {

    func openGallery() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }

    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,
                animated: true,
                completion: nil)
    }
}

extension RegistrationTakePhotoViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
            originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
            if ( editedImage != nil ) {
                imageToSave = editedImage
            } else {
                imageToSave = originalImage
            }
            presenter.returnPhoto(photo: imageToSave!)
 }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
