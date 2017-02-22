//
//  KitFolioCreateViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreateViewController


final class KitFolioCreateViewController: UIViewController, FlowController, SelectImageContainerProtocol, Alertable {
    


    @IBOutlet weak var postTitle: MyTextView!
    @IBOutlet weak var postDescription: MyTextView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var userInformation: UIView!
    // MARK: - VIPER stack

    var presenter: KitFolioCreateViewOutput!
    fileprivate var userInformationXib: UIView?
    fileprivate var small: UIImage?
    fileprivate var big: UIImage?
    fileprivate let placeholderLabel = UILabel()
    fileprivate let imagePicker = UIImagePickerController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        addUserInformation()
    }

    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_orange_button"), style: .plain, target: self, action: #selector(back))
    }

    func back() {
        presenter.openMainModule()
    }

    override func viewDidLoad() {
        postTitle.delegate = self
        postDescription.delegate = self
        postTitle.tag = 100
        addTextViewPlaceholder()
    }
    
    func addTextViewPlaceholder() {
        postTitle.placeholderLabel.textColor = UIColor().hexStringToUIColor(hex: Color.placeholderText)
        postTitle.placeholderLabel.alpha = 0.5
        postTitle.placeholderLabel.text = "Enter short description"
        postDescription.placeholderLabel.textColor =  UIColor().hexStringToUIColor(hex: Color.placeholderText)
        postDescription.placeholderLabel.alpha = 0.5
        postDescription.placeholderLabel.text = "Tell the community about this photograph"
    }

    func addUserInformation() {
        presenter.checkXib(view: UIView.loadFromNibNamed(nibNamed: "UserInformation"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let container = segue.destinationViewController(ofType: SelectImageViewController.self)
        container?.delegate = self
    }
    
    func changeContainer(_ height: CGFloat) {
        containerHeight.constant = height
    }
    
    @IBAction func save(_ sender: Any) {
        view.endEditing(true)
        presenter.saveKitFolio(postTitle: postTitle.text!, postDescription: postDescription.text!, smallImage: self.small, bigImage: self.big)
    }
    
    func passImage(small: UIImage, big: UIImage) {
        self.small = small
        self.big = big
    }
    
}

// MARK: - KitFolioCreateViewInput

extension KitFolioCreateViewController: KitFolioCreateViewInput {
    func addXibOnView(view: UIView) {
        userInformationXib = view
        (userInformationXib as! UserInformationViewController).updateUser(user: nil)
        userInformationXib?.frame = CGRect.init(x: 0, y: 0, width: userInformation.frame.width, height: userInformation.frame.height)
        userInformation.addSubview(userInformationXib!)
    }
    
    func showAlert(title: String, message: String) {
        showAlertWithTitle(title, message: message)
    }
    
    func showAlert(title: String, message: String, action: [UIAlertAction]) {
        showAlertWithTitle(title, message: message, actions: action)
    }
}

extension KitFolioCreateViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var limitLength = 100
        if textView == postDescription {
            limitLength = 500
        }
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.characters.count
        return numberOfChars < limitLength;
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == postTitle {
            self.navigationItem.title = postTitle.text
        }
    }
}
