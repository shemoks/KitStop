//
//  KitFolioCreateViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreateViewController


final class KitFolioCreateViewController: UIViewController, FlowController, SelectImageContainerProtocol {
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var userInformation: UIView!
    // MARK: - VIPER stack

    var presenter: KitFolioCreateViewOutput!
    fileprivate var userInformationXib: UIView?

    override func viewDidLoad() {
        addUserInformation()
        navigationController?.navigationBar.tintColor = .black
    }
    
    func addUserInformation() {
        userInformationXib = UIView.loadFromNibNamed(nibNamed: "UserInformation")
        userInformationXib?.frame = CGRect.init(x: 0, y: 0, width: userInformation.frame.width, height: userInformation.frame.height)
        userInformation.addSubview(userInformationXib!)
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
    
    
}

// MARK: - KitFolioCreateViewInput

extension KitFolioCreateViewController: KitFolioCreateViewInput {

}
