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
    case passwordConfirmationFailed = 10002
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
            return "User not found"
        case .userAlreadyExists:
            return "Entered e-mail is already taken"
        case .kitFolioValidationFailed:
            return "Please fill in all required fields"
        case .passwordIsNotProvided:
            return "Invalid e-mail or password"
        case .valueIsNotProvided:
            return "Invalid e-mail or password"
        case .passwordConfirmationFailed:
            return "Passwords do not match."
        case .unexpectedError:
            return "Unexpected error has occured"
        }
    }
}
