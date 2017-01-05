//
//  UnderConstructionViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UnderConstructionViewController

final class UnderConstructionViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: UnderConstructionViewOutput!
    
    override func viewDidLoad() {
     
    }

}

// MARK: - UnderConstructionViewInput

extension UnderConstructionViewController: UnderConstructionViewInput {

}
