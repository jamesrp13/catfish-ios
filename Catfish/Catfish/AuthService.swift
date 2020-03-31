//
//  AuthService.swift
//  Catfish
//
//  Created by James Pacheco on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI

enum AuthStatus {
    case unknown, authenticated, unauthenticated
}

enum Response<T, U: Error> {
    case success(T)
    case failure(U)
}

enum AuthError: Error {
    case unknown
}

protocol AuthServiceDelegate: class {
    func handleNewAuthStatus(_ status: AuthStatus)
}

protocol AuthServiceProtocol {
    var authViewController: UIViewController { get }
    var delegate: AuthServiceDelegate? { get set }
    var authStatus: AuthStatus { get }
}

class FirebaseAuthService: NSObject, AuthServiceProtocol, FUIAuthDelegate {
    lazy var authViewController: UIViewController = { [weak self] in
        return authUI.authViewController()
    }()
    
    weak var delegate: AuthServiceDelegate?
    
    var authStatus: AuthStatus = .unknown {
        didSet {
            delegate?.handleNewAuthStatus(authStatus)
        }
    }
    
    private var authUI: FUIAuth
    
    override init() {
        authUI = FUIAuth.defaultAuthUI()!
        
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth(),
          FUIOAuth.appleAuthProvider(),
        ]
        
        authUI.providers = providers
        
        super.init()
        
        authUI.delegate = self
        
        guard let auth = authUI.auth else { return }
        setAuthStatus(from: auth)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        
        print(authDataResult?.user ?? "")
        print(authDataResult?.additionalUserInfo ?? "")
        print(authDataResult?.credential ?? "")
    }
    
    func setAuthStatus(from auth: FirebaseAuth.Auth) {
        authStatus = auth.currentUser == nil ? .unauthenticated : .authenticated
    }
}
