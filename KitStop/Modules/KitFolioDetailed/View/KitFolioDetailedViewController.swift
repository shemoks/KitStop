//
//  KitFolioDetailedViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioDetailedViewController


final class KitFolioDetailedViewController: UIViewController, FlowController, Alertable {
    
    // MARK: - VIPER stack
    
    var presenter: KitFolioDetailedViewOutput!
    
    @IBOutlet weak var post: UITextView!
    @IBOutlet weak var information: UITextView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var postTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var postTitle: UITextView!
 //   @IBOutlet weak var postDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userInformation: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    
    fileprivate var userInformationXib: UIView?
    fileprivate var toolBar: UIView?
    fileprivate let imagePicker = UIImagePickerController()
    fileprivate var viewRec: UITapGestureRecognizer?
    fileprivate var showImage: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        presenter.checkXib(view: UIView.loadFromNibNamed(nibNamed: "UserInformation"))
        presenter.handleKitData()
        addTextViewInset()
        postTitle.delegate = self
        
        self.navigationItem.rightBarButtonItem = presenter.updateData(xib: userInformationXib!) ?          UIBarButtonItem.init(image: UIImage.init(named: "edit_icon"), style: .done, target: self, action: #selector(editKitFolio)) : UIBarButtonItem.init(image: UIImage.init(named: "Conv"), style: .done, target: self, action: #selector(openChatModule))
        // add image picker
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
        
        viewRec = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        showImage = UITapGestureRecognizer(target: self, action: #selector(showFullScreenImages))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(showImage!)
    }
    
    @objc func openChatModule() {
        presenter.openChat()
    }
    
    @objc func editKitFolio() {
        presenter.addEditActionSheet()
    }
    
    func edit() {
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        viewRec?.numberOfTapsRequired = 1
        viewRec?.numberOfTouchesRequired = 1
        postTitle.isEditable = true
        postDescription.isEditable = true
        image.removeGestureRecognizer(showImage!)
        image.addGestureRecognizer(viewRec!)
    }
    
    func addTextViewInset() {
        postTitle.textContainerInset = UIEdgeInsetsMake(0, 8, 4, 0)
        postDescription.textContainerInset = UIEdgeInsetsMake(0, 8, 4, 0)
        information.textContainerInset = UIEdgeInsetsMake(0, 8, 4, 0)
        post.textContainerInset = UIEdgeInsetsMake(0, 8, 4, 0)
    }
    
    func save() {
        // save changes
        let data: [String : String] = ["title" : postTitle.text, "description" : postDescription.text]
        if let image = image.image {
            presenter.validation(data: data, image: image)
        } else {
            showAlertWithTitle("Error", message: "Image not set")
        }
    }
    
    func refreshDataAfterUpdate() {
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem.init(image: UIImage.init(named: "edit_icon"), style: .done, target: self, action: #selector(editKitFolio))
        self.navigationItem.leftBarButtonItem = nil
        postTitle.isEditable = false
        postDescription.isEditable = false
        image.removeGestureRecognizer(viewRec!)
        image.addGestureRecognizer(showImage!)
        presenter.imageChange = false
        presenter.imageDeleteStatus = false
        if presenter.product != nil {
            updateData(product: presenter.product!)
        }
    }
    
    func cancel() {
        refreshDataAfterUpdate()
    }
    
    func imageTapped() {
        presenter.showActionSheet(image: image, picker: imagePicker)
    }
    
    func showFullScreenImages() {
        // check true if you want see trash button and page control
        presenter.openPhotoPreview(images: self.image.image, isEditMode: false)
    }
    
    func addXibOnView(view: UIView) {
        userInformationXib = view
        userInformationXib?.frame = CGRect.init(x: 0, y: 0, width: userInformation.frame.width, height: userInformation.frame.height)
        userInformation.addSubview(userInformationXib!)
    }
    
    
    
    @IBAction func changeLikeStatus(_ sender: Any) {
        presenter.changeLike(like: like)
    }
    
    func updateData(product: Product) {
        self.navigationItem.title = product.title
        postDescription.text = product.description
        postTitle.text = product.title
        presenter.addImageWithOrientation(imageView: image, imageUrl: product.mainImage, imageHeight: self.view.frame.width, imageViewHeight: imageHeight)
        date.text = product.date
    }
}

// MARK: - KitFolioDetailedViewInput

extension KitFolioDetailedViewController: KitFolioDetailedViewInput {
    
    func updateProduct(product: Product, user: User?) {
        presenter.checkUserInformation(xib: userInformationXib!, user: user!)
        updateData(product: product)
    }
    
    func presentAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.gray
    }
    
    func presentPicker() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        showAlertWithTitle(title, message: message)
    }
    
    func showSuccessAlert(title: String, message: String, action: [UIAlertAction]) {
        showAlertWithTitle(title, message: message, actions: action)
    }
}

extension KitFolioDetailedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        if abs((editedImage?.size.width)! - (editedImage?.size.height)!) > 50 {
            editedImage = UIImage().RBSquareImageTo(image: editedImage!, size: CGSize(width: 500, height: 500))
        }
        presenter.cropImage(editedImage: editedImage, originalImage: originalImage)
        if let bigImage = presenter.bigImage {
            image.image = bigImage
        } else {
            image.image = originalImage
        }
        let height = self.view.frame.size.width
        imageHeight.constant = height
        image.frame.size.height = height
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        presenter.imageChange = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension KitFolioDetailedViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.title = textView.text
    }
}
