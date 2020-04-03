//
//  AuthEnums.swift
//  Catfish
//
//  Created by James Pacheco on 4/1/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import Foundation

enum AuthStatus {
    case unknown, authenticated, unauthenticated
    case error(AuthError)
}

enum Response<T, U: Error> {
    case success(T)
    case failure(U)
}

enum AuthError: Error {
    case unknown(Error?)
    case unauthenticated(Error?)
    
    var userMessage: String {
        switch self {
        case .unknown:
            return Strings.unknownAuthErrorMessage
        case .unauthenticated:
            return Strings.unauthenticatedErrorMessage
        }
    }
}

fileprivate struct Strings {
    static let unknownAuthErrorMessage = NSLocalizedString("There was an unknown problem with verifying your identity. Please try logging out and signing in again.", comment: "")
    static let unauthenticatedErrorMessage = NSLocalizedString("You are not signed in.", comment: "")
}
