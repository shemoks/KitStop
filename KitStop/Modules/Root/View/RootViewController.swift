//
//  RootViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RootViewController

final class RootViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: RootViewOutput!

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        presenter.handleViewDidload()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.navigationController!.viewControllers as Array).count == 1 {
            let storyboard = UIStoryboard(name: "Signup", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "SignUp")
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
// MARK: - RootViewInput

extension RootViewController: RootViewInput {

}
