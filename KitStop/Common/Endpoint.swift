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
    case createKitFolio()
    case getKitFolio()
    case getKits()
    case getKitsForSale()
    case categories()
    case forSaleFilter()
    case kitsFilter()
    case price()
    case getCategory()
    case fbAuthenticate()
    case createKit()
    
    // MARK: - Public Properties
    var httpMethod: Alamofire.HTTPMethod{
        switch self {
        case .login:
            return .post
        case .signUp:
            return .post
        case .createKitFolio:
            return .post
        case .fbAuthenticate():
            return .post
        case .createKit:
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
        case .createKitFolio, .getKitFolio:
            return "/kit-folio"
        case .getKits, .kitsFilter():
            return "/kits"
        case .getKitsForSale, .forSaleFilter():
            return "/kits-for-sale"
        case .categories:
            return "/category"
        case .price:
            return "/filters"
        case .getCategory():
            return "/category"
        case .fbAuthenticate:
            return "/fb-authenticate"
        case .createKit:
            return "/kits"
        }
       
    }

    
    var url: URL {
        let baseUrl = Endpoint.baseURL
        return baseUrl.appendingPathComponent(path)
    }
}
