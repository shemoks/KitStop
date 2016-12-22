//
//  Endpoint.swift
//  KitStop
//
//  Created by sasha ataman on 20.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {
    
    static let baseURL = URL(string: "http://34.194.202.148:8443/api/v1")!
    
    case login(email: String, password: String, clients: String)
    case signUp(email: String, password: String, clients: String, photoUrl: String?)
    case forgot(email: String)
    case test()
    
    // MARK: - Public Properties
    var httpMethod: Alamofire.HTTPMethod{
        switch self {
        case .login:
            return .post
        case .signUp:
            return .post
        default:
            return .get
        }
    }
    
    fileprivate var path: String {
        switch self {
        case .login:
            return "/authenticate"
        case .forgot:
            return "/forgot"
        case .signUp:
            return "/sign-up"
        default:
            return ""
        }
    }

    
    var url: URL {
        let baseUrl = Endpoint.baseURL
        switch self {
        case .login:
            return baseUrl.appendingPathComponent(path)
        case .signUp:
            return baseUrl.appendingPathComponent(path)
        case .forgot:
            return baseUrl.appendingPathComponent(path)
        default:
            return baseUrl
        }
    }
    
    var body: String? {
        switch self {
        case let .login(email, password, _):
            return "email=\(email)&password=\(password)&clients=111"
        case let .signUp(email, password, _, photoUrl):
            if let photoUrl = photoUrl {
                return "email=\(email)&password=\(password)&clients=111&photoUrl=\(photoUrl)"
            }
            return "email=\(email)&password=\(password)&clients=111"
        default:
            return nil
        }
    }
}
