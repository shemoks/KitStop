//
//  RegistrationViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, FlowController, UIGestureRecognizerDelegate {

    // MARK: - VIPER stack

    @IBOutlet weak var imageView: CustomAvatar!
    var presenter: RegistrationViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationController?.navigationBar.isHidden = true
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        tapImageView.delegate = self
        // tapImageView.cancelsTouchesInView = false
        imageView.addGestureRecognizer(tapImageView)
    }

    func takePhoto(_ gestureRecognizer: UITapGestureRecognizer) {
        presenter.takePhoto()
    }

    @IBAction func unwindFromImagePisker(_ segue: UIStoryboardSegue) {

    }

}

// MARK: - RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput {

    func getPhoto(photo: UIImage) {
        imageView.image = photo
    }
    
}
