//
//  ApiResult.swift
//  KitStop
//
//  Created by sasha ataman on 20.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

enum ApiResult<Value> {
    case success(value: Value)
    case failure(error: NSError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as NSError {
            self = .failure(error: error)
        }
    }
    
    func unwrap() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
