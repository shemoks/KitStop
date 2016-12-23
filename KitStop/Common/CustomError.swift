//
//  ErrorHandler.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/21/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

public enum CustomError: Int, Error {
    case success = 100000
    case noConnection = 100001
    case facebookFailed = 100002
    case serverError = 100003
    case notFound = 100004
    case unexpectedError = 100005
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
            case .success:
                return "No error."
            case .noConnection:
                return "There seems to be a network problem"
            case .facebookFailed:
                return "Login with Facebook failed. Please Try again"
            case .serverError:
                return "Could not connect to server"
            case .notFound:
                return "A problem has occured"
            case .unexpectedError:
                return "Unexpected error has occured"
        }
    }
}
