//
//  UserInformationViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Cosmos
import SDWebImage

// MARK: - UserInformationViewController

final class UserInformationViewController: UIView {

    @IBOutlet weak var star: CosmosView!
    @IBOutlet weak var avatar: CustomAvatar!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    // MARK: - VIPER stack

    var presenter: UserInformationViewOutput!

    override func awakeFromNib() {
        presenter.getUserInfo()
    }
}

// MARK: - UserInformationViewInput

extension UserInformationViewController: UserInformationViewInput {
    
    func showUser(user: [String : String]) {
        name.text = "\(user["name"]!) \(user["surname"]!)"
        country.text = user["country"]!
        let url = URL.init(string: user["avatar"]!)
        avatar.sd_setImage(with: url!)
    }
}
