//
//  CustomInputViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputViewController

final class CustomInputViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: CustomInputViewOutput!

}

// MARK: - CustomInputViewInput

extension CustomInputViewController: CustomInputViewInput {

}
