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

protocol AuthServiceDelegate: class {
    func handleNewAuthStatus(_ status: AuthStatus)
}

protocol AuthServiceProtocol {
    var delegate: AuthServiceDelegate? { get set }
    var authStatus: AuthStatus { get }
    func getToken(completion: @escaping (Result<String, AuthError>) -> Void)
}

protocol AuthUIProvider {
    var authViewController: UIViewController { get }
}

class FirebaseAuthService: NSObject, AuthServiceProtocol, FUIAuthDelegate, AuthUIProvider {
    lazy var authViewController: UIViewController = { [weak self] in
        return authUI.authViewController()
    }()
    
    weak var delegate: AuthServiceDelegate?
    
    var authStatus: AuthStatus = .unknown {
        didSet {
            delegate?.handleNewAuthStatus(authStatus)
        }
    }
    
    private var user: FirebaseAuth.User?
    
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
            authStatus = .error(.unknown(error))
            return
        }
        
        guard let result = authDataResult else {
            authStatus = .error(.unknown(nil))
            return
        }
        
        user = result.user
    }
    
    func setAuthStatus(from auth: FirebaseAuth.Auth) {
        authStatus = auth.currentUser == nil ? .unauthenticated : .authenticated
        
        if auth.currentUser != nil {
            getToken { (result) in
                if case let .success(token) = result {
                    print(token)
                }
            }
        }
    }
    
    func getToken(completion: @escaping (Result<String, AuthError>) -> Void) {
        guard let user = user else {
            completion(.failure(.unauthenticated(nil)))
            return
        }
        
        user.getIDToken(completion: { (token, error) in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let token = token else {
                completion(.failure(.unknown(nil)))
                return
            }
            
            completion(.success(token))
        })
    }
}
