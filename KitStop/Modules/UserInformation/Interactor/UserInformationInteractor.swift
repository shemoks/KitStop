//
//  UserInformationInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - UserInformationInteractor

final class UserInformationInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: UserInformationInteractorOutput!
    fileprivate var dataManager: LogInDataManagerProtocol?
    // MARK: -
    
    init(dataManager: LogInDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: LogInDataManager())
    }
    
}

// MARK: - UserInformationInteractorInput

extension UserInformationInteractor: UserInformationInteractorInput {
    
    func fetchUser(user: User?) {
        let userModel = dataManager?.getUserFromRealm()
        if user != nil {
            if user?.id != userModel?.id {
                let userData: [String : String] = ["name" : user!.name,
                                                   "surname" : user!.surname,
                                                   "avatar" : user!.avatar! == "<null>" ? "" : user!.avatar!,
                                                   "country" : "USA"]
                presenter.showUser(user: userData)
            } else {
                loadUserFromRealm(userModel: userModel)
            }
        } else {
            loadUserFromRealm(userModel: userModel)
        }
    }
    
    func loadUserFromRealm(userModel: User?) {
        if userModel != nil {
            let userData: [String : String] = ["name" : userModel!.name,
                                               "surname" : userModel!.surname,
                                               "avatar" : userModel!.avatar! == "<null>" ? "" : userModel!.avatar!,
                                               "country" : userModel!.country!]
            presenter.showUser(user: userData)
        }
    }
    
}
