//
//  UserInformationViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UserInformationViewController

final class UserInformationViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: UserInformationViewOutput!

}

// MARK: - UserInformationViewInput

extension UserInformationViewController: UserInformationViewInput {

}
