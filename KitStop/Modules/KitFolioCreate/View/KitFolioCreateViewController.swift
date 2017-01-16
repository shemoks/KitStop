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
    @IBOutlet weak var postDescription: UITextField!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var userInformation: UIView!
    // MARK: - VIPER stack

    var presenter: KitFolioCreateViewOutput!
    fileprivate var userInformationXib: UIView?
    fileprivate var small: UIImage?
    fileprivate var big: UIImage?

    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = .black
        postTitle.delegate = self
        postDescription.delegate = self
        postTitle.tag = 100
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
    
}

// MARK: - KitFolioCreateViewInput

extension KitFolioCreateViewController: KitFolioCreateViewInput {
    func addXibOnView(view: UIView) {
        userInformationXib = view
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

extension KitFolioCreateViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var limitLength = 0
        if textField.tag == 100 {
            limitLength = 100
        } else {
            limitLength = 500
        }
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
}
