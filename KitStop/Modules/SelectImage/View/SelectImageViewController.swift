//
//  SelectImageViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectImageViewController

final class SelectImageViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    var presenter: SelectImageViewOutput!
    let imagePicker = UIImagePickerController()
    var delegate: SelectImageContainerProtocol?

    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var gallery: UIButton!
    
    override func viewDidLoad() {
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
    }
    
    
    @IBAction func takePhotoTap(_ sender: Any) {
        presenter.openCamera()
    }
    
    @IBAction func choosePhotoTap(_ sender: Any) {
        
        presenter.openGallary()
    }
    
}

// MARK: - SelectImageViewInput

extension SelectImageViewController: SelectImageViewInput {
    
    func openGallary() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
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
            showAlertWithTitle("No Camera", message: "Sorry, this device has no camera")
        }
    }
    
    func removeButton(button: UIButton) {
        button.removeFromSuperview()
    }
}

extension SelectImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let image = presenter.cropImage(image: pickedImage, buttons: [camera, gallery], delegate: delegate!)
            let newHeight = pickedImage.heightWithOrientation(contentHeight: self.view.frame.size.height)
            delegate?.changeContainer(newHeight)
            image.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: newHeight)
            self.view.addSubview(image)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
