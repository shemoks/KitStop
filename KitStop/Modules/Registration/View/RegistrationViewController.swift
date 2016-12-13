//
//  RegistrationViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationViewController

final class RegistrationViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: RegistrationViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput {

}
