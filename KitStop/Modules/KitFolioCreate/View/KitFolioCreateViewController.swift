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
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDescription: UITextView!
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

    override func viewDidLoad() {
        postTitle.delegate = self
        postDescription.delegate = self
        postTitle.tag = 100
        addPlaceholderFromDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addUserInformation()
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
    
    @IBAction func postTitleChange(_ sender: Any) {
            self.navigationItem.title = postTitle.text
    }
    
    
    @IBAction func save(_ sender: Any) {
        view.endEditing(true)
        presenter.saveKitFolio(postTitle: postTitle.text!, postDescription: postDescription.text!, smallImage: self.small, bigImage: self.big)
    }
    
    func passImage(small: UIImage, big: UIImage) {
        self.small = small
        self.big = big
    }
    
    func addPlaceholderFromDescription() {
        if postDescription.text == "" || postDescription.text == PlaceholderText.kitfolioDescriptionText {
            postDescription.textColor = UIColor.init(red: 151/255, green: 153/255, blue: 155/255, alpha: 0.5)
            postDescription.text = PlaceholderText.kitfolioDescriptionText
        }
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

extension KitFolioCreateViewController : UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limitLength = 100
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.characters.count
        return numberOfChars < 500;
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !validation(data: postDescription.text) {
            postDescription.textColor = UIColor.init(red: 151/255, green: 153/255, blue: 155/255, alpha: 0.5)
            postDescription.text = PlaceholderText.kitfolioDescriptionText
        }
        postDescription.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postDescription.text == PlaceholderText.kitfolioDescriptionText {
            postDescription.text = ""
            postDescription.textColor = UIColor.black
        }
        postDescription.becomeFirstResponder()
    }
    func validation(data: String) -> Bool {
        let newData = data.trimmingCharacters(in: .whitespaces)
        if data.characters.count > 0 && newData.characters.count > 0 {
            return true
        }
        return false
    }
}
