//
//  LogInViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - LogInViewController

final class LogInViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: LogInViewOutput!

}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {

}
