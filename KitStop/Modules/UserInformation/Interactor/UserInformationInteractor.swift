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
    
    func fetchUser() {
        if let user = dataManager?.getUserFromRealm() {
            let userData: [String : String] = ["name" : user.name,
                            "surname" : user.surname,
                            "avatar" : user.avatar! == "<null>" ? "https://s3.amazonaws.com/kitstop/UserPhoto/profile_photo.png" : user.avatar!,
                            "country" : user.country!]
            presenter.showUser(user: userData)
        }
    }
    
}
