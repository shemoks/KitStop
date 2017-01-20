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
    
    @IBOutlet weak var scrollBottom: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var postTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var postTitle: UITextView!
    @IBOutlet weak var postDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userInformation: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var cancelContainer: UIView!
    
    fileprivate var userInformationXib: UIView?
    fileprivate var toolBar: UIView?
    fileprivate let imagePicker = UIImagePickerController()
    fileprivate var viewRec: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        presenter.checkXib(view: UIView.loadFromNibNamed(nibNamed: "UserInformation"))
        presenter.handleKitData()
        
        self.navigationItem.rightBarButtonItem = presenter.updateData(xib: userInformationXib!) ?          UIBarButtonItem.init(image: UIImage.init(named: "edit_icon"), style: .done, target: self, action: #selector(editKitFolio)) : UIBarButtonItem.init(image: UIImage.init(named: "Conv"), style: .done, target: self, action: #selector(openChatModule))
        // add image picker
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
        
        viewRec = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    }
    
    @objc func openChatModule() {
        presenter.openChat()
    }
    
    @objc func editKitFolio() {
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(save))
        viewRec?.numberOfTapsRequired = 1
        viewRec?.numberOfTouchesRequired = 1
        postTitle.isEditable = true
        postDescription.isEditable = true
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(viewRec!)
        cancelContainer.isHidden = false
        cancelContainer.alpha = 1
        scrollBottom.constant = 49
    }
    
    func save() {
        // save changes
        let data: [String : String] = ["title" : postTitle.text, "description" : postDescription.text]
        presenter.validation(data: data, image: image.image!)
    }
    
    @IBAction func deletePost(_ sender: Any) {
        // delete post
        let yes = UIAlertAction.init(title: "Yes", style: .default, handler: {
            result in
            self.presenter.deletePost()
        })
        let no = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
        showAlertWithTitle("Delete", message: "Are you sure to delete this item?", actions: [yes, no])
        
    }
    
    func refreshDataAfterUpdate() {
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem.init(image: UIImage.init(named: "edit_icon"), style: .done, target: self, action: #selector(editKitFolio))
        postTitle.isEditable = false
        postDescription.isEditable = false
        image.isUserInteractionEnabled = false
        image.removeGestureRecognizer(viewRec!)
        cancelContainer.isHidden = true
        cancelContainer.alpha = 0
        scrollBottom.constant = 0
        if presenter.product != nil {
            updateData(product: presenter.product!)
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        // cancel
        refreshDataAfterUpdate()
    }
    
    func imageTapped() {
        presenter.showActionSheet(image: image, picker: imagePicker)
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
        presenter.addImageWithOrientation(imageView: image, imageUrl: product.mainImage, imageHeight: self.view.frame.width)
        imageHeight.constant = self.view.frame.width
        date.text = product.date
        
        // change size textView to its content
        postDescription.sizeToFit()
        postDescriptionHeight.constant = postDescription.contentSize.height
        postTitle.sizeToFit()
        postTitleHeight.constant = postTitle.contentSize.height
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
        let pickedImage: UIImage?
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        if ( editedImage != nil ) {
            pickedImage = editedImage
        } else {
            pickedImage = originalImage
        }
        presenter.cropImage(editedImage: editedImage, originalImage: originalImage)
        let newHeight = pickedImage?.heightWithOrientation(contentHeight: self.view.frame.size.width / 2)
        imageHeight.constant = newHeight!
        image.image = originalImage
        image.frame.size.height = newHeight!
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        presenter.imageChange = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
