//
//  SelectCategoryViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectCategoryViewController

final class SelectCategoryViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: SelectCategoryViewOutput!

}

// MARK: - SelectCategoryViewInput

extension SelectCategoryViewController: SelectCategoryViewInput {

}
