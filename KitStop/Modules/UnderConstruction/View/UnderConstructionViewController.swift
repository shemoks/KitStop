//
//  UnderConstructionViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import RealmSwift
import FBSDKLoginKit

// MARK: - UnderConstructionViewController

final class UnderConstructionViewController: UIViewController, FlowController {

    // MARK: - VIPER stack
    fileprivate var buttonStatus = false
    @IBOutlet weak var logOut: UIButton!
    var presenter: UnderConstructionViewOutput!
    
    override func viewDidLoad() {
        if buttonStatus {
            logOut.isHidden = false
        }
        if tabBarController?.selectedIndex == 4 {
            logOut.isHidden = false
        }
    }

    @IBAction func moveToRoot(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.objects(User.self).filter("online = %s", true).first?.online = false
        }
        FilterManager().deleteAllFilters()
        KeychainService().clearToken()
        logoutFromFacebook()
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = true
        }
        if !logOut.isHidden {
            presenter.logOut()
        } else {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func logoutFromFacebook() {
        if FBSDKAccessToken.current() != nil {
            FBSDKLoginManager().logOut()
        }
    }
    
}

// MARK: - UnderConstructionViewInput

extension UnderConstructionViewController: UnderConstructionViewInput {
    func addLogOut() {
        self.buttonStatus = true
    }
}
