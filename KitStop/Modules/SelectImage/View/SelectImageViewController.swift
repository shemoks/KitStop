//
//  SelectImageViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import MobileCoreServices

// MARK: - SelectImageViewController

final class SelectImageViewController: UIViewController, FlowController, Alertable {
    
    // MARK: - VIPER stack
    
    var presenter: SelectImageViewOutput!
    let imagePicker = UIImagePickerController()
    var delegate: SelectImageContainerProtocol?
    
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var gallery: UIButton!
    
    var flag = false
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
            showAlertWithTitle("No Camera", message: "Sorry, this device has no camera")
        }
    }
    
    func removeButton(button: UIButton) {
        button.removeFromSuperview()
    }
    
    func replaceImage() {
        presenter.showActionSheet()
    }
    
    func presentActionSheet(actionSheet: UIAlertController) {
        present(actionSheet, animated: true, completion: nil)
        actionSheet.view.tintColor = UIColor.gray
    }
}

extension SelectImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        if abs((editedImage?.size.width)! - (editedImage?.size.height)!) > 50 {
           editedImage = UIImage().RBSquareImageTo(image: editedImage!, size: CGSize(width: 500, height: 500))
        }
        var image = UIImageView()
        if flag {
             image = presenter.cropImage(image: [editedImage!, originalImage!], buttons: nil, delegate: delegate!)
        } else {
            image = presenter.cropImage(image: [editedImage!, originalImage!], buttons: [camera, gallery], delegate: delegate!)
            flag = true
        }
        delegate?.changeContainer(self.view.frame.size.width)
        image.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.replaceImage))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTap)
        self.view.addSubview(image)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

