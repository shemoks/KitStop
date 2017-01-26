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
    
  //  static let baseURL = URL(string: "http://34.194.202.148:8443/api/v1")!
    static let baseURL = URL(string: "http://34.198.24.119:8443/api/v1")!
    
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
    case getStructureOfCategory(id: String)
    case fbAuthenticate()
    case kitFolioDetailed(id: String)
    case createKit()
    case viewKitByOwner(idKit: String)
    case viewKitForSale(idKit: String)
    case deleteKitFolio(id: String)
    case saveKitFolio(id: String)
    case removeKit(idKit: String)
    case removeKitForSale(idKit: String)
    
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
        case .deleteKitFolio:
            return .delete
        case .removeKit:
            return .delete
        case .removeKitForSale:
            return .delete
        case .saveKitFolio:
            return .patch
        default:
            return .get
        }
    }
    
    fileprivate var path: String {
        switch self {
        case .login:
            return "/authenticate"
        case .forgot:
            return "/forgot-password"
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
        case .getStructureOfCategory(let id):
            return ("/category/" + id)
        case .fbAuthenticate:
            return "/fb-authenticate"
        case let .kitFolioDetailed(id) :
            return "/kit-folio/\(id)"
        case .createKit:
            return "/kits"
        case .viewKitByOwner(let idKit):
            return ("/kits/" + idKit)
        case .deleteKitFolio(let id):
            return "/kit-folio/\(id)"
        case .saveKitFolio(let id):
            return "/kit-folio/\(id)"
        case .viewKitForSale(let idKit):
            return ("/kits-for-sale/" + idKit)
        case .removeKit(let idKit):
            return ("/kits/" + idKit)
        case .removeKitForSale(let idKit):
            return ("/kits-for-sale/" + idKit)
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .createKitFolio(), .createKit(), .saveKitFolio:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }

    
    var url: URL {
        let baseUrl = Endpoint.baseURL
        return baseUrl.appendingPathComponent(path)
    }
}
