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
    
    case login()
    case signUp()
    case forgot()
    case fbAuthenticate()
    case test()
    
    // MARK: - Public Properties
    var httpMethod: Alamofire.HTTPMethod{
        switch self {
        case .login:
            return .post
        case .signUp:
            return .post
        case .fbAuthenticate:
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
        case .fbAuthenticate:
            return "fb-authenticate"
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
        case .fbAuthenticate:
            return baseUrl.appendingPathComponent(path)
        default:
            return baseUrl
        }
    }
}
