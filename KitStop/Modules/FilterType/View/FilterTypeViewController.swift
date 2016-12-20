//
//  FilterTypeViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterTypeViewController

final class FilterTypeViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: FilterTypeViewOutput!

}

// MARK: - FilterTypeViewInput

extension FilterTypeViewController: FilterTypeViewInput {

}
