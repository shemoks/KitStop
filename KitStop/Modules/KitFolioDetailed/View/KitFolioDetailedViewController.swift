//
//  KitFolioDetailedViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioDetailedViewController


final class KitFolioDetailedViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: KitFolioDetailedViewOutput!
    
    @IBOutlet weak var postDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var userInformation: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var toolbarContainer: UIView!
    fileprivate var userInformationXib: UIView?
    fileprivate var toolBar: UIView?
 //   var context: UIViewController
    
    override func viewDidLoad() {
        presenter.checkXib(view: UIView.loadFromNibNamed(nibNamed: "UserInformation"))
        presenter.checkToolBar(view: UIView.loadFromNibNamed(nibNamed: "BottomBar"))
        presenter.handleKitData()
        
        self.navigationItem.rightBarButtonItem = presenter.updateData(xib: userInformationXib!) ?          UIBarButtonItem.init(image: UIImage.init(named: "edit_icon"), style: .done, target: self, action: #selector(editKitFolio)) : UIBarButtonItem.init(image: UIImage.init(named: "Conv"), style: .done, target: self, action: #selector(openChatModule))
    }
    
    @objc func openChatModule() {
        presenter.openChat()
    }
    
    @objc func editKitFolio() {
        
    }
    
    func addXibOnView(view: UIView) {
        userInformationXib = view
        userInformationXib?.frame = CGRect.init(x: 0, y: 0, width: userInformation.frame.width, height: userInformation.frame.height)
        userInformation.addSubview(userInformationXib!)
    }
    
    func addToolBar(toolBar: UIView) {
        self.toolBar = toolBar
        self.toolBar?.frame = CGRect.init(x: 0, y: 0, width: toolbarContainer.frame.width, height: toolbarContainer.frame.height)
        toolbarContainer.addSubview(toolBar)
    }
}

// MARK: - KitFolioDetailedViewInput

extension KitFolioDetailedViewController: KitFolioDetailedViewInput {
    
    func updateProduct(product: Product, user: User?) {
        presenter.checkUserInformation(xib: userInformationXib!, user: user!)
        self.navigationItem.title = product.title
        postDescription.text = product.description
        presenter.addImageWithOrientation(imageView: image, imageUrl: product.mainImage, imageHeight: self.view.frame.width)
        date.text = product.date
        
        // change size textView to its content
        postDescription.sizeToFit()
        postDescriptionHeight.constant = postDescription.contentSize.height
    }
}
