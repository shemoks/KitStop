//
//  ErrorHandler.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/21/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

public enum CustomError: Int, Error {
    case noConnection = -1009
    case success = 200
    case valueIsNotProvided = 400
    case notFound = 404
    case kitFolioValidationFailed = 409
    case passwordIsNotProvided = 412
    case userAlreadyExists = 422
    case facebookFailed = 10000
    case unexpectedError = 10001
}

extension CustomError: RawRepresentable, CustomStringConvertible {
    public init(code: Int) {
        if let mappedError = CustomError(rawValue: code) {
            self = mappedError
        } else {
            self =  .unexpectedError
        }
    }
    
    public var description: String {
        switch self {
        case .noConnection:
            return "Network connection is unavailable"
        case .success:
            return "No error."
        case .facebookFailed:
            return "Login with Facebook failed. Please Try again"
        case .notFound:
            return "not found"
        case .userAlreadyExists:
            return "User with such email is already registered"
        case .kitFolioValidationFailed:
            return "Please fill out all required fields"
        case .passwordIsNotProvided:
            return "Invalid email or password"
        case .valueIsNotProvided:
            return "Invalid email or password"
        case .unexpectedError:
            return "Unexpected error has occured"
        }
    }
}
