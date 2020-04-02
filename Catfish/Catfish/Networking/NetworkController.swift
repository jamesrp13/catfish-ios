//
//  NetworkController.swift
//  Catfish
//
//  Created by morse on 3/31/20.
//  Copyright © 2020 James Pacheco. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case badDecode
    case badEncode
    case noData
}

enum HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
}

class NetworkController {

    // MARK: - Properties

    var userController: UserController?
    var authService: AuthServiceProtocol
    private let baseURL = URL(string: "URL HERE!!!")!
    let cache = NSCache<NSString, UIImage>()
    let method: String = HTTPMethod.post
    
    // MARK: - Lifecycle Methods
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Posts
    
    func sendPostToServer(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let postJSON = encode(item: post) else {
            completion(.failure(NetworkError.badEncode))
            return
        }
        var request = postURL(from: baseURL, method: HTTPMethod.post)
        request.httpBody = postJSON
        
        perform(request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                // Not sure what data we get back here
                print(String(data: data, encoding: .utf8)!)
            }
        }
    }

    // MARK: - User

    func register(with username: String, password: String, email: String, completion: @escaping (Result<User, Error>) -> Void) {
        let userToRegister = createUserJSON(username, password, and: email)
        let token = ""// authService.getToken(completion: <#T##(Result<String, AuthError>) -> Void#>)
        var request = userURL(from: baseURL, method: HTTPMethod.post, token: token)
        request.httpBody = userToRegister
        
        perform(request) { result in
            switch result {
            case .failure(let error):
                print("Register error: \(error)")
                completion(.failure(error))
            case .success(let data):
                // This is not actually going to be a user, it will be 
                guard let returnedUser: ReturnedUser = self.decode(data: data) else {
                    completion(.failure(NetworkError.badDecode))
                    return
                }
                let user = User(username: username, password: password, email: email, id: returnedUser.id, token: returnedUser.token)
                self.userController?.user = user
            }
        }
    }

    private func createUserJSON(_ username: String, _ password: String, and email: String) -> Data? {
        let json = """
        {
        "username": "\(username)",
        "password": "\(password)",
        "email": "\(email)"
        }
        """

        let jsonData = json.data(using: .utf8)
        guard let unwrappedJSON = jsonData else {
            print("No data!")
            return nil
        }
        return unwrappedJSON
    }

    // MARK: - Helper Methods

    private func perform(_ request: URLRequest, session: URLSession = URLSession.shared, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in

            if let error = error {
                print("NetworkController.fetch Error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("NetworkController.fetch Data is wrong")
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }

    private func decode<T: Codable>(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        do {
            let decoded = try jsonDecoder.decode(T.self, from: data)
            return decoded
        } catch {
            print("Error decoding item from data: \(error)")
            print(String(data: data, encoding: .utf8)!)
            return nil
        }
    }

    private func encode<T: Codable>(item: T) -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        do{
            let encoded = try jsonEncoder.encode(item)
            return encoded
        } catch {
            print("Error encoding item from data: \(error)")
            return nil
        }
    }
    
    func userURL(from url: URL, method: String, token: String) -> URLRequest {
        let url = url
            .appendingPathComponent("user")
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func postURL(from url: URL, method: String) -> URLRequest {
        let url = url
            .appendingPathComponent("post")
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
