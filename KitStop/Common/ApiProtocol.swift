//
//  ApiProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 20.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

protocol ApiManagerProtocol {
    func apiRequest(_ endpoint: Endpoint, parameters: [String : Any]?, headers: [String : String]?) -> ApiRequestProtocol
    func cancelAllRequest()
}

extension ApiManagerProtocol {
    func apiRequest(_ endpoint: Endpoint) -> ApiRequestProtocol {
        return apiRequest(endpoint, parameters: [:], headers: [:])
    }
    
    func apiRequest(_ endpoint: Endpoint, parameters: [String : AnyObject]?) -> ApiRequestProtocol {
        return apiRequest(endpoint, parameters: parameters, headers: nil)
    }
    
}

protocol ApiRequestProtocol {
    func apiResponse(completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self
}

func += <K, V> ( left: inout [K : V], right: [K : V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

extension SessionManager: ApiManagerProtocol {
    func apiRequest(_ endpoint: Endpoint, parameters: [String : Any]? = nil, headers: [String : String]? = nil) -> ApiRequestProtocol {
        // Insert your common headers here, for example, authorization token or accept.
        var commonHeaders = ["Accept" : "application/json"]
        let tokenService = Keychain(service: "com.mozidev.KitStop").accessibility(.alwaysThisDeviceOnly)
            .synchronizable(false)
        do {
            let token = try tokenService.getString("api_token")
            if let token = token {
                commonHeaders += ["x-api-token" : token]
            }
        } catch is Error {
            print("no token")
        }
        
        return request(endpoint.url, method: endpoint.httpMethod, parameters: parameters, encoding: endpoint.encoding , headers: commonHeaders)
    }
    
    func cancelAllRequest() {
        self.session.getAllTasks(completionHandler: {
            task in
            task.forEach({
                $0.cancel()
            })
        })
    }
}

extension Alamofire.DataRequest: ApiRequestProtocol {
    static func apiResponseSerializer() -> DataResponseSerializer<JSON> {
        return DataResponseSerializer { _, _, data, error in
            if let error = error {
                return .failure(error)
            }
            
            guard let validData = data else {
                let reason = "Data could not be serialized. Input data was nil."
                return .failure(NSError(domain: "my domain", code: 1001, userInfo: [NSLocalizedDescriptionKey : reason]))
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                // TODO: Should consider HTTP response as well.
                return sanitizeError(json: JSON(json))
            } catch let error as NSError {
                return .failure(error)
            }
        }
    }
    
    static func sanitizeError(json: JSON) -> Result<JSON> {
        if json["error"].array == nil {
            return .success(json)
        }
        
        let code = json["error"]["code"].intValue
        let message = json["error"]["message"].stringValue
        let error = NSError(domain: "my domain", code: code, userInfo: [NSLocalizedDescriptionKey : message])
        return .failure(error)
    }
    
    func apiResponse(completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.apiResponseSerializer(), completionHandler: completionHandler)
    }
}
