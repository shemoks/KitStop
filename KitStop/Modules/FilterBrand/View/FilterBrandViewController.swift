//
//  FilterBrandViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterBrandViewController

final class FilterBrandViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: FilterBrandViewOutput!

}

// MARK: - FilterBrandViewInput

extension FilterBrandViewController: FilterBrandViewInput {

}
