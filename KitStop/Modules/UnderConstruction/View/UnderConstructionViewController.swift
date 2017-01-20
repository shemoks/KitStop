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
    }

    @IBAction func moveToRoot(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.objects(User.self).filter("online = %s", true).first?.online = false
        }
        KeychainService().clearToken()
        logoutFromFacebook()
//        var containsViewController = false
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller is SignUpViewController {
//                let _ = self.navigationController?.popToViewController(controller, animated: true)
//                containsViewController = true
//                break
//            }
//        }
//        if !containsViewController {
//            let signUpViewController = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "SignUp")
//            let _ = self.navigationController?.popToViewController(signUpViewController, animated: true)
//        }
        self.dismiss(animated: true, completion: nil)
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
